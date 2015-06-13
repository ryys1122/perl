#!/usr/a bin/perl
use warnings;
use strict;
my $fl = shift;
my $ou = shift;
my $gff = "/public4/fx/tomato/genome/annotation/tomato_exon.gff3";

open  FL,$fl or die($!);
my $pos = 1;

my @array = <FL>;
close FL or die($!);
my ($total_number) = $array[0] =~ /(\d+)/;

open GFF,$gff or die($!);

open OU,">$ou.bed" or die($!);
print OU "chromosome\tstart\tend\texon_name\texpression_level\tstrand\n";
	
while (<GFF>){
	my @arr = split /\t/;
	my ($name) = $arr[8] =~ /ID=exon:(.*);Parent/;
	my $num = 0;
	my $exon_length = $arr[4] - $arr[3] + 1;
	my $label = 0;
	for my $i ($pos..$#array){
		chomp($array[$i]);
		my @bed = split /\t/,$array[$i];
		if ($bed[0] eq $arr[0] && $bed[1] >= $arr[3] && $bed[2] <= $arr[4]){
			$num += $bed[3];
			$label++;
			if ($label == 1){
				$pos = $i;
			}
		}
		last if ($bed[0] gt $arr[0] or ($arr[0] eq $bed[0] && $bed[2] > $arr[4]));
	}
	my $expression_level = $num * 1000000000 / $total_number / $exon_length;
	print OU "$arr[0]\t$arr[3]\t$arr[4]\t$name\t$expression_level\t$arr[6]\n";
}	
close OU or die($!);
