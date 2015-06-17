#!/usr/bin/perl
#perl script used to connect to mysql
use strict;
use DBI;
my $driver="DBI:mysql";
my $database="test";
my $host="localhost";
my $user="genome";
my $passwd="genome_iob^123";
my $dbh = DBI->connect("$driver:database=$database;host=$host;user=$user;password=$passwd")or die "Can't connect: " . DBI->errstr; 
print  "OK!!\n"; 
