#!/usr/bin/perl -w
#lst
#2019-4-6
# 根据id提取序列
#输出的序列一行

#需要两个三个参数
# id list
# fasta file
# output file


# 判断参数是否合格
unless ( scalar @ARGV == 3 ){
    die "Usage: perl $0 <id file> <fasta file> <output file>";
}
#初始化
my ($ID,$FA,$OUT)=@ARGV;
#my %hash = ();#可以不用写

open FA,$FA;#第二个参数
open ID,$ID;#读取id
open OUT,">$OUT";#写入文件,用引号
#将fasta文件转成哈希
while (<FA>) {#记得加括号
    chomp;
    if (/^>.*/){
        $id = $_;
    }
    else{
        $hash{$id} .= $_;#序列存在一起
    }
}
#根据id获取序列
while (<ID>){
    chomp;
    if (/^>.*/){
        $ID = $_;#自带>
        print OUT $ID."\n".$hash{$ID}."\n";
    }
    else{
        $ID = ">$_";#加>
        print OUT $ID."\n".$hash{$ID}."\n";
    }
}

close FA;
close ID;
close OUT;