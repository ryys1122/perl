#!/usr/bin/perl
use warnings;
use strict;
use Bio::SeqIO;

my ($in_fl,$out_fl) = @ARGV;

my $in = Bio::SeqIO->new(-file=>"$in_fl",-format=>'Fasta');
open OUT,">$out_fl" or die($!);

while(my $seq = $in->next_seq()){
	print OUT '>',$seq->id,"\n",$seq->seq,"\n";
}
