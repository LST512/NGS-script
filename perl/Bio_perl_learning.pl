#!/usr/bin/perl -w

#2019-4-1
#learn perl
#lst

=pod 多行注释



#记得分号结尾; exit非必须; 双引号可以识别变量等，单引号不能识别变量。
$DNA1 = "AtCGATCG";
$DNA2 = "AAAAGGGG";
$DNA3 = $DNA1 . $DNA2;
$DNA4 = "$DNA1$DNA2";
#连接两个DNA,加\n终端（zsh）不会出现%号.\n\n输出一行空格
print $DNA3,"\n";
print $DNA1,$DNA2,"\n";
print "$DNA1$DNA2\n\n";
print "$DNA1$DNA2","\n";
print $DNA1.$DNA2,"\n";
#{}可以确定具体变量
print "result:${DNA1}${DNA2}end\n";
#print "result:$DNA1$DNA2end\n";#报错

=cut

=pod
#DNA----> RNA
$RNA = $DNA3;
$RNA =~ s/T/U/gi;#i,忽略大小写;m;s,single line 单行;x;o;e
print $RNA,"\n";
#其它写法，写在一行用括号先传递变量
($RNA1 = $DNA1) =~ s/T/U/gi;
print $RNA1,"\n";



#反向互补
$DNA = "ATCG";
#反向
$rev = reverse $DNA;
print $rev,"\n";
#互补,用tr
$rev =~ tr/ATCGatcg/TAGCtagc/;
print $rev,"\n";

=cut

=pod
#perl的匹配
\w 匹配一个字母、数字或下划线字符，相当于[a-zA-Z_0-9]
\s 匹配一个空字符
\d 匹配一个数字
\b 匹配单词的首尾
=cut
=pod
#s///;tr///的用法
$str = "What a wonderful wonderful world.";
($str1 = $str) =~ s/w/'$&'/g; #$&代表比对到的字符串；等同于$str =~ s/w/'w'/g;sed的用[&]代表匹配的字符
print $str1,"\n";
#匹配小w，然后将该单词变成大写。
($str2 = $str) =~ s/w\w+/uc($&)/g; #What a uc(wonderful) uc(wonderful) uc(world).
($str2 = $str) =~ s/w\w+/uc($&)/ge; #What a WONDERFUL WONDERFUL WORLD.
($str2 = $str) =~ s/w\w+/uc($&)/gie; #WHAT a WONDERFUL WONDERFUL WORLD.
print $str2,"\n";

#字符串的换行。字串中的换行字元 '\n' 被当成是一个字元来处理
$str = "What a wonder\nful wonderful world.";
($str1 = $str) =~ s/wonder.?ful/www/g;
print $str1,"\n";
#What a wonder
#ful www world.
#加s，single line； s修饰子后，\n就等于是"一个字元"，也等于'\n'；
($str2 = $str) =~ s/wonder.?ful/www/gs;#等于$str =~ s/wonder\nful/www/g;
print $str2,"\n";
#What a www www world.


#m的用法，一般比对时假设要找出字串结尾的字串，常会用变换字元 $，
#在带有换行的字串中，变换字元 $只会比对最后的换行或是字串结尾。
#如果希望 $能取得符合带有换行的字串中，每个换行都视为结尾的话，就要加 m。
$str = "line123\nline456\nline78";
($str1 = $str) =~ s/\d+$//g; 
#line123
#line456
#line #不加m，只比对最后一个,即lin78的78会被替换

($str2 = $str) =~ s/\d+$//gm; 
#等同于($str2 = $str) =~ s/[0-9]//g
#echo "line123\nline456\nline78"|sed 's/[0-9]//g'
#line #每个换行符号都视为结尾。都会被替换
#line
#line
print "$str1\n\n$str2\n";

=cut

=pod
#tr的用法
#大写换成小写，“同时”小写也换成大写。s不能用，tr可以
$str = "Aine123\nBine789";
$str =~ tr/a-zA-Z/A-Za-z/;
print $str,"\n";
#tr计算字数，自己换成自己就好
print $str =~ tr/a-zA-Z/A-Za-z/,"\n";#返回数字8，满足替换的字母一共8个
#或者下面的固定写法
$count = $str =~ tr/a-zA-Z/A-Za-z/;#统计大小写变换的个数
print $count,"\n";
$count=$temp=~tr/A//; #表示计算$temp中出现A的次数，等于$count=$temp=~tr/A/A/; 
#/c指不匹配的字符替换
$temp="AAAABCDEF";
$count=$temp=~tr/A/H/c;
print "$temp\t$count\n"; #返回AAAAHHHHH 5
#
$doc="ABcd[]00"; 
$doc =~ y/a-zA-Z/a-z/c; #虽然写了a-z，但是只匹配最后一个z；y等于tr
print $doc,"\n"; #ABcdzzzz


