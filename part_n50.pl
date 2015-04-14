open FL,"@ARGV[0]";
open FLSA,">@ARGV[1]";
open FLSB,">@ARGV[2]";
$len = 0;
while (<FL>){
	$i = 1;
	chomp;
	$name = (split />/,$_)[1];
	chomp ($seq = <FL>);
	$seq =~ s/(N+)/N/g;
	@ctg = split /N/,$seq;
	foreach (@ctg){
		print FLSA ">",$name,"_",$i,"\n";
		print FLSA $_,"\n";
		$i++;
		my $leng=length;
		if ($leng >= 500){
			$len += $leng;
			push @len,$leng;
		}
	}
};

$number = @len;
print FLSB "Total Length:$len\n";
print FLSB "Total Number:$number\n";
@len = sort {$b <=> $a} @len;
$len50 = $len*0.5;
$len90 =$len*0.9;
$total = 0;
$num = 0;
foreach (@len) {
	$num++;
	$total += $_;
	if ($total >= $len50){
		print FLSB "N50:$_\tnumber:$num\n";
		last;
	}
}
$total = 0;
$num = 0;
foreach (@len) {
	$num++;
	$total += $_;
	if ($total >= $len90){
		print FLSB "N90:$_\tnumber:$num\n";
		last;
	}
}
print FLSB "Contig Length >= 500bp\n";
