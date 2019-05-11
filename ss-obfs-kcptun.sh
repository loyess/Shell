#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH


# shell version
# ====================
SHELL_VERSION="1.0.0"
# ====================


# current path
CUR_DIR=$( pwd )


# bbr
BBR_SCRIPT_URL="https://git.io/vbUk0"
BBR_SHELL_FILE="$CUR_DIR/bbr.sh"


# Humanization config PATH
HUMAN_CONFIG="/etc/shadowsocks-libev/human-config"


# shadowsocklibev-libev config and init
SHADOWSOCKS_LIBEV_INSTALL_PATH="/usr/local/bin"
SHADOWSOCKS_LIBEV_INIT="/etc/init.d/shadowsocks-libev"
SHADOWSOCKS_LIBEV_CONFIG="/etc/shadowsocks-libev/config.json"
SHADOWSOCKS_LIBEV_CENTOS="https://git.io/fjcLb"
SHADOWSOCKS_LIBEV_DEBIAN="https://git.io/fjcLN"


# shadowsocklibev-libev dependencies
LIBSODIUM_FILE="libsodium-1.0.16"
LIBSODIUM_URL="https://github.com/jedisct1/libsodium/releases/download/1.0.16/libsodium-1.0.16.tar.gz"
MBEDTLS_FILE="mbedtls-2.14.1"
MBEDTLS_URL="https://tls.mbed.org/download/mbedtls-2.14.1-gpl.tgz"



# kcptun
KCPTUN_INSTALL_DIR="/usr/local/kcptun/kcptun-server"
KCPTUN_INIT="/etc/init.d/kcptun"
KCPTUN_CONFIG="/etc/kcptun/config.json"
KCPTUN_LOG_DIR="/var/log/kcptun-server.log"
KCPTUN_CENTOS="https://git.io/fjcLx"
KCPTUN_DEBIAN="https://git.io/fjcLp"


# shadowsocklibev-libev Ciphers
SHADOWSOCKS_CIPHERS=(
rc4-md5
salsa20
chacha20
chacha20-ietf
aes-256-cfb
aes-192-cfb
aes-128-cfb
aes-256-ctr
aes-192-ctr
aes-128-ctr
bf-cfb
camellia-128-cfb
camellia-192-cfb
camellia-256-cfb
aes-256-gcm
aes-192-gcm
aes-128-gcm
xchacha20-ietf-poly1305
chacha20-ietf-poly1305
)


# kcptun crypt
KCPTUN_CRYPT=(
aes
aes-128
aes-192
salsa20
blowfish
twofish
cast5
3des
tea
xtea
xor
sm4
none
)


# v2ray-plugin Transport mode
V2RAY_PLUGIN_TRANSPORT_MODE=(
http
tls
quic
)


# kcptun mode(no manual)
KCPTUN_MODE=(
fast3
fast2
fast
normal
)


# Simple-obfs Obfuscation wrapper
OBFUSCATION_WRAPPER=(
http
tls
)


# domain Re
DOMAIN_RE="^(?=^.{3,255}$)[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+$"


# ipv4 and ipv6 Re
IPV4_RE="^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])$"
IPV6_RE="^\s*((([0-9A-Fa-f]{1,4}:){7}(([0-9A-Fa-f]{1,4})|:))|(([0-9A-Fa-f]{1,4}:){6}(:|((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})|(:[0-9A-Fa-f]{1,4})))|(([0-9A-Fa-f]{1,4}:){5}((:((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})?)|((:[0-9A-Fa-f]{1,4}){1,2})))|(([0-9A-Fa-f]{1,4}:){4}(:[0-9A-Fa-f]{1,4}){0,1}((:((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})?)|((:[0-9A-Fa-f]{1,4}){1,2})))|(([0-9A-Fa-f]{1,4}:){3}(:[0-9A-Fa-f]{1,4}){0,2}((:((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})?)|((:[0-9A-Fa-f]{1,4}){1,2})))|(([0-9A-Fa-f]{1,4}:){2}(:[0-9A-Fa-f]{1,4}){0,3}((:((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})?)|((:[0-9A-Fa-f]{1,4}){1,2})))|(([0-9A-Fa-f]{1,4}:)(:[0-9A-Fa-f]{1,4}){0,4}((:((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})?)|((:[0-9A-Fa-f]{1,4}){1,2})))|(:(:[0-9A-Fa-f]{1,4}){0,5}((:((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})?)|((:[0-9A-Fa-f]{1,4}){1,2})))|(((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})))(%.+)?\s*$"


Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Yellow_font_prefix="\033[0;33m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[信息]${Font_color_suffix}"
Error="${Red_font_prefix}[错误]${Font_color_suffix}"
Tip="${Green_font_prefix}[注意]${Font_color_suffix}"
Warning="${Yellow_font_prefix}[警告]${Font_color_suffix}"
Separator_1="——————————————————————————————"


[[ $EUID -ne 0 ]] && echo -e "[${red}Error${Font_color_suffix}] This script must be run as root!" && exit 1

install_check(){
    if check_sys packageManager yum || check_sys packageManager apt; then
        if centosversion 5; then
            return 1
        fi
        return 0
    else
        return 1
    fi
}

disable_selinux(){
    if [ -s /etc/selinux/config ] && grep 'SELINUX=enforcing' /etc/selinux/config; then
        sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
        setenforce 0
    fi
}

is_domain(){
    domain=$1
    
    if [ -n "$(echo $domain | grep -P $DOMAIN_RE)" ]; then
        return 0
    else
        return 1
    fi
}

is_ipv4_or_ipv6(){
    ip=$1
    
    if [ -n "$(echo $ip | grep -E $IPV4_RE)" ] || [ -n "$(echo $ip | grep -E $IPV6_RE)" ]; then
        return 0
    else
        return 1
    fi
}

version_ge(){
    test "$(echo "$@" | tr " " "\n" | sort -rV | head -n 1)" == "$1"
}

version_gt(){
    test "$(echo "$@" | tr " " "\n" | sort -V | head -n 1)" != "$1"
}

check_pid(){
	PID=`ps -ef |grep -v grep | grep ss-server |awk '{print $2}'`
}

check_sys(){
    local checkType=$1
    local value=$2

    local release=''
    local systemPackage=''

    if [[ -f /etc/redhat-release ]]; then
        release="centos"
        systemPackage="yum"
    elif grep -Eqi "debian|raspbian" /etc/issue; then
        release="debian"
        systemPackage="apt"
    elif grep -Eqi "ubuntu" /etc/issue; then
        release="ubuntu"
        systemPackage="apt"
    elif grep -Eqi "centos|red hat|redhat" /etc/issue; then
        release="centos"
        systemPackage="yum"
    elif grep -Eqi "debian|raspbian" /proc/version; then
        release="debian"
        systemPackage="apt"
    elif grep -Eqi "ubuntu" /proc/version; then
        release="ubuntu"
        systemPackage="apt"
    elif grep -Eqi "centos|red hat|redhat" /proc/version; then
        release="centos"
        systemPackage="yum"
    fi

    if [[ "${checkType}" == "sysRelease" ]]; then
        if [ "${value}" == "${release}" ]; then
            return 0
        else
            return 1
        fi
    elif [[ "${checkType}" == "packageManager" ]]; then
        if [ "${value}" == "${systemPackage}" ]; then
            return 0
        else
            return 1
        fi
    fi
}

check_kernel_version(){
    local kernel_version=$(uname -r | cut -d- -f1)
    if version_gt ${kernel_version} 3.7.0; then
        return 0
    else
        return 1
    fi
}

check_kernel_headers(){
    if check_sys packageManager yum; then
        if rpm -qa | grep -q headers-$(uname -r); then
            return 0
        else
            return 1
        fi
    elif check_sys packageManager apt; then
        if dpkg -s linux-headers-$(uname -r) > /dev/null 2>&1; then
            return 0
        else
            return 1
        fi
    fi
    return 1
}

