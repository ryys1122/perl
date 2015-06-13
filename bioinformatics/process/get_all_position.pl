#!/usr/bin/perl
use warnings;
use strict;
my $fl = shift;
my $num = shift;
open OU,">all_pos" or die($!);
open FL,$fl or die($!);
while(<FL>){
	next if($_ =~ /NA/ or $_ =~ /read/ );
	my @arr = split /\t/;
	my $end = $arr[5] + $num - 1;
	print OU "$arr[4]\t$arr[5]\t$end\t$arr[0]\n";
}
close FL or die($!);
close OU or die($!);
