#!/usr/bin/perl
use warnings;
use strict;
use Bio::SeqIO;
my $fl =  shift;
my $in = Bio::SeqIO->new(-file=>"$fl", -format=>'Fasta');
#open OU,">$fo" or die($!);
my (%hash_gene,%hash_transcript);
while(my $seq = $in->next_seq()){
	my $seq_name = $seq->id;
	#print $seq_name,"\n";
	my ($gene) = $seq_name =~ /(\w+)\.\d+/;
	my ($transcript) = $seq_name;
	$hash_gene{$gene}++;
	$hash_transcript{$transcript}++;
}
my $gene_numer = keys %hash_gene;
my $transcripts = keys %hash_transcript;
print $gene_numer,"\t",$transcripts,"\n";
