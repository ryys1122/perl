#!/usr/bin/perl
use warnings;
use strict;
use Bio::SeqIO;
my ($in1,$in2,$ou) = @ARGV;

open IN1, $in1 or die($!);

my $in = Bio::SeqIO->new(-file=>"$in2",-format=>'Fasta');
my $out = Bio::SeqIO->new(-file=>">$ou",-format=>'Fasta');

my %hash;

while(<IN1>){
	#next if($_ !~ /^\d/);
	my ($key) = $_ =~ /(\w+)/;
	$hash{$key}++;
}

while (my $seq = $in->next_seq()){
	my $seq_id = $seq->id;
	if (exists($hash{$seq_id})){
		$out->write_seq($seq);
	}
}
close IN1 or die($!);
