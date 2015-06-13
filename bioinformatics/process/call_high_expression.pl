#!/usr/bin/perl
use warnings;
use strict;

my ($fl,$fo,$cutoff) = @ARGV;
open FL,$fl or die($!);
open OU,">$fo" or die($!);

while (<FL>){
	my ($fruit,$flower,$leaf,$root);
	if ($_ =~ /transcript/){
		print OU $_;
		next;
	}
	else {
		chomp;
		my @arr = split /\t/;
		next if ($arr[2] + $arr[1] == 0);
		$fruit = $arr[1] + $arr[2];
		$flower = ($arr[3] + $arr[4] == 0) ? 1e-4 : ($arr[3] + $arr[4]);
		$leaf = ($arr[5] + $arr[6] == 0) ? 1e-4 : ($arr[5] + $arr[6]);
		$root = ($arr[7] + $arr[8] == 0) ? 1e-4 : ($arr[7] + $arr[8]);
	}
	if ($fruit >= 1 && $fruit/$flower >= $cutoff && $fruit/$leaf >= $cutoff && $fruit/$root >= $cutoff){
		print OU $_,"\n";
	}
}
close FL or die($!);
close OU or die($!);			
