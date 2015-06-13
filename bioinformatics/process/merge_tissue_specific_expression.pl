#!/usr/bin/perl
use warnings;
use strict;

my @arr = ("fruit1.bed","fruit2.bed","flower1.bed","flower2.bed","leaf1.bed","leaf2.bed","root1.bed","root2.bed");

open OU,">tissue_transcript_expression" or die($!);
print OU "transcript\tfruit1\tfruit2\tflower1\tflower2\tleaf1\tleaf2\troot1\troot2";


my (@tissue);
foreach my $i (0..$#arr){
	open FI,$arr[$i] or die($!);
	$tissue[$i] = [<FI>];
	close FI or die($!);
}

my %transcript;
foreach my $j (1 .. 160007){
	foreach my $i(0 .. 7){
		my @tmp = split /\t/,$tissue[$i][$j];
		my ($trans) = $tmp[3] =~ /(.*)\.\d+/;
		my ($length,$expression);
		if (exists($transcript{$trans}{$i})){
			$length = $transcript{$trans}{$i}[0] + $tmp[2] - $tmp[1] + 1;
			$expression = $transcript{$trans}{$i}[1] + $tmp[4] * ($tmp[2] - $tmp[1] + 1);
		}
		else {
			$length = $tmp[2] - $tmp[1] + 1;
			$expression = ($tmp[2] - $tmp[1] + 1) * $tmp[4];
		}
		$transcript{$trans}{$i} = [$length,$expression];
	}
}
foreach my $fir( sort keys %transcript) {
	print OU "\n$fir";
	foreach my $sec (sort keys %{$transcript{$fir}}){
		my $expression_level = $transcript{$fir}{$sec}[1] / $transcript{$fir}{$sec}[0];
		print OU "\t$expression_level";
	}
}
close OU or die($!);

