#!/bin/bash
# linux sed用法
# date:2018-4-10
# forked by http://dongweiming.github.io/sed_and_awk/#/3
# lst


# s与y的区别;y单个看待;s命令将查找条件字符串作为一个整体
echo "ATGATCG"|sed "y/ATCG/atcg/" # atgatcg
echo "ATGATCG"|sed "s/ATCG/atcg/" # ATGatcg
echo "ATGATCG"|sed "y/ATCG/tagc/"|rev #f反向互补
#2019-4-30更新
#在文件内容的每行都添加一个空行
'''
123
456
=====>
123

456

'''
sed G file #添加一个空行 sed "s/$/&\n/" file
sed "G;G" file #添加两个空行 sed "s/$/&\n\n/" file

#不管有无空行，只保留一个
sed "G;G" file > file1
sed "/^$/d;G" file1

#在匹配行前加空行
sed "/abc/{x;p;x}" file #在abc前加空行
sed "/abc/G" file #在abc后加空行
sed "/abc/{x;p;x;G}" file #在abc前后都加空行

#匹配c开始到d结束的行，将8替换成0. 注意：先要出现c才算匹配
# sed匹配时，第一个匹配到，即使第二个没有，第一个匹配到的行到最后一行都会被修改
# 如果第一个没匹配到，后面的无论如何都不会处理
sed "/c/,/d/ s/8/0/g" file 
sed "/c/,/z/ s/8/0/g" file #虽然没有匹配到z，但是c后面的默认都会被处理
'''
d 888       888
d c88       c00
b 888       000
c 888   ==> 000
d 888       000
c 888       000
'''
# 匹配没有c的行，将所有的8替换成a
sed '/c/ !s/8/a/g' file 
'''
d 888       aaa
d c88       c88
b 888       aaa
c 888   ==> 888
d 888       aaa
c 888       888
'''

#2019-4-16 更新

#sed精确匹配
#为了去除switch表里面的NA值，但表里面有mRNA等可以匹配NA
sed "/\<NA\>/d" file

