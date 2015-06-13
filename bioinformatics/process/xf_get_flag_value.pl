#!/usr/bin/perl -w
use strict;

#read file from command line
my $fl = shift;
my $ou = shift;

#get flag value
open FI,$fl or die($!);

open OU1, ">$ou\_flag" or die($!);
open OU2,">$ou\_unique_map" or die($!);

my (%hash_flag,%hash,%hash_tmp,%hash_map);
while(<FI>){
	next if ($_ =~ /^@/);
	my @tmp = split /\t/;
	push @{$hash{$tmp[0]}},$tmp[1];
	my ($key) = $_ =~ /X0:i:(\d+)/;
	if (!$key){$key = 0;}
	if ($key > 2){$key = 2;}
	push @{$hash_tmp{$tmp[0]}},$key;
}
close FI or die($!);
#get paired flag
foreach my $key(keys %hash) {
	my @value = sort {$a<=>$b} @{$hash{$key}};
	$hash_flag{$value[0]}{$value[1]}++;
}

foreach my $fir	(sort {$a<=>$b} keys %hash_flag){
	for my $sec(sort {$a<=>$b} keys %{$hash_flag{$fir}}){
		my $value = $hash_flag{$fir}{$sec};
		print OU1 "$fir\t$sec\t$value\n";
	}
}
close OU1 or die($!);
#get paired mapping state:unique or not unique
foreach my $key (keys %hash_tmp){
	my @tmp = sort {$a<=>$b} @{$hash_tmp{$key}};
	$hash_map{$tmp[0]}{$tmp[1]}++;
}

foreach my $fir (sort {$a<=>$b} keys %hash_map){
	for my $sec (sort {$a<=>$b} keys %{$hash_map{$fir}}){
		my $value = $hash_map{$fir}{$sec};
		print OU2 "$fir\t$sec\t$value\n";
	}
}
close OU2 or die($!);

