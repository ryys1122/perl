#!/usr/bin/perl
use warnings;
use strict;

my ($f1,$f2,$fo) = @ARGV;

open F1,$f1 or die($!);
open F2,$f2 or die($!);
open OUT,">$fo" or die($!);

my (%hash,%hash2);

while(<F1>){
	next if ($_ !~ /^\d/);
	my @arr = split /\t/;
	$hash{$arr[13]}++;
}

while(<F2>){
	next if($_ !~ /^\d/);
	my @arr = split /\t/;
	if ( ! exists($hash{$arr[13]})){
		print OUT $_;
		$hash2{$arr[9]}++;
	}
}
my $tmp = keys %hash2;
print OUT "####$tmp";
close F1 or die($!);
close F2 or die($!);
close OUT or die($!);