config_firewall(){
    if centosversion 6; then
        /etc/init.d/iptables status > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            iptables -L -n | grep -i ${shadowsocksport} > /dev/null 2>&1
            if [ $? -ne 0 ]; then
                iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${shadowsocksport} -j ACCEPT
                iptables -I INPUT -m state --state NEW -m udp -p udp --dport ${shadowsocksport} -j ACCEPT
                
                iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${listen_port} -j ACCEPT
                iptables -I INPUT -m state --state NEW -m udp -p udp --dport ${listen_port} -j ACCEPT                
                /etc/init.d/iptables save
                /etc/init.d/iptables restart
            else
                echo -e "${Info} 端口 ${Green_font_prefix}${shadowsocksport}${Font_color_suffix} 已经启用"
            fi
        else
            echo -e "${Warning} iptables看起来没有运行或没有安装，请在必要时手动启用端口 ${shadowsocksport}"
        fi
    elif centosversion 7; then
        systemctl status firewalld > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            firewall-cmd --permanent --zone=public --add-port=${shadowsocksport}/tcp
            firewall-cmd --permanent --zone=public --add-port=${shadowsocksport}/udp
            
            firewall-cmd --permanent --zone=public --add-port=${listen_port}/tcp
            firewall-cmd --permanent --zone=public --add-port=${listen_port}/udp            
            firewall-cmd --reload
        else
            echo -e "${Warning} firewalld看起来没有运行或没有安装，请在必要时手动启用端口 ${shadowsocksport}"
        fi
    fi
}

get_ip(){
    local IP=$( ip addr | egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | egrep -v "^192\.168|^172\.1[6-9]\.|^172\.2[0-9]\.|^172\.3[0-2]\.|^10\.|^127\.|^255\.|^0\." | head -n 1 )
    [ -z ${IP} ] && IP=$( wget -qO- -t1 -T2 ipv4.icanhazip.com )
    [ -z ${IP} ] && IP=$( wget -qO- -t1 -T2 ipinfo.io/ip )
    echo ${IP}
}

get_ipv6(){
    local ipv6=$(wget -qO- -t1 -T2 ipv6.icanhazip.com)
    [ -z ${ipv6} ] && return 1 || return 0
}


get_ver(){
    libev_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/shadowsocks/shadowsocks-libev/releases | grep -o '"tag_name": ".*"' | head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
    [ -z ${libev_ver} ] && echo -e "${Error} 获取 shadowsocks-libev 最新版本失败." && exit 1
    simple_obfs_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/shadowsocks/simple-obfs/releases | grep -o '"tag_name": ".*"' | head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
    [ -z ${simple_obfs_ver} ] && echo -e "${Error} 获取 simple-obfs 最新版本失败." && exit 1
    kcptun_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/xtaci/kcptun/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
    [ -z ${kcptun_ver} ] && echo -e "${Error} 获取 kcptun 最新版本失败." && exit 1
    v2ray_plugin_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/shadowsocks/v2ray-plugin/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
    [ -z ${v2ray_plugin_ver} ] && echo -e "${Error} 获取 v2ray-plugin 最新版本失败." && exit 1
}

get_char(){
    SAVEDSTTY=$(stty -g)
    stty -echo
    stty cbreak
    dd if=/dev/tty bs=1 count=1 2> /dev/null
    stty -raw
    stty echo
    stty $SAVEDSTTY
}

gen_random_prot(){
    ran_prot=$(shuf -i 9000-19999 -n 1)
}

gen_random_str(){
    ran_str=$(head -c 100 /dev/urandom | tr -dc a-z0-9A-Z |head -c 8)
}

install_prepare_port() {
    while true
    do
    gen_random_prot
    echo -e "\n请输入Shadowsocks-libev端口 [1-65535]"
    read -p "(默认: ${ran_prot}):" shadowsocksport
    [ -z "${shadowsocksport}" ] && shadowsocksport=${ran_prot}
    expr ${shadowsocksport} + 1 &>/dev/null
    if [ $? -eq 0 ]; then
        if [ ${shadowsocksport} -ge 1 ] && [ ${shadowsocksport} -le 65535 ] && [ ${shadowsocksport:0:1} != 0 ]; then
            echo
            echo -e "${Red_font_prefix}  port = ${shadowsocksport}${Font_color_suffix}"
            echo
            echo -e "${Tip} 如果选择v2ray-plugin 此参数将会被重置"
            echo 
            break
        fi
    fi
    echo
    echo -e "${Error} 请输入一个正确的数 [1-65535]"
    echo
    done
}

install_prepare_password(){
    gen_random_str
    echo -e "\n请输入Shadowsocks-libev密码"
    read -p "(默认: ${ran_str}):" shadowsockspwd
    [ -z "${shadowsockspwd}" ] && shadowsockspwd=${ran_str}
    echo
    echo -e "${Red_font_prefix}  password = ${shadowsockspwd}${Font_color_suffix}"
    echo
}

