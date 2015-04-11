use strict;
use warnings;
use Bio::SeqIO;
open IN,"glimmer.predict";
my %hash;
my $aa;
open OUT,">protein.fasta";
while(<IN>){
    chomp;
    if(/>(.*)/){
        $aa=$1;
    }else{
        my @arry=split /\s+/,$_;
        my $in=Bio::SeqIO->new(-file=>"WX-02-new.fna",-format=>"fasta");
        while(my $seq_obj=$in->next_seq){
            my $id=$seq_obj->id;
            if($id eq $aa){
		    $arry[3]=~s/(.*)\d+/$1/;
                if($arry[3] eq "+"){
                    my $seq_out=$seq_obj->trunc($arry[1],$arry[2])->translate;
		    my $bb=$seq_out->seq;
		   print OUT ">${aa}_$arry[0]\n$bb\n";
                }else{
		my $seq_out=$seq_obj->trunc($arry[2],$arry[1])->revcom->translate;
		my $bb=$seq_out->seq;
		print OUT ">${aa}_$arry[0]\n$bb\n";
		}
            }
        }
    } 
}
close OUT;
close IN;