'''
sed [option] {sed-commands} {input-file}
'''
# 加表头
cat AN3611_header.tsv|xargs -i sed '1 i {}' AN3661_col0_PAC.tsv > AN3661_col0_PAC_res.tsv
''''''
# 2018-8-20更新
''''''
# 将fasta文件中>chr1 abc改成>chr
# 对于chrMt可以先替换成chrM,后续还要和比对数据一直，可能还要改成chrMt,chrPt
cat tair10.fa|sed -e 's/chrMt/chrM/g' -e 's/chrPt/chrP/g'|sed 's/\(chr\)\(.\)\ \(.*\)/\1\2/g'
sed -r "s/^(>chr)(.) (.)*/\1\2/"
sed -r "s/(^>[A-Za-z0-9]+)(.)([a-z0-9]+)(.*)/\1\2\3/" Bamboo.Hic.pep > Bamboo.Hic.modify.pep
#替换第一行的内容为>chr1
sed '1c >chr1' TAIR10.fa
#分别打印行，打印第三行，打印前三行
sed -n 'p' /etc/passwd
sed -n '3p' /etc/passwd
sed -n '1,3p' /etc/passwd
#sed打印5-8行
sed -n '5,8p'
awk 'NR>4 && NR <9'
'''
正则
'''
# -n 取消默认输出，sed默认会输出所有文本内容，使用-n参数后只显示处理过的行
#打印root开头；打印root结尾；打印冒号：开头，匹配r然后四个单字符；匹配包含3或者5的行；匹配包含3或4或5的行;匹配1或者2的行;匹配以数字开头有至少3个至多6个数字结尾的行；删除所有注释的行和空行;windows-->linux;
sed -n '/^root/ p' file
sed -n '/root$/ p' file
sed -n '/:r..../ p' file
sed -n '/[35]/ p' file
sed -n '/[3-5]/ p' file
sed -n '/1\|2/ p' file
sed -n '/^[0-9]\{3,6\}$/ p' file
sed -e 's/#.*//' -e '/^$/ d' file
sed 's/.$//' file
-----------------
sed 's/[^,]/m/' file #将非逗号的其他元素替换成m,值替换第一个。如33,34--->m3,34
sed 's/[^,]/m/g' file #全局匹配，如33,34--->mm,mm
sed 's/([^,])/m/g' file #匹配不是逗号的一个元素，且这个元素还满足被括号包括，然后替换为m.如(3)--->(m),(33) (33,34)都不满足
sed 's/[^,]*/m/' file #匹配第一个逗号前面的所有内容，替换为m,或者将没有逗号分割的内容替换为m，如33,34--->m,34
sed 's/[^,]*/m/g' file #只保留逗号，其余的都替换成一个m。如33,34--->m,m
sed 's/([^,]*)/m/' file #匹配每行第一个括号()里面没有逗号的内容，替换成m，如(222)--->(m),(22,22)不满足
sed 's/([^,]*)/m/g' file #匹配每行都满足的
sed 's/([^,])*/m/' file #匹配每行第一个满足（开头，第二个不为逗号的元素，然后替换为m.如(222--->m22,()--->m,而(,1不满足。
sed 's/([^,])*/m/g' file #匹配每行都满足（开头，第二个不为逗号的元素，然后替换成m
sed 's/\([^,]\)/\1/g' file #匹配非逗号的元素，只匹配一次，将所有匹配的打印。如33,33将打印3
sed 's/\([^,]*\)/\1/g' file #匹配非逗号的元素，满足0个或者多个，将其替换为第一个正则匹配到的内容，即()里面满足的，如33,34打印33
echo "hello world" | sed 's/\(\b[a-Z]\)/\(\1\)/g' #输出(h)ello (w)orld
echo "hello world" | sed 's/\(\b[a-Z]*\)/\(\1\)/g' #输出(hello) (world)
echo "123"|sed 's/\|/m/g' #竖线匹配前面或者后面，输出m1m2m3m
#sed 's/\(^\|[^0-9.]\)\([0-9]\+\)\([0-9]\{3\}\)/\1\2,\3/g' numbers.txt
'''
大小写转换\l \L \u \U  \E
'''
#2019-4-19
sed "s/[atcg]/\u&/g" file #所有的atcg变成ATCG
sed 's/[A-Z]/\l&/g' file  #所有大写变小写
sed 's/\b[a-z]/\u&/g' file #每个单词的第一个小写变大写
sed 's/USER/US\lER/' file #USeR  \l将后面一个变成小写
sed 's/USER/US\LER/' file #USer  \L将后面所有变成小写
sed 's/user/us\uer/' file #usEr  \u将后面一个变成大写
sed 's/USER/US\UER/' file #usER  \U将后面所有变成大写
sed 's/i\Ulove\Elinux/' file # iLOVElinux  \E打断
echo '1,deepin,linux,open'|sed 's/\([^,]*\),\([^,]*\),\([^,]*\),\(.*\)*/\1\2\3\4/' # 1,deepin,linux,open
echo '1,deepin,linux,open'|sed 's/\([^,]*\),\([^,]*\),\([^,]*\),\(.*\)*/\1\U\2\E\3\4/' # 1DEEPINlinuxopen
echo "1,one:2,two:3,three:4,four"|sed 's/\([^:]*\):\([^:]*\):\([^:]*\):\([^:]*\)/\(\1\)\(\2\)\(\3\)\(\4\)/'	# 输出(1,one)(2,two)(3,three)(4,four)
'''
sed [option] -f {sed-commands-in-a-file} {input-file}
'''
#打印以root或者bin开头的行,与后辍名无关
#$ cat sed1.sed
#!/bin/sed -nf
#/^root/ p
#/^bin/p
sed -n -f sed1.sed /etc/passwd
'''
sed [option] -e {sed-command-1} -e {sed-command-2} {input-file}
'''
# 打印root或bin开头的行，p前面可以不加空格;用-e或者分号(;)都行
sed -n -e '/^root/ p' -e '/^bin/ p' /etc/passwd
sed -n '/^root/p;/^bin/p' /etc/passwd
#或者
sed -n \
-e '/^root/ p' \
-e '/^bin/ p' \
/etc/passwd
'''
sed [option] '{
sed-command-1
sed-command-2
}' input-file
'''
# 打印root或bin开头的行,可以写到文件里面，bash file运行
sed -n '{
/^root/ p
/^bin/ p
}' etc/passwd
#或者
sed -n '
/^root/ p
/^bin/ p
' etc/passwd
'''
隔行打印
'''
#打印奇数行,偶数行，从2行开始打印然后打印5,8,11...
sed -n '1~2 p' file # sed -n 'p;n'
sed -n '2~2 p' file # sed -n 'n;p'
sed -n '2~3 p' file
#查找包含root的行
sed -n '/root/ p' file
#从第一行到第n行，从找到开始打印到第n行,逗号前的空格不一定加
sed -n '/root/ ,n p' file
#从匹配root行打印到匹配bin的行
sed -n '/root/ ,/bin/ p' file
#匹配root行再多输出十行
sed -n '/root/ ,+10 p' file
'''
删除行 d
'''

