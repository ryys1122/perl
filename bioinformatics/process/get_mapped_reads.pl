#!/usr/bin/perl
use warnings;
use strict;

my ($fl,$fo) = @ARGV;
open FI,"$fl" or die($!);
open OU,">$fo" or die($!);
my %hash;
while(<FI>){
	if($_ =~ /^@/){
		print OU $_;
		next;
	}
	#chomp;
	my @arr = split /\t/;
	next if ($arr[2] eq '*');
	push @{$hash{$arr[0]}},$_;
}

for my $name (keys %hash){
	my @arr = @{$hash{$name}};
	if (scalar(@arr) == 2){
		print OU @arr;
	}
}
