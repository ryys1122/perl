#/usr/bin/perl
#the script is uesed to calculate the identity and hsp coveratge.the two parameters is
# ./result_rice/cds/MH63_ZS97_selected  /data4/hliu/work_current/rice/blast+/cds/MH63_cds.fa.out
# and the result is redirected to the ./result_rice/cds/MH63_ZS97_cds_identity_coverage
use strict;
use Bio::SearchIO;

my ( $fi, $bi ) = @ARGV;
my $bl = new Bio::SearchIO(
    -format => 'blast',
    -file   => $bi
);
my @id;
my %hash;
my %hash_bl;

open FI, $fi or warn "It's failed to open the file $fi:&!";

while (<FI>) {
    chomp;
    my @array = split /\t/, $_;
    $hash{ $array[0] . $array[1] } = $_;
}

while ( my $result = $bl->next_result ) {
    my $name_query   = $result->query_name;
    my $length_query = $result->query_length;
    while ( my $hit = $result->next_hit ) {
        my $name_hit = $hit->name;
        if ( exists $hash{ $name_query . $name_hit } ) {
            my $hsp        = $hit->next_hsp;
            my $length_hsp = $hsp->length;
            my $identity   = sprintf "%.4f", $hsp->percent_identity;
            my $coverage;
            if ( $length_hsp > $length_query ) {
                $coverage = sprintf "%.4f", $length_query / $length_hsp;
            }
            else {
                $coverage = sprintf "%.4f", $length_hsp / $length_query;
            }
            print $hash{ $name_query . $name_hit } . "\t"
              . $identity . "\t"
              . $length_hsp . "\t"
              . $coverage . "\n";
        }
    }
}

