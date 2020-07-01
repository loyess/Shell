config_firewall(){
    local PORT=$1

    if centosversion 6; then
        /etc/init.d/iptables status > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            if ! $(iptables -L -n | grep -q ${PORT}); then
                iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${PORT} -j ACCEPT
                iptables -I INPUT -m state --state NEW -m udp -p udp --dport ${PORT} -j ACCEPT
                /etc/init.d/iptables save
                /etc/init.d/iptables restart
            fi
        else
            echo -e "${Warning} iptables看起来没有运行或没有安装，请在必要时手动启用端口 ${PORT}"
        fi
    elif centosversion 7 || centosversion 8; then
        systemctl status firewalld > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            if ! $(firewall-cmd --list-all | grep -q ${PORT}); then
                firewall-cmd --permanent --zone=public --add-port=${PORT}/tcp
                firewall-cmd --permanent --zone=public --add-port=${PORT}/udp
                firewall-cmd --reload
            fi
        else
            echo -e "${Warning} firewalld看起来没有运行或没有安装，请在必要时手动启用端口 ${PORT}"
        fi
    fi
}

config_firewall_logic(){
    if [[ ${plugin_num} == "2" ]] || [[ ${plugin_num} == "7" ]]; then
        config_firewall "${listen_port}"
    elif [[ ${libev_v2ray} = "4" ]] || [[ ${libev_v2ray} = "5" ]] || [[ ${plugin_num} == "5" ]] || [[ ${isEnableWeb} = enable ]]; then
        config_firewall 443
    else
        config_firewall "${shadowsocksport}"
    fi
}