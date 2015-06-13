#!/usr/bin/perl
use warnings;
use strict;

my ($in,$out) = @ARGV;
open IN,$in or die($!);
open OUT,">$out" or die($!);
while(<IN>){
	chomp;
	my @arr = split /\t/;
	my $start = ($arr[1] - 1) * 500;
	my $end = ($arr[1] + 1) * 500;
	my $tmp = &cal_ratio($arr[3],$arr[6]);
	print OUT "$arr[0]\t$start\t$end\t$arr[3]\t$arr[6]\t$tmp\n";
	$tmp = &cal_ratio($arr[4],$arr[7]);
        $start = $arr[1] * 500;
        $end = ($arr[1] + 2) * 500;
        print OUT "$arr[0]\t$start\t$end\t$arr[4]\t$arr[7]\t$tmp\n";
}

sub cal_ratio{
	my $tmp1 = $_[0];
	my $tmp2 = $_[1];
	if ($tmp1 < 10 or $tmp2 < 10){
		return "invalid";
	}
	else {
		return $tmp1/$tmp2;
	}
}
close IN or die($!);
close OUT or die($!);
