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
            _echo -w "iptables没有运行或没有安装，请自行排查问题后，手动启用端口: ${PORT}."
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
            _echo -w "firewalld没有运行或没有安装，请自行排查问题后，手动启用端口: ${PORT}."
        fi
    else
        if [ "$(command -v ufw)" ] && [ -n "$(ufw status | head -n 1 | grep 'Status: active')" ]; then
            ufw allow ${PORT}/tcp
            ufw allow ${PORT}/udp
            ufw reload
        else
            _echo -w "ufw没有运行或没有安装，请自行排查问题后，手动启用端口: ${PORT}."
        fi
    fi
}

open_port_for_oracle_cloud(){
    local PORT=$1

    if [ "$(command -v iptables)" ]; then
        if [ -z "$(iptables -L -n | grep ${PORT})" ]; then
            iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${PORT} -j ACCEPT
            iptables -I INPUT -m state --state NEW -m udp -p udp --dport ${PORT} -j ACCEPT
        fi
    else
        _echo -w "iptables命令不存在，请自行排查问题后，手动启用端口: ${PORT}."
    fi
}

config_firewall_logic(){
    if [ -z "$(ps aux | grep -v 'grep' | grep 'oracle-cloud-agent')" ]; then
        config_firewall "${firewallNeedOpenPort}"
    else
        open_port_for_oracle_cloud "${firewallNeedOpenPort}"
    fi
}