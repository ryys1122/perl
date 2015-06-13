#!/usr/bin/perl
use warnings;
use strict;
my ($in,$classify,$equal) = @ARGV;
open IN,"$in" or die($!);
open OU1,">$classify" or die($!);
open OU3,">$equal" or die($!);

my $ttt = <IN>;
chomp($ttt);
sub sum{
	my $total;
	for my $arr(@_){
		$total += $arr;
	}
	return $total;
}
print OU1 "$ttt\tfrom_indica\tfrom_japonica\treads_link_both\n";
while(<IN>){
	chomp;
	my @arr = split /\t/;
	my @indi = split /[NATCG^I]/,$arr[3];
	my @japo = split /[NATCG^I]/,$arr[6];
	my $in_match = 0;
	my ($ja_start,$ja_end);
	next if($arr[1] eq '*' or $arr[4] eq '*');
	for my $i(0..$#indi){
		$indi[$i] = 0 if($indi[$i] eq "");
		$in_match += $indi[$i];
	}
	if ($arr[3] =~ /\^/){
		$in_match -= 2;
	}
	my $ja_match = 0;
	for my $i (0..$#japo){
		$japo[$i] = 0 if ($japo[$i] eq "");
		$ja_match += $japo[$i];
	}
	if ($arr[6] =~ /\^/){
		$ja_match -= 2;
	}
	if ($#indi > $#japo){
		$ja_start = $arr[5] + $indi[0];
		$ja_end = $arr[5] + &sum(@indi[0 .. ($#indi - 1)]) + $#indi;
	}
	elsif ($#indi <= $#japo){
		if ($#japo < 1){
			$ja_start = $arr[5];
			$ja_end = $arr[5] + $japo[0];
		}
		else{
			$ja_start = $arr[5] + $japo[0];
			$ja_end = $arr[5] + &sum(@japo[0 .. ($#japo - 1)]) + $#japo;
		}
	}
	if ($in_match > $ja_match){
		print OU1 "$arr[0]\t$arr[1]","\t",$arr[2],"\t",$arr[2] + $in_match,"\t",$arr[3],"\t$arr[4]\t$ja_start\t",$ja_end,"\t$arr[6]\t1\t0\t";
		if ($in_match > 0 && $ja_match > 0) {
			print OU1 "1\n";
		}
		else{
			print OU1 "0\n";
		}
	}
	elsif ($in_match < $ja_match){
		print OU1 "$arr[0]\t$arr[1]","\t",$arr[2],"\t",$arr[2] + $in_match,"\t",$arr[3],"\t$arr[4]\t$ja_start\t",$ja_end,"\t$arr[6]\t0\t1\t";
		if ($in_match > 0 && $ja_match > 0) {
			print OU1 "1\n";
		}
		else{
			print OU1 "0\n";
		}
	}
	else {
		print OU3 $_,"\n";
	}
}

close IN or die($!);
close OU1 or die($!);
close OU3 or die($!);
