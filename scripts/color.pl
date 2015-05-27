#!/usr/bin/perl
# Bartosz [ponury] Ponurkiewicz

#use strict;
use warnings;
use IO::Select;

$#ARGV >= 0 or die "$0 <regex#1> [regex#2] ...";

my @pattern = @ARGV or die $!;
my $line;

my $sel = IO::Select->new();
$sel->add(\*STDIN);

$| = 1;
while (@ready = $sel->can_read) {
	foreach $fh (@ready) {
		my $line;
		if (sysread($fh, $line, 10240) < 1) {
			exit 0;
		}
		my $i = 1;

		foreach (@pattern) {
			my $c = "\033\[01;3" . $i++ . "m";
			if ($i % 8 == 0) {
				$i = 1;
			}

			$line =~ s/($_)/$c$1\033\[0;0m/gi;
		}
		print $line;
	}
}
