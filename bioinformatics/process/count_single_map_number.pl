#!/usr/bin/perl
use warnings;
use strict;

my $in = shift;

open IN,$in or die($!);
#open OUT,">$out" or die($!);
my $number;
while(<IN>){
	next if($_ =~ /^@/);
	my @arr = split /\t/;
	if ($arr[1] != 4){
		$number++;
	}
}
print $number,"\n";
close IN or die($!);
#close OUT or die($!);
