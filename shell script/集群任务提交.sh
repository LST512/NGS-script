#!/bin/bash
#lst
# 集群上提交任务
# sge(Sun Grid Engine);PBS(Portable Batch System)


#SGE
'''
SGE的工作原理 
Sun Grid Engine 软件为用户提供了向Sun Grid Engine 系统提交要求计算的任务的方法，
以透明地分配相关的工作负荷。用户可以向Sun Grid Engine 系统提交批处理作业、交互式作业和并行作业。 

Sun Grid Engine用以下方式调解可用资源和作业需求:
通过Sun Grid Engine 系统提交作业的用户描述出作业需求的概况。
此外，系统还要检索用户的身份以及他或她与项目或用户组的从属关系。
用户提交作业的时间也将存储起来。 

SGE的组成:
节点（Hosts） 
后台 程序（Daemons） 
sge_qmaster – the Master Daemon 
sge_schedd – the Scheduler Daemon 
sge_execd – the Execution Daemon 
sge_commd – the Communication Daemon 
 队列（Queues） 
'''

qconf -ae hostname
    添加执行主机
qconf -de hostname
    删除执行主机
qconf -sel
    显示执行主机列表

qconf -ah hostname
    添加管理主机
qconf -dh hostname
    删除管理主机
qconf -sh
    显示管理主机列表

qconf -as hostname
    添加提交主机
qconf -ds hostname
    删除提交主机
qconf -ss
    显示提交主机列表

qconf -ahgrp groupname
    添加主机用户组
qconf -mhgrp groupname
    修改主机用户组
qconf -shgrp groupname
    显示主机用户组成员
qconf -shgrpl
    显示主机用户组列表

qconf -aq queuename
    添加集群队列
qconf -dq queuename
    删除集群队列
qconf -mq queuename
    修改集群队列配置
qconf -sq queuename
    显示集群队列配置
qconf -sql
    显示集群队列列表

qconf -ap PE_name
    添加并行化环境
qconf -mp PE_name
    修改并行化环境
qconf -dp PE_name
    删除并行化环境
qconf -sp PE_name
    显示并行化环境
qconf -spl
    显示并行化环境名称列表

qstat -f
    显示执行主机状态
qstat -u user
    查看用户的作业
qhost
    显示执行主机资源信息

qsub简单示例：
$ qsub -V -cwd -o stdout.txt -e stderr.txt run.sh
#其中run.sh中包含需要运行的程序，其内容示例为如下三行：
#!/bin/bash
#$ -S /bin/bash
perl -e 'print "abc\n";print STDERR "123\n";'

qsub的常用参数：
-V
    将当前shell中的环境变量输出到本次提交的任务中。
-cwd
    在当前工作目录下运行程序。默认设置下，程序的运行目录是当前用户在其计算节点的家目录。
-o
    将标准输出添加到指定文件尾部。默认输出文件名是$job_name.o$job_id。
-e
    将标准错误输出添加到指定文件尾部。默认输出文件名是$job_name.e$job_id。
-q
    指定投递的队列，若不指定，则会尝试寻找最小负荷且有权限的队列开始任务。
-S
    指定运行run.sh中命令行的软件，默认是tcsh。推荐使用bash，设置该参数的值为 /bin/bash 即可，或者在run.sh文件首部添加一行#$ -S /bin/bash。若不设置为bash，则会在标准输出中给出警告信息：Warning: no access to tty (Bad file descriptor)。
-hold_jid
    后接多个使用逗号分隔的job_id，表示只有在这些job运行完毕后，才开始运行此任务。
-N
    设置任务名称。默认的job name为qsub的输入文件名。
-p
    设置任务优先级。其参数值范围为 -1023 ~ 1024 ，该值越高，越优先运行。但是该参数设置为正数需要较高的权限，系统普通用户不能设置为正数。
-j y|n
    设置是否将标准输出和标准错误输出流合并到 -o 参数结果中。
-pe
    设置并行化环境。

任务提交后的管理：

$ qstat -f
    查看当前用户在当前节点提交的所有任务，任务的状态有4中情况：qw，等待状态，刚提交任务的时候是该状态，一旦有计算资源了会马上运行；hqw，该任务依赖于其它正在运行的job，待前面的job执行完毕后再开始运行，qsub提交任务的时候使用-hold_jid参数则会是该状态；Eqw，投递任务出错；r，任务正在运行；s，被暂时挂起，往往是由于优先级更高的任务抢占了资源；dr，节点挂掉后，删除任务就会出现这个状态，只有节点重启后，任务才会消失。

$ qstat -j jobID
    按照任务id查看

$ qstat -u user
    按照用户查看

$ qdel -j jobID
    删除任务






#PBS

'''
PBS(Portable Batch System)最初由NASA的Ames研究中心开发，
主要为了提供一个能满足异构计算网络需要的软件包，用于灵活的批处理，
特别是满足高性能计算的需要,如集群系统、超级计算机和大规模并行系统。
PBS的主要特点有：代码开放，免费获取；支持批处理、交互式作业和串行、多种并行作业，
如MPI、 PVM、HPF、MPL；PBS是功能最为齐全, 历史最悠久, 支持最广泛的本地集群调度器之一。
PBS的目前包括openPBS, PBS Pro和Torque三个主要分支. 其中OpenPBS是最早的PBS系统,
目前已经没有太多后续开发,PBS pro是PBS的商业版本, 功能最为丰富. 
Torque是Clustering公司接过了OpenPBS, 并给与后续支持的一个开源版本. 
'''

# Notes
'''
两者使用的命令好多都是相同的，所以一定要提前问清楚管理员是哪个系统，
因为在写任务提交脚本时，是有不同的。
'''
##############################################################################















