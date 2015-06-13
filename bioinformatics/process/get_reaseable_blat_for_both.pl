#!/usr/bin/perl
use warnings;
use strict;

##从命令行输入输出文件$fo，输入文件$fl,filter 阈值cutoff
my ($fl,$fo,$cut_off) = @ARGV;
open FI,$fl or die($!);
open OU,">$fo" or die($!);
my %hash;
while(<FI>){
	next if ($_ !~ /^\d/);
	my @arr = split /\t/;
	if (($arr[0] / $arr[10]) >= $cut_off && ($arr[0] / $arr[14]) >= $cut_off){
		print OU $_;
		$hash{$arr[9]}++;
	}
}
my $tmp = keys %hash;
print OU "##",$tmp;

