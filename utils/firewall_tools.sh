get_version(){
    if [[ -s /etc/redhat-release ]]; then
        grep -oE  "[0-9.]+" /etc/redhat-release
    else
        grep -oE  "[0-9.]+" /etc/issue
    fi
}

centosversion(){
    if check_sys sysRelease centos; then
        local code=$1
        local version="$(get_version)"
        local main_ver=${version%%.*}
        if [ "$main_ver" == "$code" ]; then
            return 0
        else
            return 1
        fi
    else
        return 1
    fi
}

config_firewall(){
    if centosversion 6; then
        /etc/init.d/iptables status > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            iptables -L -n | grep -i ${shadowsocksport} > /dev/null 2>&1
            if [ $? -ne 0 ]; then
                if [[ ${plugin_num} == "2" ]]; then
                    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${listen_port} -j ACCEPT
                    iptables -I INPUT -m state --state NEW -m udp -p udp --dport ${listen_port} -j ACCEPT
                else
                    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${shadowsocksport} -j ACCEPT
                    iptables -I INPUT -m state --state NEW -m udp -p udp --dport ${shadowsocksport} -j ACCEPT
                fi
                
                /etc/init.d/iptables save
                /etc/init.d/iptables restart
            else
                echo -e "${Info} 端口 ${Green}${shadowsocksport}${suffix} 已经启用"
            fi
        else
            echo -e "${Warning} iptables看起来没有运行或没有安装，请在必要时手动启用端口 ${shadowsocksport}"
        fi
    elif centosversion 7; then
        systemctl status firewalld > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            if [[ ${plugin_num} == "2" ]]; then
                firewall-cmd --permanent --zone=public --add-port=${listen_port}/tcp
                firewall-cmd --permanent --zone=public --add-port=${listen_port}/udp
            else
                firewall-cmd --permanent --zone=public --add-port=${shadowsocksport}/tcp
                firewall-cmd --permanent --zone=public --add-port=${shadowsocksport}/udp
            fi
            firewall-cmd --reload
        else
            echo -e "${Warning} firewalld看起来没有运行或没有安装，请在必要时手动启用端口 ${shadowsocksport}"
        fi
    fi
}