#!/usr/bin/perl
use warnings;
use strict;
my ($in,$out) = @ARGV;
open IN,$in or die($!);
open OUT,">$out" or die($!);
my ($total_length,$mean_length,$number);
while(<IN>){
	next if ($_ !~ /^\d/);
	my @arr = split /\t/;
	if ($arr[0] >= 150){
		$total_length += $arr[0];
		$number++;
		print OUT $_;
	}
}
my $tmp = $total_length/$number;
print OUT "###$total_length\t$number\t$tmp";
