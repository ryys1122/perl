#!/usr/bin/perl
use warnings;
use strict;

my ($f1,$f2,$o1,$o2) = @ARGV;
my (%hash,%hash2);
open F1,$f1 or die($!);
open F2,$f2 or die($!);
open O2,">$o2\.fq" or die($!);
open O22,">$o2\_single\.fq" or die($!);
while(<F1>){
	my ($tmp) = $_ =~ /(.*?)#AGAGATCT\/1/;
	my $seq = <F1>;
	my $sub_name = <F1>;
	my $quality = <F1>;
	$hash{$tmp}++;
}
close F1 or die($!);
while(<F2>){
	my ($tmp) = $_ =~ /(.*?)#AGAGATCT\/2/;
	my $seq = <F2>;
	my $sub_name = <F2>;
	my $quality = <F2>;
	if (exists($hash{$tmp})){
		$hash2{$tmp}++;
		print O2 $_,$seq,$sub_name,$quality;
	}
	else {
		print O22 $_,$seq,$sub_name,$quality;
	}
}
close F2 or die($!);

open F1,$f1 or die($!);
open O1,">$o1\.fq" or die($!);
open O11,">$o1\_single\.fq" or die($!);

while(<F1>){
	my ($tmp) = $_ =~ /(.*?)#0\/1/;
	my $seq1 = <F1>;
	my $sub_name = <F1>;
	my $quality = <F1>;
	if (exists($hash2{$tmp})){
		print O1 $_,$seq1,$sub_name,$quality;
	}
	else {
		print O11 $_,$seq1,$sub_name,$quality;
	}
}


close F1 or die($!);
close O1 or die($!);
close O11 or die($!);
close O22 or die($!);
