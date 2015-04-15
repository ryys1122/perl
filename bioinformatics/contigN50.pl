#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use Bio::Seq;
use Bio::SeqIO;
my ($contig)=@ARGV;
open OUT,">$stat";
my $seqin=new Bio::SeqIO(-file=>"$contig",-format=>"fasta");
while(my $seqobj=$seqin->next_seq()){
    $id=$seqobj->id;
    $length=$seqobj->length;
	print "$length\n";
    if ($length>=$len){
       $sum+=$length;
       push @len,$length;
       $n++;
    }
}

$len50=$sum*0.5;
$len90=$sum*0.9;
@so=sort {$b<=>$a} @len;
for (@so) { 
    $con+=$_;
    if ($con>=$len50){
        $n50=$_;
        last;
    }
}
$con=0;
for(@so) {
    $con+=$_;
    if ($con>=$len90){
        $n90=$_;
        last;
    }
}
print OUT ">=${len}_TotalLenth\tTotalNumber\tN50\tN90\tMaxContig\n";
print OUT "$sum\t$n\t$n50\t$n90\t$so[0]\n";
print "$length\n";
close OUT;
