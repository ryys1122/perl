#!/usr/bin/perl
use warnings;
use strict;
use Bio::SeqIO;

my ($fl,$fo) = @ARGV;

my $in = Bio::SeqIO->new(-file => "$fl", -format => 'Fasta');
my $out = Bio::SeqIO->new(-file => ">$fo", -format => 'Fasta');
my $number;
while (my $seq = $in->next_seq()){
	my $sequnece = $seq->seq;
	if ($sequnece =~ /WRKY/){
		$out->write_seq($seq);
		$number++;
	}
}
print $number,"\n";
