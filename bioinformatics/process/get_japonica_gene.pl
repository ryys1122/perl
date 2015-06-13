#!/usr/bin/perl
use warnings;
use strict;
my($in,$out) = @ARGV;

open IN, $in or die($!);
open OUT,">$out" or die($!);
my $cal = <IN>;
while(<IN>){
	next if($_ =~ /\*/);
	chomp;
	my @arr = split;
	my @match = split /[AGCTI^]/,$arr[6];
	my $length = 0;
	for my $i (0..$#match){
	 	if ($match[$i] !~ /\d+/){
			$match[$i] = 0;
		}
		$length += $match[$i];
	}
	$length += scalar(@match) - 2;
	my $end = $arr[5] + $length;
	print OUT "$arr[4]\t$arr[5]\t$end\t$arr[0]\n";
}
close IN or die($!);
close OUT or die($!);
