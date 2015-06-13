local $/=">";
open (IN, "$ARGV[0]" ) || do {
        print "\n冇辦法打開文件$ARGV[0]。\n\n使用方法：\nsplitfile 文件名 拆分行數\n";
        exit 0; };
@char = <IN>;
close IN;

!$ARGV[1] && do {
        print "\n請指定拆分行數。\n\n使用方法：\nsplitfile 文件名拆分行數\n";
        exit 0; };
@char<=$ARGV[1] && do {
        print "\n指定嘅拆分行數大過文件總行數，$ARGV[0]冇必要拆分。\n";
        exit 0; };
( $j = @char/$ARGV[1] ) =~ s/\..*//;

@char%$ARGV[1] && $j++;

for ($i=1, $f=A; $i<=$j; $i++, $f++) {
    
        open ($f, ">$i.txt" ) || do {
            print $f."\n";
        print "\n創建文件「分割$i.txt」失敗！\n";
        exit 0; };
        &RW($f);
        close ($f);
}
sub RW {
        my ($a) = @_;
        @$a = splice (@char, 0, $ARGV[1]);
        select $a;
        print @$a;
}
#C:\Users\lf\Desktop\anhangshufenge.pl