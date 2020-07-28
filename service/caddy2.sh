#!/usr/bin/env bash
# chkconfig: 2345 90 10
# description: Fast, multi-platform web server with automatic HTTPS

### BEGIN INIT INFO
# Provides:          caddy2
# Required-Start:    $network $syslog
# Required-Stop:     $network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: It can help you improve network speed
# Description:       Start or stop the  caddy server
### END INIT INFO


if [ -f /usr/local/caddy/caddy ]; then
    DAEMON=/usr/local/caddy/caddy
fi

NAME=caddy
CONF=/usr/local/caddy/Caddyfile
PID_DIR=/var/run
PID_FILE=$PID_DIR/$NAME.pid
RET_VAL=0

[ -x $DAEMON ] || exit 0

check_pid(){
	get_pid=`ps -ef |grep -v grep |grep -v "init.d" |grep -v "service" |grep $NAME |awk '{print $2}'`
}

check_pid
if [ -z $get_pid ]; then
    if [ -e $PID_FILE ]; then
        rm -f $PID_FILE
    fi
fi

if [ ! -d $PID_DIR ]; then
    mkdir -p $PID_DIR
    if [ $? -ne 0 ]; then
        echo "Creating PID directory $PID_DIR failed"
        exit 1
    fi
fi

if [ ! -f $CONF ]; then
    echo "$NAME config file $CONF not found"
    exit 1
fi


check_running() {
    if [ -e $PID_FILE ]; then
        if [ -r $PID_FILE ]; then
            read PID < $PID_FILE
            if [ -d "/proc/$PID" ]; then
                return 0
            else
                rm -f $PID_FILE
                return 1
            fi
        fi
    else
        return 2
    fi
}

do_status() {
    check_running
    case $? in
        0)
        echo "$NAME (pid $PID) is running."
        ;;
        1|2)
        echo "$NAME is stopped"
        RET_VAL=1
        ;;
    esac
}

do_start() {
    if check_running; then
        echo "$NAME (pid $PID) is already running."
        return 0
    fi
    ulimit -n 51200
    nohup "$DAEMON" run --config "$CONF" > /dev/null 2>&1 &
    check_pid
    echo $get_pid > $PID_FILE
    if check_running; then
        echo "Starting $NAME success"
    else
        echo "Starting $NAME failed"
        RET_VAL=1
    fi
}

do_stop() {
    if check_running; then
        kill -9 $PID
        rm -f $PID_FILE
        echo "Stopping $NAME success"
    else
        echo "$NAME is stopped"
        RET_VAL=1
    fi
}

do_restart() {
    do_stop
    sleep 0.5
    do_start
}

case "$1" in
    start|stop|restart|status)
    do_$1
    ;;
    *)
    echo "Usage: $0 { start | stop | restart | status }"
    RET_VAL=1
    ;;
esac

exit $RET_VAL