一、新建磁盘分区作为swap分区
1.以root身份进入控制台（登录系统），输入
# swapoff -a #停止所有的swap分区

2. 用fdisk命令（例：# fdisk /dev/sdb）对磁盘进行分区，添加swap分区，新建分区，在fdisk中用“t”命令将新添的分区id改为82（Linux swap类型），最后用w将操作实际写入硬盘（没用w之前的操作是无效的）。

3. # mkswap /dev/sdb2 #格式化swap分区，这里的sdb2要看您加完后p命令显示的实际分区设备名

4. # swapon /dev/sdb2 #启动新的swap分区

5. 为了让系统启动时能自动启用这个交换分区，可以编辑/etc/fstab,加入下面一行
/dev/sdb2 swap swap defaults 0 0


二、用文件作为Swap分区

1.创建要作为swap分区的文件:增加1GB大小的交换分区，则命令写法如下，其中的count等于想要的块的数量（bs*count=文件大小）。
# dd if=/dev/zero of=/root/swapfile bs=1M count=1024

2.格式化为交换分区文件:
# mkswap /root/swapfile #建立swap的文件系统

3.启用交换分区文件:
# swapon /root/swapfile #启用swap文件

4.使系统开机时自启用，在文件/etc/fstab中添加一行：
/root/swapfile swap swap defaults 0 0



新建和增加交换分区用到的命令为：mkswap、swapon等，而想关闭掉某个交换分区则用“swapon /dev/sdb2”这样的命令即可。
--------------------------------------------------------------------
1、检查 Swap 空间，先检查一下系统里有没有既存的 Swap 文件
swapon -s
如果返回的信息概要是空的，则表示 Swap 文件不存在。

2、确定swap文件的大小，单位为M。将该值乘以1024得到块大小。例如，64MB的swap文件的块大小是65536。

3、创建 Swap 文件，下面使用 dd 命令来创建 Swap 文件。
dd if=/dev/zero of=/swapfile bs=1024 count=4194304

【参数说明】
if=文件名：输入文件名，缺省为标准输入。即指定源文件。< if=input file >
of=文件名：输出文件名，缺省为标准输出。即指定目的文件。< of=output file >
bs=bytes：同时设置读入/输出的块大小为bytes个字节
count=blocks：仅拷贝blocks个块，块大小等于bs指定的字节数。

4、创建好Swap文件，还需要格式化后才能使用。运行命令：
mkswap /swapfile

5、激活 Swap ，运行命令：
swapon /swapfile

6、如果要机器重启的时候自动挂载 Swap ，那么还需要修改 fstab 配置。
用 vim 打开 /etc/fstab 文件，在其最后添加如下一行：
/swapfile   swap   swap    defaults 0 0

当下一次系统启动时，新的swap文件就打开了。

7、添加新的swap文件并开启后，检查 cat /proc/swaps 或者free命令的输出来查看swap是否已打开。

8、最后，赋予 Swap 文件适当的权限：
chown root:root /swapfile 
chmod 0600 /swapfile

9、删除SWAP分区
$ swapoff  /swapfile  #卸载swap文件
$ 并修改/etc/fstab文件 #从配置总删除
$ rm -rf /swapfile  #删除文件
