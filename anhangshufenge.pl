local $/=">";
open (IN, "$ARGV[0]" ) || do {
        print "\n���k�����_�ļ�$ARGV[0]��\n\nʹ�÷�����\nsplitfile �ļ��� ����Д�\n";
        exit 0; };
@char = <IN>;
close IN;

!$ARGV[1] && do {
        print "\nՈָ������Д���\n\nʹ�÷�����\nsplitfile �ļ�������Д�\n";
        exit 0; };
@char<=$ARGV[1] && do {
        print "\nָ��������Д����^�ļ����Д���$ARGV[0]�ӱ�Ҫ��֡�\n";
        exit 0; };
( $j = @char/$ARGV[1] ) =~ s/\..*//;

@char%$ARGV[1] && $j++;

for ($i=1, $f=A; $i<=$j; $i++, $f++) {
    
        open ($f, ">$i.txt" ) || do {
            print $f."\n";
        print "\n�����ļ����ָ�$i.txt��ʧ����\n";
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