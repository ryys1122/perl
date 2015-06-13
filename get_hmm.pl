use strict;
open(F1,"1.txt") or die $!;
while (<F1>) {
    chomp;
    my $id=$_;
    $id=~s/.*(PF.....).*/$1/g;
    require LWP::UserAgent; 
    my $ua = LWP::UserAgent->new;
    my $url=("http\:\/\/pfam\.xfam\.org\/family\/$id\/hmm");
    my $response = $ua->get($url,':content_file'=>"$id.hmm");
    
}

close F1;

