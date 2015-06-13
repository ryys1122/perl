#!/usr/bin/perl
use warnings;
use strict;
my ($f1,$f2,$o1,$o2) = @ARGV;
open F1,$f1 or die($!);
open F2,$f2 or die($!);
open O1,">$o1" or die($!);
open O2,">$o2" or die($!);
my (%hash,$ca1,$ca2);
while (<F1>) {
	my $f1_name = $_;
	my $f1_read = <F1>;
	my $f1_subname = <F1>;
	my $f1_quality = <F1>;
	my $f2_name = <F2>;
	my $f2_read = <F2>;
	my $f2_subname = <F2>;
	my $f2_quality = <F2>;
	if (!(exists($hash{$f1_read}{$f2_read}) or exists($hash{$f2_read}{$f1_read}))){
		print O1 $f1_name,$f1_read,$f1_subname,$f1_quality;
		print O2 $f2_name,$f2_read,$f2_subname,$f2_quality;
		$ca2++;
	}
	$hash{$f1_read}{$f2_read}++;
	$ca1++;
}
print $ca1,"\t",$ca2,"\n";
close F1 or die($!);
close F2 or die($!);
close O1 or die($!);
close O2 or die($!);
