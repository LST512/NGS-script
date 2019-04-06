#!/usr/bin/perl -w
#lst
#2019-4-5
# get sequence from id and fa
#use strict;
#输出的文件序列原始
if (scalar @ARGV == 0 ){# scalar @ARGV,获取数组长度
    die "Usage: perl $0 <id> <fa file>";
}
#my %hash = ();#建空的哈希
open IN,"<$ARGV[0]";#打开id文件
while (<IN>){
    chomp;#去除\n
    $hash{$_}="lst";#设定id为哈希的key，value随意
}
close IN;

open FA,"<$ARGV[1]";#打开fasta文件
$/=">";#设定>为换行符
while (<FA>){
    
    chomp;#去掉换行符>,此时/n不是换行符
    
    #print $_;
    my $id = (split("\n",$_,2))[0];#n作为分隔符，直接取第一列
    #my ($id,$seq) = (split /\n/,$_,2);#\n作为分隔符，分成两列
    #print "$id\n";
    #print "$seq\n";
    #
    #$A = $hash{$id};#赋值
    #if (!$A){#判断字符串是否为J空字符
    #
    if (exists $hash{$id}){
        print ">$_";
        #print ">$id\n$seq\n";#如果my ($id,$seq) = (split /\n/,$_);$seq\n要带\n.
    }
    else{
        next;
    }
}
print "\n";
close FA;