use strict;
use warnings;
use HTML::TreeBuilder;
use LWP::Simple;
my $url="http://plntfdb.bio.uni-potsdam.de/v3.0/";
my $page=get($url);
my @urls;
die "Couldn't get the URL $url!" unless defined $page;
#print ("\n $page \n \n");
#$root = HTML::TreeBuilder->new_from_content($page);
my $root = HTML::TreeBuilder->new();
$root->parse($page)  or die "Could not to parse the page!";
$root->eof( );
my @tds = $root->find_by_tag_name('td') or die "Could not find the tag:td";
foreach my $td(@tds){
	my $a = $td->find_by_tag_name('a') or die "Could not find the tag:a";
	my $href = $a->attr('href');
	if(defined($href)){
		my $url_tmp=$url.$href;
	push @urls,$url_tmp;
	}
}
foreach my $ur(@urls){
	my $content=get($ur);
#print $ur."\n";
	my $roots = HTML::TreeBuilder->new();
	$roots->parse($content) or die "Could not to parse the page:$url!";
	$roots->eof( );
	my @desc = $roots->find_by_attribute('id','subcontent') or die "Could not find the id"; 
	my $h1= $desc[0]->find_by_tag_name('h1');
	$h1->as_text =~ /(\S+)/;
	my $family_name = $1;
	print $family_name."\t";

	my $pa= $desc[0]->find_by_tag_name('p');
	print $pa->as_text."\t";

	$desc[0]->as_text =~ /SHOULD possess (.+?) domain/ ;
	my $domain_clu = $1;
#$domain_clu =~ s/\s+/>/g;
	print $domain_clu."\t";
#print $desc[0]->as_text."\n";
	if($desc[0]->as_text =~ /SHOULD NOT.+?possess (.+?) domain/){ ;
	my $domain_not = $1;
#$domain_not =~ s/\s+/>/g;
print $domain_not."\t";
	}else{
print "++"."\t";
	}

	my $h2= $desc[0]->find_by_tag_name('h2');
#print $h2->as_text."\n";
	my @ref = $roots->find_by_attribute('id','refs') ; 
	if(@ref){
	my @a_ref = $ref[0]->find_by_tag_name('a') or die "Could not find the tag:a"; 
	my %hash_es;
	foreach my $hr(@a_ref){
		my $hf = $hr->attr('href');
		my $hr_text = $hr->as_text;
		$hr_text =~ s/\s//g;
	 $hash_es{$hr_text}=$hf;
	}
	my $reference = $ref[0]->as_text;
	my @ref_essay = split /(PUBMEDID:\d+)/,$reference;
	foreach my $es(@ref_essay){
		print $es;
		if($es =~ /PUBMEDID:\d+/){
			print ">".$hash_es{$es}."^";
		}
		
	}
	}else{
		print "<<<<<<";
	}
#print "=================="."\n";
#print "@ref_essay"."\n";
=pod	
	my @a_fam = $desc[0]->find_by_tag_name('a') or die "Could not find the tag:a"; 
	foreach my $hr(@a_fam){
		my $hf = $hr->attr('href');
		if($hr->as_text  eq "Domain alignments"){
			last;
		}
#print $hr->as_text,"\t",$hf."\n";
	}
=cut
print "\n";

}



