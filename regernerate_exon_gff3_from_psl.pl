#!/usr/bin/perl -w
use strict;
my ($fl_in,$fl_out) = @ARGV;
open FI,$fl_in or die($!);
open OUT,">$fl_out" or die($!);
my %hash;
while(<FI>){
	next if ($_ !~ /^\d/);
	chomp;
	my @arr = split /\t/;
	$hash{$arr[9]}++;
	my @exon_start = split /,/$arr[20];
	my @exon_length = split /,/,$arr[18];
	my $tmp = $#exon_start -1;
	for my $i(1..$tmp){
		my $exon_start = $exon_start[$i];
		my $exon_end = $exon_start[$i] + $exon_length[$i] - 1;
		my $tmptmp = $hash{$arr[9]};
		my $exon_number = $i + 1;
		my $exon_name = $arr[9]."$tmptmp"."$exon_number";
		print OUT "$arr[13]\t$exon_start\t$exon_end\t$exon_name\t\.\t$arr[8]\n";
	}
}
