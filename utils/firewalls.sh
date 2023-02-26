iptables_start(){
    if ! systemctl is-active iptables 2>/dev/null | head -n 1 | grep -qE '^active$'; then
        systemctl start iptables
        systemctl enable iptables
    fi
}

ip6tables_start(){
    if ! systemctl is-active ip6tables 2>/dev/null | head -n 1 | grep -qE '^active$'; then
        systemctl start ip6tables
        systemctl enable ip6tables
    fi
}

iptables_persistent(){
    if check_sys packageManager yum; then
        if [ ! -e "/etc/systemd/system/multi-user.target.wants/iptables.service" ]; then
            package_install "iptables-services"
        fi
        iptables_start
        iptables-save > /etc/sysconfig/iptables
        ip6tables_start
        ip6tables-save > /etc/sysconfig/ip6tables
    elif check_sys packageManager apt; then
        if [ ! -e "/etc/systemd/system/multi-user.target.wants/netfilter-persistent.service" ]; then
            # ref: https://gist.github.com/alonisser/a2c19f5362c2091ac1e7
            echo 'iptables-persistent iptables-persistent/autosave_v4 boolean true' | debconf-set-selections
            echo 'iptables-persistent iptables-persistent/autosave_v6 boolean true' | debconf-set-selections
            package_install "iptables-persistent"
        fi
        iptables_start
        iptables-save > /etc/iptables/rules.v4
        ip6tables_start
        ip6tables-save > /etc/iptables/rules.v6
    fi
}

add_firewall_rule(){
    local PORT=$1
    local PROTOCOL=$2

    if [ "${FIREWALL_MANAGE_TOOL}" = 'firewall-cmd' ]; then
        if firewall-cmd --list-ports --permanent 2>/dev/null | grep -qw "${PORT}/${PROTOCOL}"; then
            return
        fi
        firewall-cmd --permanent --zone=public --add-port="${PORT}"/"${PROTOCOL}" > /dev/null 2>&1
        firewall-cmd --reload > /dev/null 2>&1
    elif [ "${FIREWALL_MANAGE_TOOL}" = 'ufw' ]; then
        if ufw status 2>/dev/null | grep -qw "${PORT}/${PROTOCOL}"; then
            return
        fi
        ufw allow "${PORT}"/"${PROTOCOL}" > /dev/null 2>&1
        ufw reload > /dev/null 2>&1
    elif [ "${FIREWALL_MANAGE_TOOL}" = 'iptables' ]; then
        if iptables -L INPUT -n --line-numbers 2>/dev/null | grep -qw "${PROTOCOL} dpt:${PORT}"; then
            return
        fi
        iptables -I INPUT -p "${PROTOCOL}" --dport "${PORT}" -j ACCEPT > /dev/null 2>&1
        ip6tables -I INPUT -p "${PROTOCOL}" --dport "${PORT}" -j ACCEPT > /dev/null 2>&1
        iptables_persistent
    fi
}

remove_firewall_rule(){
    local PORT=$1
    local PROTOCOL=$2

    if [ "${FIREWALL_MANAGE_TOOL}" = 'firewall-cmd' ]; then
        if ! firewall-cmd --list-ports --permanent 2>/dev/null | grep -qw "${PORT}/${PROTOCOL}"; then
            return
        fi
        firewall-cmd --permanent --zone=public --remove-port="${PORT}"/"${PROTOCOL}" > /dev/null 2>&1
        firewall-cmd --reload > /dev/null 2>&1
    elif [ "${FIREWALL_MANAGE_TOOL}" = 'ufw' ]; then
        if ! ufw status 2>/dev/null | grep -qw "${PORT}/${PROTOCOL}"; then
            return
        fi
        ufw delete allow "${PORT}"/"${PROTOCOL}" > /dev/null 2>&1
        ufw reload > /dev/null 2>&1
    elif [ "${FIREWALL_MANAGE_TOOL}" = 'iptables' ]; then
        if ! iptables -L INPUT -n --line-numbers 2>/dev/null | grep -qw "${PROTOCOL} dpt:${PORT}"; then
            return
        fi
        iptables -D INPUT -p "${PROTOCOL}" --dport "${PORT}" -j ACCEPT  > /dev/null 2>&1
        ip6tables -D INPUT -p "${PROTOCOL}" --dport "${PORT}" -j ACCEPT  > /dev/null 2>&1
        iptables_persistent
    fi
}

