#/usr/bin/perl
use strict;
use Bio::Tools::GFF;
use Bio::SeqFeatureI;
#the script is used to parse the gff4 file.

my $fi = shift;
my $gffio = Bio::Tools::GFF->new( -file => $fi, -gff_version => 3 );
my $feature;
while ( $feature = $gffio->next_feature() ) {

    #$feature->has_tag
	#print $feature->display_name,"\n";
    #$feature->get_tag_values
    #$feature->get_tagset_values
    #print $feature->get_all_tags,"\n";


	my @tags = $feature->get_all_tags();
	print $feature->get_tag_values("ID"),"\t";
	if($feature->has_tag("Name")){
		print $feature->get_tag_values("Name"),"\n";
	}else{
		  print $feature->get_tag_values("Parent"),"\n";
	}
	print $feature->seq_id,     "\t",
      $feature->source_tag, "\t", $feature->primary_tag, "\t", $feature->start,
      "\tto\t", $feature->end,
      "\n";
}

