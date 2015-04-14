#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: count_scaffold_per.pl
#
#        USAGE: ./count_scaffold_per.pl  
#
#  DESCRIPTION: 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: jin wenqi (), sanjinwenqi@yeah.net
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 03/24/2015 05:29:19 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;

my $total_len = 0;
my $num = 0;
open FL,"sort_n_k2_each_scafflod_len.txt";
while (<FL>){
	chomp;
	my @tem = split/\t/;
	my $id = $tem[0];
	my $count = $tem[1];
	$num ++ ;
	$total_len += $count;
	my $total_k = $total_len/(1024*1024);
	my $per_count = $total_k/(905.870360374451);
	my $per_num = $num/31904*100;
	print "$id\t$num\t$per_num\t$total_k\t$per_count\t$count\n";
}