install_prepare_cipher(){
    while true
    do
    echo -e "\n请选择Shadowsocks-libev加密方式"

    for ((i=1;i<=${#SHADOWSOCKS_CIPHERS[@]};i++ )); do
        hint="${SHADOWSOCKS_CIPHERS[$i-1]}"
        if [[ ${i} -le 9 ]]; then
            echo -e "${Green_font_prefix}  ${i}.${Font_color_suffix} ${hint}"
        else
            echo -e "${Green_font_prefix} ${i}.${Font_color_suffix} ${hint}"
        fi
    done
    echo
    read -p "(默认: ${SHADOWSOCKS_CIPHERS[14]}):" pick
    [ -z "$pick" ] && pick=15
    expr ${pick} + 1 &>/dev/null
    if [ $? -ne 0 ]; then
        echo
        echo -e "${Error} 请输入一个数字."
        echo
        continue
    fi
    if [[ "$pick" -lt 1 || "$pick" -gt ${#SHADOWSOCKS_CIPHERS[@]} ]]; then
        echo
        echo -e "${Error} 请输入一个数字在 [1-${#SHADOWSOCKS_CIPHERS[@]}] 之间."
        echo
        continue
    fi
    shadowsockscipher=${SHADOWSOCKS_CIPHERS[$pick-1]}

    echo
    echo -e "${Red_font_prefix}  cipher = ${shadowsockscipher}${Font_color_suffix}"
    echo
    break
    done
}

autoconf_version(){
    if [ ! "$(command -v autoconf)" ]; then
        echo -e "${Info} 开始安装autoconf 软件包."
        if check_sys packageManager yum; then
            yum install -y autoconf > /dev/null 2>&1 || echo -e "${Error} 安装autoconf失败."
        elif check_sys packageManager apt; then
            apt-get -y update > /dev/null 2>&1
            apt-get -y install autoconf > /dev/null 2>&1 || echo -e "${Error} 安装autoconf失败."
        fi
        echo -e "${Info} autoconf 安装完成."
    fi
    local autoconf_ver=$(autoconf --version | grep autoconf | grep -oE "[0-9.]+")
    if version_ge ${autoconf_ver} 2.67; then
        return 0
    else
        return 1
    fi
}

getversion(){
    if [[ -s /etc/redhat-release ]]; then
        grep -oE  "[0-9.]+" /etc/redhat-release
    else
        grep -oE  "[0-9.]+" /etc/issue
    fi
}

centosversion(){
    if check_sys sysRelease centos; then
        local code=$1
        local version="$(getversion)"
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

install_prepare_libev_v2ray(){
    while true
        do
        echo -e "请为v2ray-plugin选择Transport mode\n"
        for ((i=1;i<=${#V2RAY_PLUGIN_TRANSPORT_MODE[@]};i++ )); do
            hint="${V2RAY_PLUGIN_TRANSPORT_MODE[$i-1]}"
            echo -e "${Green_font_prefix}  ${i}.${Font_color_suffix} ${hint}"
        done
        echo
        read -p "(默认: ${V2RAY_PLUGIN_TRANSPORT_MODE[0]}):" libev_v2ray
        [ -z "$libev_v2ray" ] && libev_v2ray=1
        expr ${libev_v2ray} + 1 &>/dev/null
        if [ $? -ne 0 ]; then
            echo
            echo -e "${Error} 请输入一个数字"
            echo
            continue
        fi
        if [[ "$libev_v2ray" -lt 1 || "$libev_v2ray" -gt ${#V2RAY_PLUGIN_TRANSPORT_MODE[@]} ]]; then
            echo
            echo -e "${Error} 请输入一个数字在 [1-${#V2RAY_PLUGIN_TRANSPORT_MODE[@]}] 之间"
            echo
            continue
        fi
        shadowsocklibev_v2ray=${V2RAY_PLUGIN_TRANSPORT_MODE[$libev_v2ray-1]}
        echo
        echo -e "${Red_font_prefix}  over = ${shadowsocklibev_v2ray}${Font_color_suffix}"
        echo  

        while true
            do
            if [[ ${libev_v2ray} == "1" ]]; then
                shadowsocksport=80
                echo
                echo -e "${Tip} server_port已被重置为：port = ${shadowsocksport}"
                echo 

            elif [[ ${libev_v2ray} = "2" || ${libev_v2ray} = "3" ]]; then
                shadowsocksport=443
                echo
                echo -e "${Tip} server_port已被重置为：port = ${shadowsocksport}"
                echo 
                echo
                read -p "请输入你的域名：" domain
                echo
                if is_domain ${domain}; then
                    echo
                    echo -e "${Red_font_prefix}  host = ${domain}${Font_color_suffix}"
                    echo
                else
                    echo
                    echo -e "${Error} 请输入正确合法的domain地址."
                    echo
                    continue
                fi
                read -p "请输入你的 TLS certificate 文件路径：" cerpath
                if [[ -n "${cerpath}" && -f "${cerpath}" ]]; then
                    echo
                    echo -e "${Red_font_prefix}  cert = ${cerpath}${Font_color_suffix}"
                    echo
                else
                    echo
                    echo -e "${Error} 请输入正确合法的 TLS certificate 文件路径"
                    echo
                    continue
                fi
                
                echo
                read -p "请输入你的 TLS key 文件路径：" keypath
                echo
                if [[ -n "${cerpath}" && -f "${cerpath}" ]]; then
                    echo
                    echo -e "${Red_font_prefix}  cert = ${keypath}${Font_color_suffix}"
                    echo
                else
                    echo
                    echo -e "${Error} 请输入正确合法的 TLS key 文件路径"
                    echo
                    continue
                fi
            fi
            break
            done 
                
        break
        done
}

install_prepare_libev_obfs(){
    if autoconf_version || centosversion 6; then
        while true
        do
        echo -e "请为simple-obfs选择obfs\n"
        for ((i=1;i<=${#OBFUSCATION_WRAPPER[@]};i++ )); do
            hint="${OBFUSCATION_WRAPPER[$i-1]}"
            echo -e "${Green_font_prefix}  ${i}.${Font_color_suffix} ${hint}"
        done
        echo
        read -p "(默认: ${OBFUSCATION_WRAPPER[0]}):" libev_obfs
        [ -z "$libev_obfs" ] && libev_obfs=1
        expr ${libev_obfs} + 1 &>/dev/null
        if [ $? -ne 0 ]; then
            echo
            echo -e "${Error} 请输入一个数字"
            echo
            continue
        fi
        if [[ "$libev_obfs" -lt 1 || "$libev_obfs" -gt ${#OBFUSCATION_WRAPPER[@]} ]]; then
            echo
            echo -e "${Error} 请输入一个数字在 [1-${#OBFUSCATION_WRAPPER[@]}] 之间"
            echo
            continue
        fi
        shadowsocklibev_obfs=${OBFUSCATION_WRAPPER[$libev_obfs-1]}
        echo
        echo -e "${Red_font_prefix}  obfs = ${shadowsocklibev_obfs}${Font_color_suffix}"
        echo
        break
        done
    else
        echo
        echo -e "${Info} autoconf 版本小于 2.67，Shadowsocks-libev 插件 simple-obfs 的安装将被跳过."
        echo
        
    fi
}

install_prepare_libev_kcptun(){ 
    # 设置 Kcptun 服务器监听端口 listen_port
    while true
    do
    echo -e "请输入 Kcptun 服务端运行端口 [1-65535]\n${Tip} 这个端口，就是 Kcptun 客户端要连接的端口."
    read -p "(默认: 29900):" listen_port
    [ -z "${listen_port}" ] && listen_port=29900
    expr ${listen_port} + 1 &>/dev/null
    if [ $? -eq 0 ]; then
        if [ ${listen_port} -ge 1 ] && [ ${listen_port} -le 65535 ] && [ ${listen_port:0:1} != 0 ]; then
            echo
            echo -e "${Red_font_prefix}  port = ${listen_port}${Font_color_suffix}"
            echo
            break
        fi
    fi
    echo
    echo -e "${Error} 请输入一个正确的数 [1-65535]"
    echo
    continue
    done
    
    # 设置需要 Kcptun 加速的目标服务器地址 target_addr
    while true
    do
    echo -e "请输入需要加速的地址\n${Tip} 可以输入IPv4 地址或者 IPv6 地址."
    read -p "(默认: 127.0.0.1):" target_addr
    [ -z "${target_addr}" ] && target_addr=127.0.0.1
    if is_ipv4_or_ipv6 ${target_addr}; then
        echo
        echo -e "${Red_font_prefix}  ip(target) = ${target_addr}${Font_color_suffix}"
        echo
        break
    else
        echo
        echo -e "${Error} 请输入正确合法的IP地址."
        echo
        continue
    fi
    done
    
    # 设置需要 Kcptun 加速的目标服务器端口 target_port
    while true
    do
    echo -e "请输入需要加速的端口 [1-65535]\n${Tip} 这里用来加速SS，那就输入前面填写过的SS的端口: ${Red_font_prefix}${shadowsocksport}${Font_color_suffix}"
    read -p "(默认: ${shadowsocksport}):" target_port
    [ -z "${target_port}" ] && target_port=${shadowsocksport}
    expr ${target_port} + 1 &>/dev/null
    if [ $? -eq 0 ]; then
        if [ ${target_port} -ge 1 ] && [ ${target_port} -le 65535 ] && [ ${target_port:0:1} != 0 ]; then
            echo
            echo -e "${Red_font_prefix}  port(target) = ${target_port}${Font_color_suffix}"
            echo
            break
        fi
    fi
    echo
    echo -e "${Error} 请输入一个正确的数 [1-65535]"
    echo
    continue
    done
    
    # 设置 Kcptun 密码 key
    gen_random_str
    echo -e "请设置 Kcptun 密码(key)\n${Tip} 该参数必须两端一致，另外这里的密码是kcptun的密码，与Shadowsocks半毛钱关系都没有，别弄混淆了."
    read -p "(默认: ${ran_str}):" key
    [ -z "${key}" ] && key=${ran_str}
    echo
    echo -e "${Red_font_prefix}  key = ${key}${Font_color_suffix}"
    echo
    
    # 设置 Kcptun 加密方式 crypt
    while true
    do
    echo -e "请选择加密方式(crypt)\n${Tip} 强加密对 CPU 要求较高，如果是在路由器上配置客户端，请尽量选择弱加密或者不加密。该参数必须两端一致"

    for ((i=1;i<=${#KCPTUN_CRYPT[@]};i++ )); do
        hint="${KCPTUN_CRYPT[$i-1]}"
        if [[ ${i} -le 9 ]]; then
            echo -e "${Green_font_prefix}  ${i}.${Font_color_suffix} ${hint}"
        else
            echo -e "${Green_font_prefix} ${i}.${Font_color_suffix} ${hint}"
        fi
    done
    echo
    read -p "(默认: ${KCPTUN_CRYPT[0]}):" crypt
    [ -z "$crypt" ] && crypt=1
    expr ${crypt} + 1 &>/dev/null
    if [ $? -ne 0 ]; then
        echo
        echo -e "${Error} 请输入一个数字."
        echo
        continue
    fi
    if [[ "$crypt" -lt 1 || "$crypt" -gt ${#KCPTUN_CRYPT[@]} ]]; then
        echo
        echo -e "${Error} 请输入一个数字在 [1-${#KCPTUN_CRYPT[@]}] 之间."
        echo
        continue
    fi
    crypt=${KCPTUN_CRYPT[$crypt-1]}

    echo
    echo -e "${Red_font_prefix}  crypt = ${crypt}${Font_color_suffix}"
    echo
    break
    done
    
    # 设置 Kcptun 加速模式 mode
    while true
    do
    echo -e "请选择加速模式(mode)\n${Tip} 加速模式和发送窗口大小共同决定了流量的损耗大小. ${Red_font_prefix}未支持(手动模式 manual)${Font_color_suffix}”"

    for ((i=1;i<=${#KCPTUN_MODE[@]};i++ )); do
        hint="${KCPTUN_MODE[$i-1]}"
        if [[ ${i} -le 9 ]]; then
            echo -e "${Green_font_prefix}  ${i}.${Font_color_suffix} ${hint}"
        else
            echo -e "${Green_font_prefix} ${i}.${Font_color_suffix} ${hint}"
        fi
    done
    echo
    read -p "(默认: ${KCPTUN_MODE[1]}):" mode
    [ -z "$mode" ] && mode=2
    expr ${mode} + 1 &>/dev/null
    if [ $? -ne 0 ]; then
        echo
        echo -e "${Error} 请输入一个数字."
        echo
        continue
    fi
    if [[ "$mode" -lt 1 || "$mode" -gt ${#KCPTUN_MODE[@]} ]]; then
        echo
        echo -e "${Error} 请输入一个数字在 [1-${#KCPTUN_MODE[@]}] 之间."
        echo
        continue
    fi
    mode=${KCPTUN_MODE[$mode-1]}

    echo
    echo -e "${Red_font_prefix}  mode = ${mode}${Font_color_suffix}"
    echo
    break
    done
    
    # 设置 UDP 数据包的 MTU (最大传输单元)值
    while true
    do
    echo -e "请设置 UDP 数据包的 MTU (最大传输单元)值"
    read -p "(默认: 1350):" MTU
    [ -z "${MTU}" ] && MTU=1350
    expr ${MTU} + 1 &>/dev/null
    if [ $? -eq 0 ]; then
        if [ ${MTU} -ge 1 ] && [ ${MTU:0:1} != 0 ]; then
            echo
            echo -e "${Red_font_prefix}  MTU = ${MTU}${Font_color_suffix}"
            echo
            break
        fi
    fi
    echo
    echo -e "${Error} 请输入一个大于0的数."
    echo
    continue
    done
    
    # 设置发送窗口大小 sndwnd
    while true
    do
    echo -e "请设置发送窗口大小(sndwnd)\n${Tip} 发送窗口过大会浪费过多流量"
    read -p "(默认: 1024):" sndwnd
    [ -z "${sndwnd}" ] && sndwnd=1024
    expr ${sndwnd} + 1 &>/dev/null
    if [ $? -eq 0 ]; then
        if [ ${sndwnd} -ge 1 ] && [ ${sndwnd:0:1} != 0 ]; then
            echo
            echo -e "${Red_font_prefix}  sndwnd = ${sndwnd}${Font_color_suffix}"
            echo
            break
        fi
    fi
    echo
    echo -e "${Error} 请输入一个大于0的数."
    echo
    continue
    done
    
    # 设置接收窗口大小 rcvwnd
    while true
    do
    echo -e "请设置接收窗口大小(rcvwnd)"
    read -p "(默认: 1024):" rcvwnd
    [ -z "${rcvwnd}" ] && rcvwnd=1024
    expr ${rcvwnd} + 1 &>/dev/null
    if [ $? -eq 0 ]; then
        if [ ${rcvwnd} -ge 1 ] && [ ${rcvwnd:0:1} != 0 ]; then
            echo
            echo -e "${Red_font_prefix}  rcvwnd = ${rcvwnd}${Font_color_suffix}"
            echo
            break
        fi
    fi
    echo
    echo -e "${Error} 请输入一个大于0的数."
    echo
    continue
    done

    # 设置前向纠错 datashard
    while true
    do
    echo -e "请设置前向纠错(datashard) \n${Tip} 该参数必须两端一致"
    read -p "(默认: 10):" datashard
    [ -z "${datashard}" ] && datashard=10
    expr ${datashard} + 1 &>/dev/null
    if [ $? -eq 0 ]; then
        if [ ${datashard} -ge 1 ] && [ ${datashard:0:1} != 0 ]; then
            echo
            echo -e "${Red_font_prefix}  datashard = ${datashard}${Font_color_suffix}"
            echo
            break
        fi
    fi
    echo
    echo -e "${Error} 请输入一个大于0的数."
    echo
    continue
    done
    
    # 设置前向纠错 parityshard
    while true
    do
    echo -e "请设置前向纠错(parityshard) \n${Tip} 该参数必须两端一致"
    read -p "(默认: 3):" parityshard
    [ -z "${parityshard}" ] && parityshard=3
    expr ${parityshard} + 1 &>/dev/null
    if [ $? -eq 0 ]; then
        if [ ${parityshard} -ge 1 ] && [ ${parityshard:0:1} != 0 ]; then
            echo
            echo -e "${Red_font_prefix}  parityshard = ${parityshard}${Font_color_suffix}"
            echo
            break
        fi
    fi
    echo
    echo -e "${Error} 请输入一个大于0的数."
    echo
    continue
    done
    
    # 设置差分服务代码点 DSCP
    while true
    do
    echo -e "设置差分服务代码点(DSCP)"
    read -p "(默认: 46):" DSCP
    [ -z "${DSCP}" ] && DSCP=46
    expr ${DSCP} + 1 &>/dev/null
    if [ $? -eq 0 ]; then
        if [ ${DSCP} -ge 1 ] && [ ${DSCP:0:1} != 0 ]; then
            echo
            echo -e "${Red_font_prefix}  DSCP = ${DSCP}${Font_color_suffix}"
            echo
            break
        fi
    fi
    echo
    echo -e "${Error} 请输入一个大于0的数."
    echo
    continue
    done 
}

install_prepare(){
    install_prepare_port
    install_prepare_password
    install_prepare_cipher
    echo -e "请选择要安装的SS-Plugin
    
  ${Green_font_prefix}1.${Font_color_suffix} v2ray
  ${Green_font_prefix}2.${Font_color_suffix} kcptun
  ${Green_font_prefix}3.${Font_color_suffix} simple-obfs
  "
    echo && read -e -p "(默认: 不安装)：" plugin_num
    [[ -z "${plugin_num}" ]] && plugin_num="" && echo -e "\n${Tip} 当前未选择任何插件，仅安装Shadowsocks-libev."
    if [[ ${plugin_num} == "1" ]]; then
        install_prepare_libev_v2ray
    elif [[ ${plugin_num} == "2" ]]; then
        install_prepare_libev_kcptun
	elif [[ ${plugin_num} == "3" ]]; then
		install_prepare_libev_obfs
    elif [[ ${plugin_num} == "" ]]; then
        :
    else
        echo -e "${Error} 请输入正确的数字 [1-3]" && exit 1
	fi
    
    echo
    echo "按任意键开始…或按Ctrl+C取消"
    char=`get_char`

}

error_detect_depends(){
    local command=$1
    local depend=`echo "${command}" | awk '{print $4}'`
    echo -e "${Info} 开始安装依赖包 ${depend}"
    ${command} > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo -e "${Error} 依赖包${red}${depend}${Font_color_suffix}安装失败，请检查. "
        echo "Checking the error message and run the script again."
        exit 1
    fi
}

install_dependencies(){
    if check_sys packageManager yum; then
        echo -e "${Info} 检查EPEL存储库."
        if [ ! -f /etc/yum.repos.d/epel.repo ]; then
            yum install -y epel-release > /dev/null 2>&1
        fi
        [ ! -f /etc/yum.repos.d/epel.repo ] && echo -e "${Error} 安装EPEL存储库失败，请检查它。" && exit 1
        [ ! "$(command -v yum-config-manager)" ] && yum install -y yum-utils > /dev/null 2>&1
        [ x"$(yum-config-manager epel | grep -w enabled | awk '{print $3}')" != x"True" ] && yum-config-manager --enable epel > /dev/null 2>&1
        echo -e "${Info} EPEL存储库检查完成."

        yum_depends=(
            gettext gcc autoconf libtool automake make asciidoc xmlto c-ares-devel libev-devel zlib-devel openssl-devel git wget qrencode
        )
        for depend in ${yum_depends[@]}; do
            error_detect_depends "yum -y install ${depend}"
        done
    elif check_sys packageManager apt; then
        apt_depends=(
            gettext build-essential autoconf libtool libpcre3-dev asciidoc xmlto libev-dev libc-ares-dev automake libssl-dev git wget qrencode
        )

        apt-get -y update
        for depend in ${apt_depends[@]}; do
            error_detect_depends "apt-get -y install ${depend}"
        done
    fi
}

download(){
    local filename=$(basename $1)
    if [ -e ${1} ]; then
        echo "${filename} [已存在.]"
    else
        echo "${filename} 当前目录中不存在, 现在开始下载."
        wget --no-check-certificate -c -t3 -T60 -O ${1} ${2}
        if [ $? -ne 0 ]; then
            echo -e "${Error} 下载 ${filename} 失败."
            exit 1
        fi
    fi
}

download_files(){
    cd ${CUR_DIR}
    
    if [[ "${plugin_num}" == "1" ]]; then
        get_ver
        
        # 下载Shadowsocks-libev
        shadowsocks_libev_file="shadowsocks-libev-${libev_ver}"
        shadowsocks_libev_url="https://github.com/shadowsocks/shadowsocks-libev/releases/download/v${libev_ver}/shadowsocks-libev-${libev_ver}.tar.gz"
        download "${shadowsocks_libev_file}.tar.gz" "${shadowsocks_libev_url}"
        
        if check_sys packageManager yum; then
            download "${SHADOWSOCKS_LIBEV_INIT}" "${SHADOWSOCKS_LIBEV_CENTOS}"
        elif check_sys packageManager apt; then
            download "${SHADOWSOCKS_LIBEV_INIT}" "${SHADOWSOCKS_LIBEV_DEBIAN}"
        fi
        
        # 下载v2ray-plugin
        v2ray_plugin_file="v2ray-plugin-linux-amd64-v${v2ray_plugin_ver}"
        v2ray_plugin_url="https://github.com/shadowsocks/v2ray-plugin/releases/download/v${v2ray_plugin_ver}/v2ray-plugin-linux-amd64-v${v2ray_plugin_ver}.tar.gz"
        download "${v2ray_plugin_file}.tar.gz" "${v2ray_plugin_url}"
        
        
    elif [[ "${plugin_num}" == "2" ]]; then
        get_ver
        
        # 下载Shadowsocks-libev
        shadowsocks_libev_file="shadowsocks-libev-${libev_ver}"
        shadowsocks_libev_url="https://github.com/shadowsocks/shadowsocks-libev/releases/download/v${libev_ver}/shadowsocks-libev-${libev_ver}.tar.gz"
        download "${shadowsocks_libev_file}.tar.gz" "${shadowsocks_libev_url}"
        
        if check_sys packageManager yum; then
            download "${SHADOWSOCKS_LIBEV_INIT}" "${SHADOWSOCKS_LIBEV_CENTOS}"
        elif check_sys packageManager apt; then
            download "${SHADOWSOCKS_LIBEV_INIT}" "${SHADOWSOCKS_LIBEV_DEBIAN}"
        fi
        
        # 下载kcptun
        kcptun_file="kcptun-linux-amd64-${kcptun_ver}"
        kcptun_url="https://github.com/xtaci/kcptun/releases/download/v${kcptun_ver}/kcptun-linux-amd64-${kcptun_ver}.tar.gz"
        download "${kcptun_file}.tar.gz" "${kcptun_url}"
        
        if check_sys packageManager yum; then
            download "${KCPTUN_INIT}" "${KCPTUN_CENTOS}"
        elif check_sys packageManager apt; then
            download "${KCPTUN_INIT}" "${KCPTUN_DEBIAN}"
        fi
        
    elif [[ "${plugin_num}" == "3" || "${plugin_num}" == "" ]]; then
        get_ver
        shadowsocks_libev_file="shadowsocks-libev-${libev_ver}"
        shadowsocks_libev_url="https://github.com/shadowsocks/shadowsocks-libev/releases/download/v${libev_ver}/shadowsocks-libev-${libev_ver}.tar.gz"

        download "${shadowsocks_libev_file}.tar.gz" "${shadowsocks_libev_url}"
        if check_sys packageManager yum; then
            download "${SHADOWSOCKS_LIBEV_INIT}" "${SHADOWSOCKS_LIBEV_CENTOS}"
        elif check_sys packageManager apt; then
            download "${SHADOWSOCKS_LIBEV_INIT}" "${SHADOWSOCKS_LIBEV_DEBIAN}"
        fi
    fi
}

config_shadowsocks(){

if check_kernel_version && check_kernel_headers; then
    fast_open="true"
else
    fast_open="false"
fi

local server_value="\"0.0.0.0\""
if get_ipv6; then
    server_value="[\"[::0]\",\"0.0.0.0\"]"
fi

if [ ! -d "$(dirname ${SHADOWSOCKS_LIBEV_CONFIG})" ]; then
    mkdir -p $(dirname ${SHADOWSOCKS_LIBEV_CONFIG})
fi

if [[ ${plugin_num} == "1" ]]; then
    if [[ ${libev_v2ray} == "1" ]]; then
        cat > ${SHADOWSOCKS_LIBEV_CONFIG}<<-EOF
{ 
    "server":${server_value},
    "server_port":${shadowsocksport},
    "password":${shadowsockspwd},
    "timeout":300,
    "method":${shadowsockscipher},
    "fast_open":${fast_open},
    "user":"nobody",
    "nameserver":"8.8.8.8",
    "mode":"tcp_and_udp",
    "plugin":"v2ray-plugin",
    "plugin_opts":"server"
}
EOF
    elif [[ ${libev_v2ray} == "2" ]]; then    
        cat > ${SHADOWSOCKS_LIBEV_CONFIG}<<-EOF
{ 
    "server":${server_value},
    "server_port":${shadowsocksport},
    "password":${shadowsockspwd},
    "timeout":300,
    "method":${shadowsockscipher},
    "fast_open":${fast_open},
    "user":"nobody",
    "nameserver":"8.8.8.8",
    "mode":"tcp_and_udp",
    "plugin":"v2ray-plugin",
    "plugin_opts":"server;tls;host=${domain};cert=${cerpath};key=${keypath}"
}
EOF
    elif [[ ${libev_v2ray} == "3" ]]; then
        cat > ${SHADOWSOCKS_LIBEV_CONFIG}<<-EOF
{ 
    "server":${server_value},
    "server_port":${shadowsocksport},
    "password":${shadowsockspwd},
    "timeout":300,
    "method":${shadowsockscipher},
    "fast_open":${fast_open},
    "user":"nobody",
    "nameserver":"8.8.8.8",
    "mode":"tcp_and_udp",
    "plugin":"v2ray-plugin",
    "plugin_opts":"server;mode=quic;host=${domain};cert=${cerpath};key=${keypath}"
}
EOF
    fi
    
elif [[ ${plugin_num} == "2" ]]; then
    if [ ! -d "$(dirname ${KCPTUN_CONFIG})" ]; then
        mkdir -p $(dirname ${KCPTUN_CONFIG})
    fi
    cat > ${SHADOWSOCKS_LIBEV_CONFIG}<<-EOF
{
    "server":${server_value},
    "server_port":${shadowsocksport},
    "password":"${shadowsockspwd}",
    "timeout":300,
    "user":"nobody",
    "method":"${shadowsockscipher}",
    "fast_open":${fast_open},
    "nameserver":"8.8.8.8",
    "mode":"tcp_and_udp"
}
EOF

    cat > ${KCPTUN_CONFIG}<<-EOF
{
    "listen": ":${listen_port}",
    "target": "${target_addr}:${target_port}",
    "key": "${key}",
    "crypt": "${crypt}",
    "mode": "${mode}",
    "mtu": ${MTU},
    "sndwnd": ${sndwnd},
    "rcvwnd": ${rcvwnd},
    "datashard": ${datashard},
    "parityshard": ${parityshard},
    "dscp": ${DSCP}
}
EOF
 
elif [[ ${plugin_num} == "3" ]]; then
    cat > ${SHADOWSOCKS_LIBEV_CONFIG}<<-EOF
{
    "server":${server_value},
    "server_port":${shadowsocksport},
    "password":"${shadowsockspwd}",
    "timeout":300,
    "user":"nobody",
    "method":"${shadowsockscipher}",
    "fast_open":${fast_open},
    "nameserver":"8.8.8.8",
    "mode":"tcp_and_udp",
    "plugin":"obfs-server",
    "plugin_opts":"obfs=${shadowsocklibev_obfs}"
}
EOF
else
    cat > ${SHADOWSOCKS_LIBEV_CONFIG}<<-EOF
{
    "server":${server_value},
    "server_port":${shadowsocksport},
    "password":"${shadowsockspwd}",
    "timeout":300,
    "user":"nobody",
    "method":"${shadowsockscipher}",
    "fast_open":${fast_open},
    "nameserver":"8.8.8.8",
    "mode":"tcp_and_udp"
}
EOF
fi
}

install_libsodium(){    
    if [ ! -f /usr/lib/libsodium.a ]; then
        cd ${cur_dir}
        echo -e "${Info} 下载${LIBSODIUM_FILE}..."
        download "${LIBSODIUM_FILE}.tar.gz" "${LIBSODIUM_URL}"
        echo -e "${Info} 解压${LIBSODIUM_FILE}..."
        tar zxf ${LIBSODIUM_FILE}.tar.gz && cd ${LIBSODIUM_FILE}
        echo -e "${Info} 编译安装${LIBSODIUM_FILE}..."
        ./configure --prefix=/usr && make && make install
        if [ $? -ne 0 ]; then
            echo -e "${Error} ${LIBSODIUM_FILE} 安装失败 !"
            install_cleanup
            exit 1
        fi
        echo -e "${Info} ${LIBSODIUM_FILE} 安装成功 !"    
    else
        echo -e "${Info} ${LIBSODIUM_FILE} 已经安装."
    fi
}

install_mbedtls(){
    if [ ! -f /usr/lib/libmbedtls.a ]; then
        cd ${cur_dir}
        echo -e "${Info} 下载${MBEDTLS_FILE}..."
        download "${MBEDTLS_FILE}-gpl.tgz" "${MBEDTLS_URL}"
        echo -e "${Info} 解压${MBEDTLS_FILE}..."
        tar xf ${MBEDTLS_FILE}-gpl.tgz && cd ${MBEDTLS_FILE}
        echo -e "${Info} 编译安装${MBEDTLS_FILE}..."
        make SHARED=1 CFLAGS=-fPIC && make DESTDIR=/usr install
        if [ $? -ne 0 ]; then
            echo -e "${Error} ${MBEDTLS_FILE} 安装失败..."
            install_cleanup
            exit 1
        fi
        echo -e "${Info} ${MBEDTLS_FILE} 安装成功 !"
    else
        echo -e "${Info} ${MBEDTLS_FILE} 已经安装."
    fi
}

install_shadowsocks_libev(){
    cd ${CUR_DIR}
    tar zxf ${shadowsocks_libev_file}.tar.gz
    cd ${shadowsocks_libev_file}
    ./configure --disable-documentation && make && make install
    if [ $? -eq 0 ]; then
        chmod +x ${SHADOWSOCKS_LIBEV_INIT}
        local service_name=$(basename ${SHADOWSOCKS_LIBEV_INIT})
        if check_sys packageManager yum; then
            chkconfig --add ${service_name}
            chkconfig ${service_name} on
        elif check_sys packageManager apt; then
            update-rc.d -f ${service_name} defaults
        fi
        echo -e "${Info} Shadowsocks-libev安装成功."
    else
        echo
        echo -e "${Error} Shadowsocks-libev安装失败."
        echo
        install_cleanup
        exit 1
    fi
}

install_v2ray_plugin(){
    cd ${CUR_DIR}
    tar zxf ${v2ray_plugin_file}.tar.gz
    if [ ! -d "${SHADOWSOCKS_LIBEV_INSTALL_PATH}" ]; then
        mkdir -p ${SHADOWSOCKS_LIBEV_INSTALL_PATH}
    fi
    mv v2ray-plugin_linux_amd64 ${SHADOWSOCKS_LIBEV_INSTALL_PATH}/v2ray-plugin
    if [ $? -eq 0 ]; then
        echo -e "${Info} v2ray-plugin安装成功."
    else
        echo
        echo -e "${Error} v2ray-plugin安装失败."
        echo
        install_cleanup
        exit 1
    fi
}

install_simple_obfs(){
    cd ${CUR_DIR}
    git clone https://github.com/shadowsocks/simple-obfs.git
    [ -d simple-obfs ] && cd simple-obfs || echo -e "${Error} git clone simple-obfs 失败."
    git submodule update --init --recursive
    
    if centosversion 6; then
        if [ ! "$(command -v autoconf268)" ]; then
            echo -e "${Info} 开始安装 autoconf268."
            yum install -y autoconf268 > /dev/null 2>&1 || echo -e "${Error} autoconf268 安装失败."
        fi
        # replace command autoreconf to autoreconf268
        sed -i 's/autoreconf/autoreconf268/' autogen.sh
        # replace #include <ev.h> to #include <libev/ev.h>
        sed -i 's@^#include <ev.h>@#include <libev/ev.h>@' src/local.h
        sed -i 's@^#include <ev.h>@#include <libev/ev.h>@' src/server.h
    fi
    
    echo -e "${Info} 编译安装 simple-obfs-${simple_obfs_ver}."
    ./autogen.sh
    ./configure --disable-documentation
    make
    make install
    if [ ! "$(command -v obfs-server)" ]; then
        echo -e "${Error} simple-obfs-${simple_obfs_ver} 安装失败."
        install_cleanup
        exit 1
    fi
    [ -f /usr/local/bin/obfs-server ] && ln -s /usr/local/bin/obfs-server /usr/bin
    echo -e "${Info} simple-obfs-${simple_obfs_ver} 安装成功."

}

install_completed_libev(){
    if [ "${plugin_num}" == "1" ]; then
        clear
        ldconfig
        ${SHADOWSOCKS_LIBEV_INIT} start
        echo > ${HUMAN_CONFIG}
        echo -e "Congratulations, ${Green_font_prefix}Shadowsocks-libev${Font_color_suffix} server install completed!" >> ${HUMAN_CONFIG}
        echo -e "服务器地址            : ${red_font_prefix} $(get_ip) ${Font_color_suffix}" >> ${HUMAN_CONFIG}
        echo -e "服务器端口            : ${red_font_prefix} ${shadowsocksport} ${Font_color_suffix}" >> ${HUMAN_CONFIG}
        echo -e "      密码            : ${red_font_prefix} ${shadowsockspwd} ${Font_color_suffix}" >> ${HUMAN_CONFIG}
        echo -e "      加密            : ${red_font_prefix} ${shadowsockscipher} ${Font_color_suffix}" >> ${HUMAN_CONFIG}
        if [ "$(command -v v2ray-plugin)" ]; then
            echo -e "  插件程序            : ${red_font_prefix} v2ray-plugin ${Font_color_suffix}" >> ${HUMAN_CONFIG}
            if [[ ${libev_v2ray} == "1" ]]; then
                :
            elif [[ ${libev_v2ray} == "2" ]]; then
                echo -e "  插件选项            : ${red_font_prefix} tls;host=${domain} ${Font_color_suffix}" >> ${HUMAN_CONFIG}
            elif [[ ${libev_v2ray} == "3" ]]; then
                echo -e "  插件选项            : ${red_font_prefix} mode=quic;host=${domain} ${Font_color_suffix}" >> ${HUMAN_CONFIG}
            fi
            echo -e "  插件参数            :                                                                     " >> ${HUMAN_CONFIG}
            echo >> ${HUMAN_CONFIG}
            echo >> ${HUMAN_CONFIG}
            echo -e "Shadowsocks-libev配置路径：${SHADOWSOCKS_LIBEV_CONFIG}" >> ${HUMAN_CONFIG}
            echo >> ${HUMAN_CONFIG}
            echo >> ${HUMAN_CONFIG}
            echo -e "${Tip} 插件程序下载：https://github.com/shadowsocks/v2ray-plugin/releases 下载v2ray-plugin-windows-amd64 版本" >> ${HUMAN_CONFIG}
            echo -e "       请解压将插件重命名为 v2ray-plugin.exe 并移动至 SS-Windows 客户端-安装目录的${Red_font_prefix}根目录${Font_color_suffix}." >> ${HUMAN_CONFIG}
            echo >> ${HUMAN_CONFIG}
        fi
    if [ "${plugin_num}" == "2" ]; then
        clear
        ldconfig
        ${SHADOWSOCKS_LIBEV_INIT} start
        ${KCPTUN_INIT} start
        echo > ${HUMAN_CONFIG}
        echo -e "Congratulations, ${Green_font_prefix}Shadowsocks-libev${Font_color_suffix} server install completed!" >> ${HUMAN_CONFIG}
        echo -e "服务器地址            : ${red_font_prefix} $(get_ip) ${Font_color_suffix}" >> ${HUMAN_CONFIG}
        echo -e "服务器端口            : ${red_font_prefix} ${listen_port} ${Font_color_suffix}" >> ${HUMAN_CONFIG}
        echo -e "      密码            : ${red_font_prefix} ${shadowsockspwd} ${Font_color_suffix}" >> ${HUMAN_CONFIG}
        echo -e "      加密            : ${red_font_prefix} ${shadowsockscipher} ${Font_color_suffix}" >> ${HUMAN_CONFIG}
        if [ "$(command -v kcptun-server)" ]; then
        echo -e "  插件程序            : ${red_font_prefix} client_windows_amd64 ${Font_color_suffix}" >> ${HUMAN_CONFIG}
        echo -e "  插件选项            :                                                             " >> ${HUMAN_CONFIG}
        echo -e "  插件参数            : ${red_font_prefix} -l %SS_LOCAL_HOST%:%SS_LOCAL_PORT% -r %SS_REMOTE_HOST%:%SS_REMOTE_PORT% --crypt ${crypt} --key ${key} --mtu ${MTU} --sndwnd ${sndwnd} --rcvwnd ${rcvwnd} --mode ${mode} --datashard ${datashard} --parityshard ${parityshard} --dscp ${DSCP}${Font_color_suffix}" >> ${HUMAN_CONFIG}
        echo  >> ${HUMAN_CONFIG}
        echo  >> ${HUMAN_CONFIG}
        echo -e "Mobile Terminal Params: crypt=${crypt};key=${key};mtu=${MTU};sndwnd=${sndwnd};rcvwnd=${rcvwnd};mode=${mode};datashard=${datashard};parityshard=${parityshard};dscp=${DSCP}" >> ${HUMAN_CONFIG}
        echo >> ${HUMAN_CONFIG}
        echo >> ${HUMAN_CONFIG}
        echo -e "           Kcptun配置路径：${KCPTUN_CONFIG}" >> ${HUMAN_CONFIG}
        echo -e "Shadowsocks-libev配置路径：${SHADOWSOCKS_LIBEV_CONFIG}" >> ${HUMAN_CONFIG}
        echo >> ${HUMAN_CONFIG}
        echo >> ${HUMAN_CONFIG}
        echo -e "${Tip} 插件程序下载：https://github.com/xtaci/kcptun/releases/download/v20181114/kcptun-windows-amd64-20181114.tar.gz" >> ${HUMAN_CONFIG}
        echo -e "       请将解压后的两个文件中的 client_windows_amd64.exe ，移至 SS-Windows 客户端-安装目录的${Red_font_prefix}根目录${Font_color_suffix}." >> ${HUMAN_CONFIG}
        echo >> ${HUMAN_CONFIG}
        fi 
    elif [ "${plugin_num}" == "3" ]; then
        clear
        ldconfig
        ${SHADOWSOCKS_LIBEV_INIT} start
        echo > ${HUMAN_CONFIG}
        echo -e "Congratulations, ${Green_font_prefix}Shadowsocks-libev${Font_color_suffix} server install completed!" >> ${HUMAN_CONFIG}
        echo -e "服务器地址            : ${red_font_prefix} $(get_ip) ${Font_color_suffix}" >> ${HUMAN_CONFIG}
        echo -e "服务器端口            : ${red_font_prefix} ${shadowsocksport} ${Font_color_suffix}" >> ${HUMAN_CONFIG}
        echo -e "      密码            : ${red_font_prefix} ${shadowsockspwd} ${Font_color_suffix}" >> ${HUMAN_CONFIG}
        echo -e "      加密            : ${red_font_prefix} ${shadowsockscipher} ${Font_color_suffix}" >> ${HUMAN_CONFIG}
        if [ "$(command -v obfs-server)" ]; then
        echo -e "  插件程序            : ${red_font_prefix} obfs-local ${Font_color_suffix}" >> ${HUMAN_CONFIG}
        echo -e "  插件选项            : ${red_font_prefix} obfs=${shadowsocklibev_obfs} ${Font_color_suffix}" >> ${HUMAN_CONFIG}
        echo -e "  插件参数            : ${red_font_prefix} obfs-host=www.bing.com;fast-open=${fast_open} ${Font_color_suffix}" >> ${HUMAN_CONFIG}
        echo >> ${HUMAN_CONFIG}
        echo >> ${HUMAN_CONFIG}
        echo -e "Shadowsocks-libev配置路径：${SHADOWSOCKS_LIBEV_CONFIG}" >> ${HUMAN_CONFIG}
        echo >> ${HUMAN_CONFIG}
        echo >> ${HUMAN_CONFIG}
        echo -e "${Tip} 插件程序下载：https://github.com/shadowsocks/simple-obfs/releases/download/v0.0.5/obfs-local.zip" >> ${HUMAN_CONFIG}
        echo -e "       请将 obfs-local.exe 和 libwinpthread-1.dll 两个文件解压至 SS-Windows 客户端-安装目录的${Red_font_prefix}根目录${Font_color_suffix}." >> ${HUMAN_CONFIG}
        echo >> ${HUMAN_CONFIG}
        fi
    else
        clear
        ldconfig
        ${SHADOWSOCKS_LIBEV_INIT} start
        echo > ${HUMAN_CONFIG}
        echo -e "Congratulations, ${Green_font_prefix}Shadowsocks-libev${Font_color_suffix} server install completed!" >> ${HUMAN_CONFIG}
        echo -e "服务器地址            : ${red_font_prefix} $(get_ip) ${Font_color_suffix}" >> ${HUMAN_CONFIG}
        echo -e "服务器端口            : ${red_font_prefix} ${shadowsocksport} ${Font_color_suffix}" >> ${HUMAN_CONFIG}
        echo -e "      密码            : ${red_font_prefix} ${shadowsockspwd} ${Font_color_suffix}" >> ${HUMAN_CONFIG}
        echo -e "      加密            : ${red_font_prefix} ${shadowsockscipher} ${Font_color_suffix}" >> ${HUMAN_CONFIG}
        echo >> ${HUMAN_CONFIG}
        echo >> ${HUMAN_CONFIG}
        echo -e "Shadowsocks-libev配置路径：${SHADOWSOCKS_LIBEV_CONFIG}" >> ${HUMAN_CONFIG}
        echo >> ${HUMAN_CONFIG}
        echo >> ${HUMAN_CONFIG}
    fi
}

qr_generate_libev(){
    if [ "$(command -v qrencode)" ]; then
        if [[ ${plugin_num} == "2" ]]; then
            local tmp=$(echo -n "${shadowsockscipher}:${shadowsockspwd}@$(get_ip):${listen_port}" | base64 -w0)
            local qr_code="ss://${tmp}"
        else
            local tmp=$(echo -n "${shadowsockscipher}:${shadowsockspwd}@$(get_ip):${shadowsocksport}" | base64 -w0)
            local qr_code="ss://${tmp}"
        fi
        echo
        echo "Your QR Code: (For Shadowsocks Windows, OSX, Android and iOS clients)" >> ${HUMAN_CONFIG}
        echo -e "${Green_font_prefix} ${qr_code} ${Font_color_suffix}" >> ${HUMAN_CONFIG}
        echo -n "${qr_code}" | qrencode -s8 -o ${CUR_DIR}/shadowsocks_libev_qr.png
        echo "Your QR Code has been saved as a PNG file path:" >> ${HUMAN_CONFIG}
        echo -e "${Green_font_prefix} ${CUR_DIR}/shadowsocks_libev_qr.png ${Font_color_suffix}" >> ${HUMAN_CONFIG}
    fi
}

install_kcptun(){
    cd ${CUR_DIR}
    tar zxf ${kcptun_file}.tar.gz
    if [ ! -d "$(dirname ${KCPTUN_INSTALL_DIR})" ]; then
        mkdir -p $(dirname ${KCPTUN_INSTALL_DIR})
    fi
    mv server_linux_amd64 ${KCPTUN_INSTALL_DIR}
    if [ $? -eq 0 ]; then
        chmod +x ${KCPTUN_INIT}
        local service_name=$(basename ${KCPTUN_INIT})
        if check_sys packageManager yum; then
            chkconfig --add ${service_name}
            chkconfig ${service_name} on
        elif check_sys packageManager apt; then
            update-rc.d -f ${service_name} defaults
        fi
        echo -e "${Info} kcptun安装成功."
    else
        echo
        echo -e "${Error} kcptun安装失败."
        echo
        install_cleanup
        exit 1
    fi
    [ -f ${KCPTUN_INSTALL_DIR} ] && ln -s ${KCPTUN_INSTALL_DIR} /usr/bin
}

install_bbr(){
    download ${BBR_SHELL_FILE} ${BBR_SCRIPT_URL}
    chmod +x ${BBR_SHELL_FILE}
    ./$(basename ${BBR_SHELL_FILE})
}

install_main(){
    install_libsodium
    if ! ldconfig -p | grep -wq "/usr/lib"; then
        echo "/usr/lib" > /etc/ld.so.conf.d/lib.conf
    fi
    ldconfig
    if [ "${plugin_num}" == "1" ]; then
        install_mbedtls
        install_shadowsocks_libev
        install_v2ray_plugin
        install_completed_libev
        qr_generate_libev
        view_config    
    elif [ "${plugin_num}" == "2" ]; then
        install_mbedtls
        install_shadowsocks_libev
        install_kcptun
        install_completed_libev
        qr_generate_libev
        view_config
        
    elif [ "${plugin_num}" == "3" ]; then
        install_mbedtls
        install_shadowsocks_libev
        install_simple_obfs
        install_completed_libev
        qr_generate_libev
        view_config
    else
        install_mbedtls
        install_shadowsocks_libev
        install_completed_libev
        qr_generate_libev
        view_config
    fi

    echo
    echo "Installed successfully."
    echo "Enjoy it!"
    echo
}

install_shadowsocks(){
    [[ -e '/usr/local/bin/ss-server' ]] && echo -e "${Info} Shadowsocks-libev 已经安装..." && exit 1
    disable_selinux
    install_prepare
    config_shadowsocks
    install_dependencies
    download_files
    if check_sys packageManager yum; then
        config_firewall
    fi
    install_main
    install_cleanup
}

uninstall_shadowsocks(){
    printf "你确定要卸载Shadowsocks-libev吗? [y/n]\n"
    read -p "(默认: n):" answer
    [ -z ${answer} ] && answer="n"
    if [ "${answer}" == "y" ] || [ "${answer}" == "Y" ]; then
        # check Shadowsocks-libev status
        ${SHADOWSOCKS_LIBEV_INIT} status > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            ${SHADOWSOCKS_LIBEV_INIT} stop
        fi
        local ss_service_name=$(basename ${SHADOWSOCKS_LIBEV_INIT})
        if check_sys packageManager yum; then
            chkconfig --del ${ss_service_name}
        elif check_sys packageManager apt; then
            update-rc.d -f ${ss_service_name} remove
        fi
        
        # check kcptun status
        ${KCPTUN_INIT} status > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            ${KCPTUN_INIT} stop
        fi
        local kcp_service_name=$(basename ${KCPTUN_INIT})
        if check_sys packageManager yum; then
            chkconfig --del ${kcp_service_name}
        elif check_sys packageManager apt; then
            update-rc.d -f ${kcp_service_name} remove
        fi
        
        rm -fr $(dirname ${SHADOWSOCKS_LIBEV_CONFIG})
        rm -f /usr/local/bin/ss-local
        rm -f /usr/local/bin/ss-tunnel
        rm -f /usr/local/bin/ss-server
        rm -f /usr/local/bin/ss-manager
        rm -f /usr/local/bin/ss-redir
        rm -f /usr/local/bin/ss-nat
        rm -f /usr/local/bin/v2ray-plugin
        rm -f /usr/local/bin/obfs-local
        rm -f /usr/local/bin/obfs-server
        rm -f /usr/local/lib/libshadowsocks-libev.a
        rm -f /usr/local/lib/libshadowsocks-libev.la
        rm -f /usr/local/include/shadowsocks.h
        rm -f /usr/local/lib/pkgconfig/shadowsocks-libev.pc
        rm -f /usr/local/share/man/man1/ss-local.1
        rm -f /usr/local/share/man/man1/ss-tunnel.1
        rm -f /usr/local/share/man/man1/ss-server.1
        rm -f /usr/local/share/man/man1/ss-manager.1
        rm -f /usr/local/share/man/man1/ss-redir.1
        rm -f /usr/local/share/man/man1/ss-nat.1
        rm -f /usr/local/share/man/man8/shadowsocks-libev.8
        rm -fr /usr/local/share/doc/shadowsocks-libev
        rm -f ${SHADOWSOCKS_LIBEV_INIT}
        rm -fr $(dirname ${KCPTUN_INSTALL_DIR})
        rm -fr $(dirname ${KCPTUN_CONFIG})
        rm -f ${KCPTUN_INIT}

        echo -e "${Info} Shadowsocks-libev 卸载成功..."
    else
        echo
        echo -e "${Info} Shadowsocks-libev 卸载取消..."
        echo
    fi
}

view_config(){
    if [ -e $HUMAN_CONFIG ]; then
        cat $HUMAN_CONFIG
    else
        echo "The visual configuration was not found..."
    fi
}

install_cleanup(){
    cd ${CUR_DIR}
    rm -rf simple-obfs
    rm -rf ${LIBSODIUM_FILE} ${LIBSODIUM_FILE}.tar.gz
    rm -rf ${MBEDTLS_FILE} ${MBEDTLS_FILE}-gpl.tgz
    rm -rf ${shadowsocks_libev_file} ${shadowsocks_libev_file}.tar.gz
    rm -rf client_linux_amd64 server_linux_amd64 ${kcptun_file}.tar.gz 
    rm -rf v2ray-plugin_linux_amd64 ${v2ray_plugin_file}.tar.gz

}

# install status
install_status(){
	if [[ -e '/usr/local/bin/ss-server' ]]; then
		check_pid
		if [[ ! -z "${PID}" ]]; then
			echo -e " 当前状态: ${Green_font_prefix}已安装${Font_color_suffix} 并 ${Green_font_prefix}已启动${Font_color_suffix}"
		else
			echo -e " 当前状态: ${Green_font_prefix}已安装${Font_color_suffix} 但 ${Red_font_prefix}未启动${Font_color_suffix}"
		fi
		cd "${ssr_folder}"
	else
		echo -e " 当前状态: ${Red_font_prefix}未安装${Font_color_suffix}"
	fi
}



action=$1

# check supported
if ! install_check; then
    echo -e "[${red}Error${plain}] Your OS is not supported to run it!"
    echo "Please change to CentOS 6+/Debian 7+/Ubuntu 12+ and try again."
    exit 1
fi

if [[ "${action}" == "install" ]]; then
	install_shadowsocks
elif [[ "${action}" == "uninstall" ]]; then
	uninstall_shadowsocks
elif [[ "${action}" == "config" ]]; then
	view_config
else
	echo -e "  Shadowsocks-libev一键管理脚本 ${Red_font_prefix}[v${SHELL_VERSION}]${Font_color_suffix}

  ${Green_font_prefix}1.${Font_color_suffix} BBR
  ${Green_font_prefix}2.${Font_color_suffix} Install
  ${Green_font_prefix}3.${Font_color_suffix} Uninstall
 "
	install_status
	echo && read -e -p "请输入数字 [1-3]：" menu_num
case "${menu_num}" in
    1)
	install_bbr
	;;
	2)
	install_shadowsocks
	;;
	3)
	uninstall_shadowsocks
	;;
	*)
	echo -e "${Error} 请输入正确的数字 [1-3]"
	;;
esac
fi