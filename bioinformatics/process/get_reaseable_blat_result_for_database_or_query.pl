#!/usr/bin/perl
use warnings;
use strict;

##从命令行输入输出文件$fo，输入文件$fl,filter 阈值cutoff number=10 or number=14
my ($fl,$fo,$cut_off,$number) = @ARGV;
open FI,$fl or die($!);
open OU,">$fo" or die($!);
my (%hash,%hash_query);
while(<FI>){
	next if ($_ !~ /^\d/);
	my @arr = split /\t/;
	my $tmp = $arr[0]/$arr[$number];
	if ($tmp >= $cut_off){
		print OU $_;
		$hash{$arr[9]}++;
		$hash_query{$arr[13]}++;
	}
}
my $tm = keys %hash;
my $tq = keys %hash_query;
print OU "##",$tm,"\t",$tq;

