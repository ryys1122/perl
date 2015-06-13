#!/usr/bin/perl
use warnings;
use strict;

my ($indica,$japonica,$out,$ou2) = @ARGV;

open IN,"$indica" or die($!);
open JA,"$japonica" or die($!);
open OUT,">$out" or die($!);
open OU2,">$ou2" or die($!);
print OUT "reads_name\tchr\tIndica_position\tindica_mismatch\tchr\tjaponica_position\tjaponica_mismatch\n";
print OU2 "reads_name\tchr\tindica_position\tindica_md\tchr\tjaponica_position\tjaponica_md\n";
my %read;
while (<IN>){
	next if ($_ =~ /^@/);
	my @arr = split /\t/;
	$read{$arr[0]} = $_;
}
while (<JA>){
	next if ($_ =~ /^@/);
	my @japo = split /\t/;
	my $in = $read{$japo[0]};
	my @indi = split /\t/, $in;
	my ($indi_match_number,$japo_match_number,$indi_mismatch_type,$japo_mismatch_type);
	
	if ($in =~ /X0:i/ && $in =~ /MD:Z:/){
		($indi_match_number) = $in =~ /X0:i:(\d+)/;
		($indi_mismatch_type) = $in =~ /MD:Z:(\w+\^?\w+)/;
	}
	else {
		$indi_match_number = 0;
		$indi_mismatch_type = "NA";
	}
	if ($_ =~ /X0:i/ && $_ =~ /MD:Z/){
		($japo_match_number) = $_ =~ /X0:i:(\d+)/;
		($japo_mismatch_type) = $_ =~ /MD:Z:(\w+\^?\w+)/;
	}
	else {
		$japo_match_number = 0;
		$japo_mismatch_type = "NA";
	}
	if (($indi_match_number <= 1  && $japo_match_number <= 1) && $indi_mismatch_type ne $japo_mismatch_type) {
		print OUT "$indi[0]\t$indi[2]\t$indi[3]\t$indi_mismatch_type\t$japo[2]\t$japo[3]\t$japo_mismatch_type\n";
	}
	elsif (($indi_match_number <= 1 or $japo_match_number <= 1) && $indi_mismatch_type eq $japo_mismatch_type) {
		print OU2 "$indi[0]\t$indi[2]\t$indi[3]\t$indi_mismatch_type\t$japo[2]\t$japo[3]\t$japo_mismatch_type\n";
	}
}
	
close IN or die($!);
close JA or die($!);
close OUT or die($!);
close OU2 or die($!);
