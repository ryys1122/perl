#!/usr/bin/perl
use warnings;
use strict;

my ($inter,$in,$out,$ja) = @ARGV;
open INTER,$inter or die($!);
open IN,$in or die($!);
open OUT,">$out" or die($!);
open JA,">$ja" or die($!);
open ALL,">all_gene";
my %hash;
while(<INTER>){
	chomp;
	my @arr = split;
	my ($name) = $arr[12] =~ /ID=(.*);Name/;
	$hash{$arr[3]}{$name} = $arr[4].">".$arr[7].">".$arr[8];
}
my (%indica,%nipp);
while(<IN>){
	chomp;
	my @arr = split /\t/;
	if (exists($hash{$arr[0]})){
		if (&snp_classification($_) == 1){
			foreach my $sec(keys %{$hash{$arr[0]}}){
				my $value = $hash{$arr[0]}{$sec};
				$indica{$sec}{$value}++;
			}
		}
		elsif (&snp_classification($_) == 0){
	                for my $sec(keys %{$hash{$arr[0]}}){
                                my $value = $hash{$arr[0]}{$sec};
                                $nipp{$sec}{$value}++;
                        }
                }
	}	
}
foreach my $f1(sort keys %indica){
	foreach my $f2(sort keys %{$indica{$f1}}){
		my $in_value = $indica{$f1}{$f2};
		my $ni_value;
		if (!$nipp{$f1}{$f2}){
			$ni_value = 0;
		}
		else { $ni_value = $nipp{$f1}{$f2};}
		my $tm = &cal_ratio($in_value,$ni_value);
		my @pos = split />/,$f2;
		print ALL "$f1\t$pos[0]\t$pos[1]\t$pos[2]\t$in_value\t$ni_value\t$tm\n";
		if (&cal_ratio($in_value,$ni_value) > 6){
			my $tmp = $in_value/$ni_value;
			print OUT "$f1\t$pos[0]\t$pos[1]\t$pos[2]\t$tmp\n";
		}
		elsif (&cal_ratio($in_value,$ni_value) < 2/3){
                        my $tmp = $in_value/$ni_value;
                        print JA "$f1\t$pos[0]\t$pos[1]\t$pos[2]\t$tmp\n";
                }
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
sub snp_classification{
        my @arr = split /\t/,$_[0];
        my @indi = split /[NATCG^I]/,$arr[3];
        my $in_match = 0;
        for my $i(0..$#indi){
                $indi[$i] = 0 if($indi[$i] eq "");
                $in_match += $indi[$i];
        }
        if ($arr[3] =~ /\^/){
                $in_match -= 2;
        }
        my @japo = split /[NATCG^I]/,$arr[6];
        my $ja_match = 0;
        for my $i (0..$#japo){
                $japo[$i] = 0 if ($japo[$i] eq "");
                $ja_match += $japo[$i];
        }
        if ($arr[6] =~ /\^/){
                $ja_match -= 2;
        }
        if ($in_match > $ja_match){
                return 1;
        }
        elsif ($in_match < $ja_match){
                return 0;
        }
        else {
                return -1;
        }
}
close ALL or die($!);
close OUT or die($!);
close IN or die($!);
close JA or die($!);
close INTER or die($!);
