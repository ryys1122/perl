use LWP::UserAgent;
#my ($seq,@seq);

foreach my $file(glob "*.txt"){
#open FL,"$file";
my $outfile=$file;
$outfile=~s/txt/out/g;

my $browser = LWP::UserAgent->new;
my $url ='http://planttfdb.cbi.pku.edu.cn/prediction_result.php';

my $response = $browser ->post($url,['input_file' => ["$file"]],'Content_Type' => 'form-data');my $content;
while(1){
    if ($response -> is_success){
        $content = $response ->content;
        print $file."\n";
	last;
    }else{
      last;
    }
}
my @lines= split/\n/,$content;
for (@lines){
    if (/href="(TF_prediction\/tmp\/.*?\/TF.list)"/){
        $url2 = "http://planttfdb.cbi.pku.edu.cn/" . "$1"; 
        my $response2 = $browser ->get($url2,);
        
         if ($response -> is_success){
            $response2 = $browser->get($url2,':content_file'=>"$outfile");
        }else{
            print $file;
         }
         
    }
}
sleep(1);
}