# sed -n '/>1/,/>scaffold_21/ p' glycine_max.fa > glycine_max_chr1_to_scaffold_21.fa  取出1到scaffold的内容
# sed '/scaffold_21/d' glycine_max_chr1_to_scaffold_21.fa > glycine_max_chr1_to_chr_20.fa 去除scaffold的行，最终得到染色体的数据
# sed -i 's/>/>chr/' glycine_max_chr1_to_chr_20.fa 添加chr
# sed '/scaffold_21/,$ d' glycine_max.fa 直接删除所有的scaffold
sed 'd' file # 删除所有行，
sed '2 d' file #删除第二行，
sed '1,4 d' file #删除第一到第四行
sed '1~2 d' file #删除奇数行，
sed '2~2 d' file #删除偶数行，
sed '/root/ ,/bin/ d' file #删除root到bin的行,
sed '/^$/ d' file #删除空行，
sed '/^#/ d' file #删除注释行
sed "/\<NA\>/d" file #精确匹配
'''
重定向 w
'''
#将a.txt重定向到b.txt,-n不会在终端显示内容
sed 'w b.txt' a.txt
sed -n 'w b.txt' a.txt
#将a.txt的第二行重定向到b.txt,第一行到第四行，匹配root行到最后行,匹配奇数行
sed -n '2 w b.txt' a.txt
sed -n '2,4 w b.txt' a.txt
sed -n '/root/ ,$ w b.txt' a.txt
sed -n '1~2 w b.txt' a.txt
'''
神奇的&
'''
# &代表前面的内容
# 文件数字开头的前两个数字用[]括起来;
sed 's/^[0-9][0-9]/[&]/g' file
sed -E 's/(^[0-9]{2})/[&]/g' file
#文件所有内容用< >括起来
sed 's/^.*/<&>/' file
################
#sed -ibak 's/root/Root/' file 修改源文件同时备份
#sed --in-place=bak 's/root/Root/' file 
################
'''
行前行后添加内容以及修改行内容 a(append) i(insert) c(替换) d(删除) p(打印)
'''
# sed '[address] a the-line-to-append' input-file
sed '2 a user1,/bin/bash' file #在第二行后添加 user1,/bin/bash（变成第三行）
sed "/bin/a something " file # 匹配fish，在后面追加something
#sed '[address] i the-line-to-insert' input-file
sed '2 i user1,/bin/bash' file #在第二行前添加 user1,/bin/bash （变成第二行）
#sed '[address] c the-line-to-insert' input-file
sed '2 c user1,/bin/bash' file #将第二行的内容修改为user1,/bin/bash
#y翻译转换字符
sed 'y/root/RooT/' file #所有的root转换为RooT
#########################
#实例,把后面的mac地址冒号取消
########################
echo "130531170341903612","259594",2013-05-31T09:04:25Z,"1c:b0:94:b2:85:bd"|sed 's/\([0-9a-zA-Z]\{2\}\):\([0-9a-zA-Z]\{2\}\):\([0-9a-zA-Z]\{2\}\):\([0-9a-zA-Z]\{2\}\):\([0-9a-zA-Z]\{2\}\):\([0-9a-zA-Z]\{2\}\)/\1\2\3\4\5\6/'
"130531170341903612","259594",2013-05-31T09:04:25Z,1cb094b285bd #
-------------------------
echo "130531170341903612","259594",2013-05-31T09:04:25Z,"1c:b0:94:b2:85:bd"|sed 's/\(.*\):\(.*\):\(.*\):\(.*\):\(.*\):\(.*\)/\1\2\3\4\5\6/'
"130531170341903612","259594",2013-05-31T09:04:25Z,1cb094b285bd #
------------------------
echo "130531170341903612","259594",2013-05-31T09:04:25Z,"1c:b0:94:b2:85:bd"|sed 's/\(.*\):\(.*\):\(.*\):\(.*\):\(.*\)/\1\2\3\4\5/'
"130531170341903612","259594",2013-05-31T09:04:25Z,1c:b094b285bd #匹配满足的后五个
------------------------
echo "130531170341903612","259594",2013-05-31T09:04:25Z,"1c:b0:94:b2:85:bd"|sed 's/\(.*\):\(.*\):\(.*\):\(.*\)/\1\2\3\4/' 
130531170341903612,259594,2013-05-31T09:04:25Z,1c:b0:94b285bd #匹配满足的后四个
----------------------
echo "130531170341903612","259594",2013-05-31T09:04:25Z,"1c:b0:94:b2:85:bd"|sed -e "s/T\(.*\):\(.*\):\(.*\)Z/\1#\2#\3/" -e "s/://g" -e "s/#/:/g"
"130531170341903612","259594",2013-05-31T09:04:25Z,1cb094b285bd #先将非目标区域修改，再处理目标区域，将修改的目标区域修改回
#orf预测的文件，修改基因名
sed -r "s/(>SALT)([0-9]+)(_Cluster)([0-9]+)(-[0-9]+)(.)*/\1\2\3\4\5/" ORF_aa.fa 


