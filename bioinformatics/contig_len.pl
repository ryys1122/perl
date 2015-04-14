#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use Bio::Seq;
use Bio::SeqIO;
my ($contig)=@ARGV;
my $seqin=Bio::SeqIO->new(-file=>"$contig",-format=>"fasta");
while(my $seqobj=$seqin->next_seq()){
	my $id=$seqobj->id;
	my $length=$seqobj->length;
	print "$length\n";
}
#print "$length\n";
