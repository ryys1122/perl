#!/usr/bin/perl -w
use strict;
my ($fl,$fname,$fo,$corhernt,$non_con) = @ARGV;##psl文件，打印满足条件的psl文件到$fo,corhernt为与已知gene model基本一致的基因名，后面为不一致的基因名
open FL,$fl or die($!);
open FN,$fname or die($!);
open OU,">$fo" or die($!);
open CON,">$corhernt" or die($!);
open NON,">$non_con" or die($!);
my (%all,%hash);
while(<FL>){
	next if($_ !~ /^\d/);
	my @arr = split /\t/;
	$all{$arr[9]}++;
	if ($arr[0]/($arr[10] - $arr[3]) >= 0.9){
		print OU $_;
		$hash{$arr[9]}{$arr[13]} = "$arr[0]\t$arr[3]\t$arr[10]\t$arr[14]";
	}
}
while(<FN>){
	chomp;
	s/\r//;
	my ($key) = $_ =~ />(.*)/;
	#print "$key\n";
	$all{$key}++;
}

close FN or die($!);
my $number = keys %hash;
close FL or die($!);
close OU or die($!);
foreach my $fir( sort keys %hash){
	for my $sec ( sort keys %{$hash{$fir}}){
		my $thi = $hash{$fir}{$sec};
		my @tmp = split /\t/,$thi;
		my $va = $tmp[0]/($tmp[2] - $tmp[1]);
		print CON "$fir\t$sec\t$thi\t$va\n"
	}
}
for my $fir(sort keys %all){
	next if (exists($hash{$fir}));
	print  NON "$fir\n";
}
print CON "###",$number,"\n";
close CON or die($!);
close NON or die($!);