---------------------------------------------
---------------------------------------------
---------------------------------------------
2018-4-25
根据基因名字提取文件中的序列
by lst
----------------------------------------------
#fasta格式中一个基因编号下面的序列是一行存在的（太长会被分开显示，实际还是一行）
#可以用linux的sed命令，打印基因名所在的行，然后再多打印一行。shell脚本中，如果向sed
#传递变量可以将sed用的单引号换做用双引号。name.txt存放要提取的基因编号，gene.fasta
#为含有目标基因的序列。记得是追加命令。
cat name.txt|while read line
do
	echo $line
	sed -n "/${line}/,+1 p" gene.fasta >> output.txt
done
---------------------------------------------
# 变量a和b，用sed的替换命令将a替换为b，四种方法
eval sed 's/$a/$b/' filename	# 加eval
sed "s/$a/$b/" filename		# 将双引号改为单引号
sed 's/'$a'/'$b'/' filename	# 变量也加上单引号
sed s/$a/$b/ filename	# 去掉引号
--------------------------------------------------------
# 以两行文件为整体进行排序，fasta文件
# 先在奇数行末尾添加一个文本内容没有的符号，比如;
#然后用sed命令，去除换行符sed ":a;N;s/\n//g;ta" filename
#在>开头添加一个空格，作为后面区分的标志
#sort排序
#awk的RS作为分隔符，输出重定向
sed -i '1~2s/$/;/' genome.fasta
sed -i 's/>/ >/' genome.fasta
sed ":a;N;s/\n//g;ta"
awk 'BEGIN{RS=" "}{print $0}' a|sort > b.txt
awk 'BEGIN{RS=";"}{print $0}' b.tx > c.txt
#删除空行
sed -i '/^$/d' c.txt 
grep -v '^$' c.txt
grep '[^$]' c.txt
awk NF c.txt
awk '!/^$/' c
---------------
sed 正则用法
------------
'删除用法'
--------------
#删除文件每一行的第一个字符
sed -r 's/^.//g' filename
sed -r 's/^(.)(.)/\2/g' filename '从右往左分别是第一个字符，第二个字符'
sed -i 's/.//' filename
#删除文件每行的第二个字符
sed -r 's/^(.)(.)/\1/g' filename
#删除文件每行的前二个字符
sed -r 's/^..//g' filename
sed -i 's/..//g' filename
#删除文件每行前K个字符
sed -i 's/.\{5\}//g' filename
#删除文件每行的最后一个字符
sed -r 's/(.)$//g' filename
sed -r 's/(.)(.)$/\1/g' filename
#删除每行的倒数第二个字符
sed -r 's/(.)(.)$/\2/g' filename
#删除每行的第二个单词
sed -r 's/^([a-Z]+)([^0-9][^a-Z])([a-Z])/\1\2/g' filename
#删除每行的倒数第二个单词
sed -r 's/([a-Z]+)([^a-Z])([a-Z]+)$/\2\3/g' filename
#删除每行的最后一个单词
sed -r 's/([a-Z]+)$//g' filename
#删除所有的数字
sed -r 's/[0-9]//g' filename
#删除每行开头的所有空格
sed -r 's/^ //g' filename
#删除换行符
sed ":a;N;s/\n//g;ta" filename
#删除空行
sed -i '/^$/d' c.txt 
grep -v '^$' c.txt
grep '[^$]' c.txt
awk NF c.txt
awk '!/^$/' c

