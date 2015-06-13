#!/usr/bin/perl
use warnings;
use strict;

my ($fl,$fo) = @ARGV;

open FL,$fl or die($!);
open OU,">$fo" or die($!);

my ($total_map_read,%read_number);

while(<FL>){
	my @arr = split /\t/;
	$read_number{$arr[0]}++;
}
close FL or die($!);
$total_map_read = keys %read_number;
print OU "###$total_map_read\n";

open FL,$fl or die($!);
while(<FL>){
	my @arr = split /\t/;
	my @read;
	if ($arr[5] =~ /N/){
		@read = split /[MN]/,$arr[5];
		my $num = $read_number{$arr[0]};
		my $pse_read = 1/2/$num;
		my $first_end = $arr[3] + $read[0] - 1;
		my $sec_start = $arr[3] + $read[0] + $read[1];
		my $sec_end = $arr[3] + $read[0] + $read[1] + $read[2] -1;
		print OU "$arr[2]\t$arr[3]\t$first_end\t$pse_read\n$arr[2]\t$sec_start\t$sec_end\t$pse_read\n";
	}
	else {
		@read = split /M/,$arr[5];
		my $end = $read[0] + $arr[3] - 1;
		my $num = $read_number{$arr[0]};
		my $pse_read = 1/$num;
		print OU "$arr[2]\t$arr[3]\t$end\t$pse_read\n";
	}
}
close FL or die($!);
close OU or die($!);
