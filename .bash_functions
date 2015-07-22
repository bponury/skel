#!/bin/bash
# defines global-wide useful functions

# defines color-arrays to use
unset _c
declare -A _c
unset __c
declare -A __c

_c[reset]="\033[0;0m"
_c[red]="\033[0;31m"
_c[green]="\033[0;32m"
_c[yellow]="\033[0;33m"
_c[blue]="\033[0;34m"
_c[pink]="\033[0;35m"
_c[cyan]="\033[0;36m"
_c[white]="\033[0;37m"

# creates "bold" colors
function _c_boldify {
	for k in ${!_c[@]}; do
		[ "$k" == bold_* ] && continue
		local c=${_c[$k]}
		_c[bold_$k]="${c/0;/1;}"
		__c[$k]="\[${_c[$k]}\]"
		__c[bold_$k]="\[${_c[bold_$k]}\]"
	done
}
_c_boldify

# Uses getopts to set up associative arrays for flags and stuff
# Example usage:
# function func() { # executing: func -o /tmp -p
#   eval "$(parse_opts 'ho:p' "$@")"
#   echo "${FLAG[o]}"	# /tmp
#   echo "${FLAG[h]}"   # ''
#   echo "${FLAG[p]}"   # true
#   echo "${_FLAG[p]}"  # -p
# }
function parse_opts() {
	local optstring
	optstring=$1 && shift
	local opt
	local OPTARG
	local OPTIND
	echo "declare -A FLAG"
	echo "declare -A _FLAG"
	while getopts "${optstring}" opt "$@"; do
		[[ -z "${OPTARG}" ]] && OPTARG=true
		for (( i=0; i < ${#optstring}; i++ )); do
			local char
			char=${optstring:$i:1}
			[[ "${opt}" != "${char}" ]] && continue
			echo "FLAG[${char}]=\"${OPTARG}\""
			echo "_FLAG[${char}]=\"-${char}\""
			break
		done
	done

	echo "local OPTIND"
	echo "OPTIND=${OPTIND}"
}

# asks for confirmation
# options:
# [-m <message>] - defines message to print/ask
# [-y] - if set default answer will be Yes (ack on enter)
# if no other arguments returns 0 for success 1 for failure
# if there are other arguments it will execute them after confirmation
# example: confirm -m "floodping goog?" -y ping -f google.com
function confirm() {
	eval "$(parse_opts m:y "$@")"
	shift $((OPTIND - 1))
	[[ ! -z "$@" ]] && echo "Will execute: $@"
	local yes=false
	local defaultYN="[y/N]"
	[[ ! -z ${FLAG[y]} ]] && yes=true && defaultYN="[Y/n]"
	local msg="Confirm ${defaultYN}: "
	[[ ! -z ${FLAG[m]} ]] && msg="${FLAG[m]} ${defaultYN}: "
	echo -en "${msg}"
	local c
	read c
	if [[ "${c^}" == 'Y' ]] || ([[ ${yes} == true ]] && [[ -z ${c} ]]); then
		$@
		return 0
	else
		echo "-- Aborted"
		return 1
	fi
}

# "safer" rm, if removed files are on the same partition as /tmp it will
# mv them instead to a directory /tmp/DELETED-YYYY-MM-DD_HH:mm:ss-XXX
# this should be instant and files should be purged after reboot
# If files are not on the same partition it will perform "purge" which
# will list all files to be removed and will ask for confirmation.
# options:
# -r - recursive
# -f - force
# -o - one file system - do NOT remove files when removing recursively and
#      hitting other filesystem (useful for NFS mounts and so on)
# -p - force purge
function _saferm() {
	eval "$(parse_opts rRofp "$@")"
	shift $((OPTIND - 1))

	[[ -z $@ ]] && echo "rm [-r] [-f] [-o] [-p] <file #1> [<file #2> ...]" \
		&& return 1

	local files
	files=$(/bin/ls -AR1U "$@")
	local count
	count=$(echo "${files}" | grep -vE '(:$|^$)' | wc -l)
	first_file=$(echo "${files}" | grep -vE '(:$|^$)' | head -1)

	if [[ $(stat -c %m /tmp) != $(stat -c %m "${first_file}") ]] || [[ ${FLAG[p]} ]]; then
		echo -e "${_c[bold_red]}\t\t!!! PURGING !!!${_c[reset]}" >&2
		echo -en "  ${files}" | perl -p -e "s/\n/\n  /g"
		echo ''
		confirm -y -m "${_c[bold_red]}Remove ${_c[bold_yellow]}${count}${_c[bold_red]} files${_c[reset]}"
		[[ $? -ne 0 ]] && return 1

		[[ ${FLAG[o]} ]] && _FLAG[o]='--one-file-system'
		/bin/rm ${_FLAG[r]} ${_FLAG[R]} ${_FLAG[o]} ${_FLAG[f]} "$@"
		return $?
	fi

	PATTERN=$(date +%Y-%m-%d_%H:%M:%S)
	PATTERN="DELETED-${PATTERN}-XXX"
	TEMP=$(mktemp -d /tmp/${PATTERN})
	chmod 700 ${TEMP}
	[[ -z ${TEMP} ]] && echo "mktemp failed" && return 1
	/bin/mv "$@" "${TEMP}"
	return $?
}

# this is ugly and hacky and bad, don't judge me
# uses colors to highlight parts of stdin matched by regex
# typical usecase:
# ./bin/some_app --alsologtostderr 2>&1 | color 'error' 'warning' 'some_app.*'
# or
function color() {
	perlcmd='use IO::Select;
		$s=IO::Select->new();
		$s->add(\*STDIN);
		$|=1;
		while (@r=$s->can_read) {
			foreach $fh (@r) {
				if (sysread($fh, $l, 10240) < 1) { exit 0; }
				$i = 1;
				foreach (@ARGV) {
					$c = "\033\[01;3" . $i . "m";
					$i = ($i == 7) ? 1 : $i+1;
					$l =~ s/($_)/$c$1\033\[0;0m/gi;
				}
				print $l;
			}
		}'
	cat | perl -e "${perlcmd}" "$@"
}
