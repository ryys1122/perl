#!/usr/bin/perl -w
use strict;
my ($f1,$f2,$ou) = @ARGV;
open F1,$f1 or die($!);
open F2,$f2 or die($!);
open OU,">$ou" or die($!);
while(<F1>){
	my $seq1 = <F1>.<F1>.<F1>;
	my $seq2 = <F2>.<F2>.<F2>.<F2>;
	print OU $_,$seq1,$seq2;
}
close F1;
close F2;
close OU;
