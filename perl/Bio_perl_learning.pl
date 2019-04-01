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





#从文件中读取数据





























