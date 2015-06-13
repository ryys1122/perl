#!/usr/bin/perl
use warnings;
use strict;

my ($in,$result,$coordinate) = @ARGV;
open IN,$in or die($!); ##file: different
open OUT,">$result" or die($!);
open OU3,">$coordinate" or die($!);

my (%indica,%japonica,%cor);
while(<IN>){
	chomp;
	my @arr = split /\t/;
	if ($arr[1] ne '*' && $arr[4] ne '*'){
		my $label1 = int(($arr[2] - 1) / 500);
		my $label2 = int(($arr[5] - 1) / 500);
		if (&snp_classification($_) == 1){
			$indica{$arr[4]}{$label2}++;
		}
		elsif (&snp_classification($_) == 0){
			$japonica{$arr[4]}{$label2}++;
		}
		$cor{$arr[1]}{$arr[4]}{$label1}{$label2}++;
	}
}
my $indi_number = 0;
my $japo_number = 0;
foreach my $fir(sort keys %indica){
	foreach my $sec(sort {$a<=>$b} keys %{$indica{$fir}}){
		my $in1 = $indica{$fir}{$sec};
		my ($in0,$in2,$ja0,$ja1,$ja2);
		$in0 = $in2 = $ja0 = $ja1 = $ja2 = 0;
		my $tmp = $sec - 1;
		if (exists($indica{$fir}{$tmp})){
			$in0 = $indica{$fir}{$tmp};
		}
		my $tmp2 = $sec + 1;
		if (exists($indica{$fir}{$tmp2})){
			$in2 = $indica{$fir}{$tmp2};
		}
		if($japonica{$fir}{$sec}) {$ja1 = $japonica{$fir}{$sec};} 
                if (exists($japonica{$fir}{$sec - 1})){
			$ja0 = $japonica{$fir}{$sec - 1};
                }
                if (exists($japonica{$fir}{$sec + 1})){
                        $ja2 = $japonica{$fir}{$sec + 1};
                }
		if ((($in1 + $in0 >= 10) or ($in1 + $in2 >= 10)) && ((($ja1 + $ja0) >= 10) or ($ja1 + $ja2) >= 10)){
			print OUT $fir,"\t",$sec,"\t",$in1,"\t",$in1+ $in0,"\t",$in1+ $in2,"\t",$ja1,"\t",$ja1 + $ja0, "\t", $ja1 + $ja2,"\n";
		}
	}
}

foreach my $fir(sort keys %cor){
	foreach my $sec(sort keys %{$cor{$fir}}){
		foreach my $thi(sort {$a<=>$b} keys %{$cor{$fir}{$sec}}){
			foreach my $fou(sort {$a<=>$b} keys %{$cor{$fir}{$sec}{$thi}}){
				my $value = $cor{$fir}{$sec}{$thi}{$fou};
				print OU3 "$fir\t$sec\t$thi\t$fou\t$value\n";
			}
		}
	}
}
close IN or die($!);
close OUT or die($!);
close OU3 or die($!);

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
