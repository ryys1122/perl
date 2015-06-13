#!/usr/bin/perl
use warnings;
use strict;

my ($in,$out,$ja) = @ARGV;
open IN,$in or die($!);
open OUT,">$out" or die($!);
open JA,">$ja" or die($!);
my ($maternal,$paternal);
$maternal = $paternal = 0;
while(<IN>){
	chomp;
	my @arr = split /\t/;
	if (&cal_ratio($arr[3],$arr[6]) > 3){
		$maternal++;
		my $start = ($arr[1] - 1) * 500;
		my $end = ($arr[1] + 1) * 500;
		my $tmp = $arr[3]/$arr[6];
		print OUT "$arr[0]\t$start\t$end\t$arr[3]\t$arr[6]\t$tmp\n";
	}
	elsif (&cal_ratio($arr[3],$arr[6]) < 1/3){
		$paternal++;
		my $start = ($arr[1] - 1) *500;
		my $end = ($arr[1] + 1) * 500;
		my $tmp = $arr[3]/$arr[6];
		print JA "$arr[0]\t$start\t$end\t$arr[3]\t$arr[6]\t$tmp\n";
	}
	if (&cal_ratio($arr[4],$arr[7]) > 3){
                $maternal++;
                my $start = $arr[1] * 500;
                my $end = ($arr[1] + 2) * 500;
                my $tmp = $arr[4]/$arr[7];
                print OUT "$arr[0]\t$start\t$end\t$arr[4]\t$arr[7]\t$tmp\n";
        }
        elsif (&cal_ratio($arr[4],$arr[7]) < 1/3){
                $paternal++;
                my $start = $arr[1] *500;
                my $end = ($arr[1] + 2) * 500;
                my $tmp = $arr[4]/$arr[7];
                print JA "$arr[0]\t$start\t$end\t$arr[4]\t$arr[7]\t$tmp\n";
        }

}

sub cal_ratio{
	my $tmp1 = $_[0];
	my $tmp2 = $_[1];
	if ($tmp1 < 10 or $tmp2 < 10){
		return 1;
	}
	else {
		return $tmp1/$tmp2;
	}
}
