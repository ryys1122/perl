#/usr/bin/perl

#the script is used to calculate the ratio of every bits to the maximal bits in the outfile of blast
#the patameter is /data4/hliu/work_current/rice/blast+/gene/MH63_gene.fa.out

use strict;
use Bio::SearchIO;
use File::Basename;

my $bi  = shift;
my $out = basename $bi;
$out .= "_ratio_out";
my $bl = new Bio::SearchIO(
    -format => 'blast',
    -file   => $bi
);

open OU, ">$out" or warn "It's failed to open the file $out:&!";

while ( my $result = $bl->next_result ) {
    my $name_query = $result->query_name;
    my @score;
    while ( my $hit = $result->next_hit ) {
        my $name_hit = $hit->name;
        my $bits     = $hit->bits;
        push @score, $bits;
        my $ratio = sprintf "%.4f", $bits / $score[0];
        print $name_query. "\t"
          . $name_hit . "\t"
          . $bits . "\t"
          . $ratio . "\n";
        print OU $name_query . "\t"
          . $name_hit . "\t"
          . $bits . "\t"
          . $ratio . "\n";
    }
    print "\n";
}

