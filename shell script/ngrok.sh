#远程机ip:22
# ssh -p 端口 polya@ip




sudo mv sunny /usr/local/bin/sunny
sudo chmod +x /usr/local/bin/sunny
sudo vim /etc/init.d/sunny

###############################
#!/bin/sh -e
### BEGIN INIT INFO
# Provides:          ngrok.cc
# Required-Start:    $network $remote_fs $local_fs
# Required-Stop:     $network $remote_fs $local_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: autostartup of ngrok for Linux
### END INIT INFO

NAME=sunny
DAEMON=/usr/local/bin/$NAME
PIDFILE=/var/run/$NAME.pid

[ -x "$DAEMON" ] || exit 0

case "$1" in
  start)
      if [ -f $PIDFILE ]; then
        echo "$NAME already running..."
        echo -e "\033[1;35mStart Fail\033[0m"
      else
        echo "Starting $NAME..."
        start-stop-daemon -S -p $PIDFILE -m -b -o -q -x $DAEMON -- clientid 隧道id || return 2
        echo -e "\033[1;32mStart Success\033[0m"
    fi
    ;;
  stop)
        echo "Stoping $NAME..."
        start-stop-daemon -K -p $PIDFILE -s TERM -o -q || return 2
        rm -rf $PIDFILE
        echo -e "\033[1;32mStop Success\033[0m"
    ;;
  restart)
    $0 stop && sleep 2 && $0 start
    ;;
  *)
    echo "Usage: $0 {start|stop|restart}"
    exit 1
    ;;
esac
exit 0
###############################

sudo chmod 755 /etc/init.d/sunny
sudo /etc/init.d/sunny start
sudo /etc/init.d/sunny start    #启动
sudo /etc/init.d/sunny stop     #停止
sudo /etc/init.d/sunny restart  #重启

#设置开机启动
cd /etc/init.d
sudo update-rc.d sunny defaults 90    #加入开机启动
sudo update-rc.d -f sunny remove  #取消开机启动


sudo chkconfig --add sunny     #添加系统服务
sudo chkconfig --del sunny    #删除系统服务
sudo chkconfig --list        #查看系统服务
sudo chkconfig sunny on     #设置开机启动
sudo chkconfig sunny off     #设置取消启动
service sunny start         #启动
service sunny stop             #关闭
service sunny restart         #重启