----------------
'添加用法'
-----------------
#在行首添加双引号（"）
sed 's/^/"&/g' filename
#在行尾添加双引号
sed 's/$/"&/g' filename
#在行首和行尾添加双引号
cat filename|sed 's/^/"&/g'|sed 's/$/"&/g'
#在行首添加双引号，在行尾添加双引号和逗号
cat filename|sed 's/^/"&/g'|sed 's/$/",&/g'  '添加多个符号可以连着写'
-----------------------------------
'交换用法'
----------------------------------
#交换每行的第一个字符和第二个字符
sed -r 's/^().(.)/\2\1/g' filename 
#交换每行的第一个字符和第二个单词
sed -r 's/^(.)([a-Z]+)([^0-9][^a-Z]+)([a-Z]+)([^0-9][^a-Z])/\4\2\3\1\5/g' filename
#交换每一行的第一个单词和最后一个单词
sed -r 's/^([a-Z0-9]+)([^a-Z0-9]+)(.+)([^a-Z0-9]+)([a-Z0-9]+)/\5\2\3\4\1/g' filename
#用制表符替换空格
sed -r 's/ /\t/g' filename
-----------------------------
'其他用法'
----------------------------
#把所有的大写字母用括号括起来
sed -r 's/[A-Z]/(&)/g' filename
#打印每行三次
sed 'p;p' filename
#只显示每行的第一个单词
sed -r 's/([^0-9a-Z]+)(.+))//g' filename
#打印每行的第一个单词和第三个单词
sed -r 's/^([a-Z0-9]+)(.{3})([0-9]+)(.)([0-9]+)(.)([a-Z]+)(.+)/\1\7/g' filename
#用命令获取格式为 mm/yy/dd 的日期格式，结合管道，将其换成   mm；yy；dd格式
date "+%m/%y/%d" | sed -r 's/\//\-/g'
--------------------------------------

#2019-5更新
#sed 高级模式
#参考https://coolshell.cn/articles/9104.html
# update 2019-5-1
'''
^ 表示一行的开头。如：/^#/ 以#开头的匹配。
$ 表示一行的结尾。如：/}$/ 以}结尾的匹配。
\< 表示词首。 如：\<abc 表示以 abc 为首的詞。
\> 表示词尾。 如：abc\> 表示以 abc 結尾的詞。
. 表示任何单个字符。
* 表示某个字符出现了0次或多次。
[ ] 字符集合。 如：[abc] 表示匹配a或b或c，还有 [a-zA-Z] 表示匹配所有的26个字符。如果其中有^表示反，如 [^a] 表示非a的字符
'''
#从html获取tag
#<b>hello</b> world <span style="text-decoration: underline;">sed</span> is useful?
sed "s/<[^>]*>//g" html.txt
#指定行
sed "2s/h/H/g" #只对第二行操作
sed "2，5s/h/H/g" #对第2行到第5行操作
sed "2，$s/h/H/g" #对第2行到最后一行操作
#指定每一行的第几个
sed "s/h/H/1" #替换每一行的第一个
sed "s/h/H/2" #替换每一行的第二个
sed "s/h/H/3g" #替换每一行的第三个及以后
#--------------------------------------
# 读入下一行，追加到模式空间行后面，此时模式空间有两行。
sed 'N;s/my/your/' file # 等同 sed '1~3s/my/your/' file
'''
      raw                       sed
This is my cat              This is your cat
  my cats name is betty       my cats name is betty
This is my dog              This is your dog
  my dogs name is frank       my dogs name is frank
This is my fish             This is your fish
  my fishs name is george     my fishs name is george
This is my goat             This is your goat
  my goats name is adam       my goats name is adam  
'''
# N处理后变成如下格式
# This is my cat\n  my cat's name is betty
# This is my dog\n  my dog's name is frank
# This is my fish\n  my fish's name is george
# This is my goat\n  my goat's name is adam
  
