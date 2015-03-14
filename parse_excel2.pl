#!/usr/bin/perl
use strict;
use Spreadsheet::ParseExcel;
use Excel::Writer::XLSX;
use File::Basename;
use File::Spec;
use Encode;

my $file = shift;
my $out = File::Spec->catfile( dirname($file), "newdata.xlsx" );
my $newbook  = Excel::Writer::XLSX->new($out);
my $parser   = Spreadsheet::ParseExcel->new();
my $workbook = $parser->parse($file);
my $storage_book;

if ( !defined $workbook ) {

    die $parser->error() . "\n";
}
for my $worksheet ( $workbook->worksheets() ) {
    my ( $row_min, $row_max ) = $worksheet->row_range();
    my ( $col_min, $col_max ) = $worksheet->col_range();
    my $sheet_name = $worksheet->get_name();
    for my $row ( $row_min ... $row_max ) {
        for my $col ( $col_min ... $col_max ) {
            my $cell = $worksheet->get_cell( $row, $col );
            next unless $cell;
			$storage_book->{$sheet_name}->{$row}->{$col} = $cell->value();
		}
    }
}
my $j = 0;
foreach my $sheet_name (  keys %{$storage_book} ){
    my $newsheet = $newbook->add_worksheet($sheet_name);
    foreach my $row ( keys %{ $storage_book->{$sheet_name} } ) {
        my @arr;
        foreach my $col ( sort {$a cmp $b} keys %{ $storage_book->{$sheet_name}->{$row} } ) {
            my $e = $storage_book->{$sheet_name}->{$row}->{$col};
            my $val = &judge($e);
            $newsheet->write( $row,$col,$val );
        }
    }
}

sub judge() {
    my $value = shift;
	if($value > 1){
		return 1;
	}else{
		return $value;
	}
}

