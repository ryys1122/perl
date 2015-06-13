#!/usr/bin/perl
use warnings;
use strict;
use Bio::SeqIO;
my $fl =  shift;
my $in = Bio::SeqIO->new(-file=>"$fl", -format=>'Fasta');
my $fo = shift;
open OU,">$fo" or die($!);
my (%hash);
my ($total_length,$mean_length,$n50,$total_number);
while(my $seq = $in->next_seq()){
	my $seq_name = $seq->id;
	my $seq_len = length($seq->seq);
	$total_length += $seq_len;
	$total_number++;
	$hash{$seq_len}{$seq_name}++;
}

for my $fir(sort {$a<=>$b} keys %hash){
	for my $sec (sort keys %{$hash{$fir}}){
		print OU "$fir\t$sec\n";
	}
}
$mean_length = $total_length/$total_number;
print OU "###$total_length\t$total_number\t$mean_length\n";
close OU or die($!);