#前两行变成一行的办法
sed 'N;s/\n/,/' file
# sed -n '{N;s/\n/,/p}' file
# awk '{if(NR%2!=0)ORS=",";else ORS="\n"}{print $0}' file
# awk '{if(NR%2==0)ORS="\n";else ORS=","}1' file

# 输出结果如下
# This is my cat,  my cat's name is betty
# This is my dog,  my dog's name is frank
# This is my fish,  my fish's name is george
# This is my goat,  my goat's name is adam

# address可以是一个数字，也可以是一个模式，
#你可以通过逗号要分隔两个address 表示两个address的区间
sed '/dog/,+3s/^/# /g' #表示匹配dog行以及后面连续的3行，在开头加# 。
  
#cmd可以是多个，它们可以用分号分开，可以用大括号括起来作为嵌套命令
sed '3,6 {/This/d}' file.txt # 匹配3到6行，删除含有This的行

sed '3,6 {/This/{/fish/d}}' file.txt # 匹配3到6行，然后匹配含有This的行，再匹配fish，即删除两者同时存在的行

sed '1,${/This/d;s/^ *//g}' file.txt #删除含有This的行，删除空格开头的行

# hold space
'''
p： 把模式空间复制到标准输出
P： 打印从开始到第一个\n的内容，sed并不对每行末尾\n进行处理，
    但是对N命令追加的行间\n进行处理，因为此时sed将两行看做一行。
d： 删除当前模式空间内容（不在传到标准输出）并放弃之后的命令，读取新内容重新执行sed
D： 删除当前模式空间开端至\n换行符内容（不在传到标准输出）并放弃之后的命令，
    但是剩余模式空间内容重新执行sed  
n： 提前读取下一行，覆盖模式空间前一行（并没有删除，因此依然打印至标准输出）
    如果命令未执行成功，则放弃后面的命令，读取下一行再执行sed
N： N 追加下一行到当前行，把两行看作一行，但是\n换行符还在
g： 将hold space中的内容拷贝到pattern space中，原来pattern space里的内容清除
G： 将hold space中的内容append到pattern space\n后
h： 将pattern space中的内容拷贝到hold space中，原来的hold space里的内容被清除
H： 将pattern space中的内容append到hold space\n后
x： 交换pattern space和hold space的内容
!： 对所选行以外的所有行应用命令。
'''
# 如下文本内容 file：
# one
# two
# three
# four

---------------
sed "{x;p;x}" #在所有行前后插入空行
sed "/two/{x;p;x}" #在匹配two的行前后插入空行
----------------
sed "{x;p}" #输出 空格\n空格\n\one\n\one\n\two\n\two\n\three\n\three\n; 没有four
sed "{p;x}" #输出 one\n空格\n\two\n\one\nthree\n\two\n\four\n\three
----------------
sed = file.txt|sed N #添加行号，行号是一行;cat -n file
sed = file.txt|sed "N;s/\n/\t/" #行号和内容是一行，tab隔开
sed '/./=' html.txt|sed '/./N;s/\n/ /' #不对空行编号（注意不是空格）；nl file
----------------
sed q file # head -1
sed 10q file # head -10
sed -n '$=' # wc -l;必须单引号
-----------------
sed 'n;G' # 在偶数行后加空格
sed 'G;n' # 在奇数行后加空格
sed 'n;d' # 删除偶数行