#/d:表示把匹配上的字符全部替换
$temp="AAAABCDEF";
$count=$temp=~ tr/A/H/d;#可以不写d，写了会提示无效。
print "$temp\t$count\n"; #HHHHBCDEF	4


#/s：表示如果要替换的字符中出现连续多个一样的字符，则去冗余：
$temp="AAAABCDEF";
$count=$temp=~ tr/A/H/s;
print "$temp\t$count\n"; #HBCDEF	4

=cut




=pod
#从文件中读取数据
$filename = "/home/lst/Desktop/content.txt";
open(FILE,$filename);#文件句柄一般大写。小写会提示有问题，不影响结果。
$file1 = <FILE>;#读写第一行
print $file1;
$file1 = <FILE>;#读写第二行
print $file1;
close file1;
=cut

=pod

#一次读取完数据
$filename = "/home/lst/Desktop/content.txt";
open(FILE,$filename);
@file1 = <FILE>;#@指数组变量，储存多个标量值的变量
close file1;#close在print前后对输出结果貌似没影响
print @file1,"\n";
exit;

=cut











=pod
#数组@的用法
##打印元素
@base = ('A',"T",'C','G');
#@base = qw/A T C G/;
print @base,"\n";#打印所有元素；ATCG
print @base[0..3],"\n";#取所有元素ATCG
print "@base\n";#空格隔开；A T C G
print join("\t",@base),"\n";#用join自定义输出格式
print join"\t",@base,"\n";#不用括号也行
#循环自定义输出格式
foreach $line(@base){
    print "$line";
    print "\t";#可以换成别的符号；
}

print "\n";#只为了换行
print $base[0],"\n";#用的$符号，打印第一个元素；等同于print @base[0],"\n";A


=POP
## pop去掉数组最后一个元素
@base = ('A',"T",'C','G');
$base1 = pop @base;
print $base1,"\n";#G
print @base,"\n";#ATC


## shift去掉数组第一个元素
@base = ('A',"T",'C','G');
$base2 = shift @base;
print $base2,"\n";#A
print @base,"\n";#TCG
## unshift添加一个元素到表头
unshift (@base,$base2);
print @base,"\n";#恢复ATCG


## push添加元素到末尾
#@base = ('A',"T",'C','G');
@base = qw/A T C G/;
$base1 = shift @base;
push (@base,$base1);#先数组，再元素。
print @base,"\n";#TCGA
##反转数组
@reverse = reverse @base;
print @reverse,"\n";#AGCT
##获取数组长度
print scalar @reverse,"\n";#4



## splice 替换数组；splice(@ARRAY,OFFSET,LENGTH,LIST)
#@ARRAY：要替换的数组。
#OFFSET：起始位置。
#LENGTH：替换的元素个数。
#LIST：替换元素列表。

#任意位置插入
@base = qw/A T C G 1 2 3 4/;
splice (@base,2,0,'x');
print @base,"\n";#ATxCG1234
splice (@base,2,2,'mnop');#xc被mnop替换
print @base,"\n";#ATmnopG1234
#替换(插入)。
@nums = (1..10);
print "替换前 - @nums\n";# 1 2 3 4 5 6 7 8 9 10
splice(@nums, 2, 3, 21..28); #从第二位开始，用21-28替换3,4,5。替换不必一定相等
print "替换后 - @nums\n";#1 2 21 22 23 24 25 26 27 28 6 7 8 9 10

#数组的插入
@a = (1..5);
@b = (a..h);
print "原始  @a\n";#1 2 3 4 5
splice(@a , 2 , 2 , @b);
print "插入  @a\n";#1 2 a b c d e f g h 5

#删除；splice(@ARRAY,OFFSET,LENGTH)
@a = (1..10);
print "原始  @a\n";#1 2 3 4 5 6 7 8 9 10
splice(@a , 2 , 6);
print "删除  @a\n";#1 2 9 10
=cut

#删除到末尾 splice(@ARRAY,OFFSET)
@a = (1..10);
print "原始  @a\n";#1 2 3 4 5 6 7 8 9 10
splice(@a , 2);
print "删除  @a\n";# 1 2






































