#!/usr/bin/perl
# this is simple g++/make output colorizer
# all useful defines are below
# Bartosz [ponury] Ponurkiewicz

my %color;          # few color definitions
$color{'normal'}="\033[0;0m";
$color{'red'}="\033[0;31m";
$color{'yellow'}="\033[0;33m";
$color{'green'}="\033[0;32m";
$color{'lblue'}="\033[0;36m";
$color{'pink'}="\033[1;35m";
$color{'bold'}="\033[1;1m";
$color{'dimmed'}="\033[1;30m";

my $Hline=$color{'pink'};
my $c="red";
my $l="";
my $h="";

while ($line = <STDIN>){
	$h = $l = $color{'normal'};
	if ($line =~ /^[^.]+.[^:]+:\d+:([^:]+:)?\s+error:/){
		$l=$color{'red'};
	}
	elsif ($line =~ /^[^.]+.[^:]+:\d+:([^:]+:)?\s+warning:/){
		$l=$color{'yellow'};
	}
	elsif ($line =~ /^[^.]+.[^:]+:\d+:([^:]+:)?\s+note:/){
		$l=$color{'green'};
	}
	elsif ($line =~ /^[^.]+.[^:]+:([^:]+:)?\s+In/){
		$l=$color{'lblue'};
	}
	elsif ($line =~ /^[^.]+.[^:]+:\d+:([^:]+:)?\s+instantiated from here/) {
		$l=$color{'lblue'};
	}
	elsif ($line =~ /^[^.]+.[^:]+:\d+:([^:]+:)?\s+instantiated/) {
		$l=$color{'dimmed'};
	}
	elsif ($line =~ s/^(make: \*\*\* )\[([^\]]+)]/\1\[$color{'bold'}\2$color{'normal'}\]/){}

	$h = $l;
	$h =~ s/\[0;/\[1;/;

	$line =~ s/^([^:]+):(\d+):/$l\1$l:$Hline\2$l:/g;	# line num hi
	$line =~ s/^([^:]+):(\s+)/$h\1$l:\2/g;			# info color
	$line =~ s/‘([^’]+)’/‘$h\1$l’/g;			# error token
	$line =~ s/'([^']+)'/'$h\1$l'/g;
	$line =~ s/`([^']+)'/`$h\1$l'/g;

	$line =~ s/^(.*)\/([^:]+):/$l\1\/$h\2$l:/g;

	print $line;
	print $color{'normal'};
}

print $color{'normal'};