view_firewll_rule(){
    local PORT=$1

    if [ "${FIREWALL_MANAGE_TOOL}" = 'firewall-cmd' ]; then
        _echo -i "Firewall Manager: ${Green}firewall-cmd${suffix}"
        _echo -i "All open ports will be listed below including port: ${PORT}"
        firewall-cmd --list-ports --permanent
        _echo -i "If it does not include port: ${Green}${PORT}${suffix} then opening the port fails, please check the firewall settings yourself"
    elif [ "${FIREWALL_MANAGE_TOOL}" = 'ufw' ]; then
        _echo -i "Firewall Manager: ${Green}ufw${suffix}"
        _echo -i "All open ports will be listed below including port: ${PORT}"
        ufw status
        _echo -i "If it does not include port: ${Green}${PORT}${suffix} then opening the port fails, please check the firewall settings yourself"
    elif [ "${FIREWALL_MANAGE_TOOL}" = 'iptables' ]; then
        _echo -i "Firewall Manager: ${Green}iptables${suffix}"
        _echo -i "All open ports will be listed below including port: ${PORT}"
        iptables -L INPUT -n --line-numbers
        _echo -i "Firewall Manager: ${Green}ip6tables${suffix}"
        _echo -i "All open ports will be listed below including port: ${PORT}"
        ip6tables -L INPUT -n --line-numbers
        _echo -i "If it does not include port: ${Green}${PORT}${suffix} then opening the port fails, please check the firewall settings yourself"
    fi
}

firewall_status(){
    if [ "$(command -v firewall-cmd)" ] && firewall-cmd --state 2>/dev/null | head -n 1 | grep -Eq '^running$'; then
        FIREWALL_MANAGE_TOOL='firewall-cmd'
    elif [ "$(command -v ufw)" ] && ufw status numbered 2>/dev/null | head -n 1 | cut -d\  -f2 | grep -Eq '^active$'; then
        FIREWALL_MANAGE_TOOL='ufw'
    elif [ "$(command -v iptables)" ] && [ "$(command -v ip6tables)" ]; then
        FIREWALL_MANAGE_TOOL='iptables'
    fi
}

add_ssh_port(){
    if [ "${FIREWALL_MANAGE_TOOL}" = 'firewall-cmd' ]; then
        if firewall-cmd --list-ports --permanent 2>/dev/null | grep -qw "22/tcp"; then
            return
        fi
        add_firewall_rule "22" "tcp"
    elif [ "${FIREWALL_MANAGE_TOOL}" = 'ufw' ]; then
        if ufw status 2>/dev/null | grep -qwE "OpenSSH|22/tcp"; then
            return
        fi
        add_firewall_rule "22" "tcp"
    elif [ "${FIREWALL_MANAGE_TOOL}" = 'iptables' ]; then
        if iptables -L INPUT -n --line-numbers 2>/dev/null | grep -qwE "tcp dpt:ssh|tcp dpt:22"; then
            return
        fi
        add_firewall_rule "22" "tcp"
    fi
}

config_firewall_logic(){
    firewall_status
    add_ssh_port
    add_firewall_rule "${firewallNeedOpenPort}" "tcp"
    add_firewall_rule "${firewallNeedOpenPort}" "udp"
    view_firewll_rule "${firewallNeedOpenPort}"
    write_env_variable "PORXY_INBOUND_PORT=${firewallNeedOpenPort}"
    write_env_variable "FIREWALL_MANAGE_TOOL=${FIREWALL_MANAGE_TOOL}"
}