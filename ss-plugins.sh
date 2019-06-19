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
LIBSODIUM_FILE="libsodium-1.0.17"
LIBSODIUM_URL="https://github.com/jedisct1/libsodium/releases/download/1.0.17/libsodium-1.0.17.tar.gz"
MBEDTLS_FILE="mbedtls-2.16.0"
MBEDTLS_URL="https://tls.mbed.org/download/mbedtls-2.16.0-gpl.tgz"



# kcptun
KCPTUN_INSTALL_DIR="/usr/local/kcptun/kcptun-server"
KCPTUN_INIT="/etc/init.d/kcptun"
KCPTUN_CONFIG="/etc/kcptun/config.json"
KCPTUN_LOG_DIR="/var/log/kcptun-server.log"
KCPTUN_CENTOS="https://git.io/fjcLx"
KCPTUN_DEBIAN="https://git.io/fjcLp"


# cloak
CK_DB_PATH="/etc/cloak/db"
CK_CLIENT_CONFIG="/etc/cloak/ckclient.json"


# caddy config
CADDY_CONF_FILE="/usr/local/caddy/Caddyfile"



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
ws+http
ws+tls+[cdn]
quic+tls+[cdn]
ws+tls+web
ws+tls+web+cdn
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



# ipv4 and ipv6 Re
IPV4_RE="^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])$"
IPV6_RE="^\s*((([0-9A-Fa-f]{1,4}:){7}(([0-9A-Fa-f]{1,4})|:))|(([0-9A-Fa-f]{1,4}:){6}(:|((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})|(:[0-9A-Fa-f]{1,4})))|(([0-9A-Fa-f]{1,4}:){5}((:((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})?)|((:[0-9A-Fa-f]{1,4}){1,2})))|(([0-9A-Fa-f]{1,4}:){4}(:[0-9A-Fa-f]{1,4}){0,1}((:((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})?)|((:[0-9A-Fa-f]{1,4}){1,2})))|(([0-9A-Fa-f]{1,4}:){3}(:[0-9A-Fa-f]{1,4}){0,2}((:((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})?)|((:[0-9A-Fa-f]{1,4}){1,2})))|(([0-9A-Fa-f]{1,4}:){2}(:[0-9A-Fa-f]{1,4}){0,3}((:((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})?)|((:[0-9A-Fa-f]{1,4}){1,2})))|(([0-9A-Fa-f]{1,4}:)(:[0-9A-Fa-f]{1,4}){0,4}((:((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})?)|((:[0-9A-Fa-f]{1,4}){1,2})))|(:(:[0-9A-Fa-f]{1,4}){0,5}((:((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})?)|((:[0-9A-Fa-f]{1,4}){1,2})))|(((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})))(%.+)?\s*$"


Green="\033[32m" && Red="\033[31m" && Yellow="\033[0;33m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && suffix="\033[0m"
Info="${Green}[信息]${suffix}"
Error="${Red}[错误]${suffix}"
Point="${Red}[提示]${suffix}"
Tip="${Green}[注意]${suffix}"
Warning="${Yellow}[警告]${suffix}"
Separator_1="——————————————————————————————"


[[ $EUID -ne 0 ]] && echo -e "[${red}Error${suffix}] This script must be run as root!" && exit 1

usage() {
	cat >&1 <<-EOF

  请使用: ./$0 [option] [uid]

    可使用的参数 <option> 包括:

        install          安装
        uninstall        卸载
        update           升级
        start            启动
        stop             关闭
        restart          重启
        status           查看状态
        show             显示可视化配置
        uid              添加一个New User (仅ss + cloak下可用)
        url              生成一个New SS URL (仅ss + cloak下可用)
        scan             根据生成的ss:// 链接，在当前终端上，手动生成一个可供扫描的二维码
        help             查看脚本使用说明
        
	EOF

	exit $1
}

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

check_ss_libev_version(){
    if [[ -e '/usr/local/bin/ss-server' ]]; then
        curr_ver=$(ss-server -v | grep shadowsocks-libev | cut -d\  -f2)
        latest_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/shadowsocks/shadowsocks-libev/releases | grep -o '"tag_name": ".*"' | head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        if version_gt ${latest_ver} ${curr_ver}; then
            return 0
        else
            return 1
        fi
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
    goquiet_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/cbeuw/GoQuiet/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
    [ -z ${goquiet_ver} ] && echo -e "${Error} 获取 goquiet 最新版本失败." && exit 1
    cloak_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/cbeuw/Cloak/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
    [ -z ${cloak_ver} ] && echo -e "${Error} 获取 cloak 最新版本失败." && exit 1
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

get_str_base64_encode(){
    echo -n $1 | base64 -w0
}

get_str_replace(){
    echo -n $1 | sed 's/:/%3a/g;s/;/%3b/g;s/=/%3d/g;s/\//%2f/g'
}

gen_random_prot(){
    ran_prot=$(shuf -i 9000-19999 -n 1)
}

gen_random_str(){
    ran_str8=$(head -c 100 /dev/urandom | tr -dc a-z0-9A-Z |head -c 12)
    ran_str16=$(head -c 100 /dev/urandom | tr -dc a-z0-9A-Z |head -c 16)
}

gen_credentials(){
    while true
    do
        ckauid=$(ck-server -u)
        IFS=, read ckpub ckpv <<< $(ck-server -k)
        
        # filter "+" from ckauid and ckpub
        if [[ $(echo ${ckauid} | grep "+") || $(echo ${ckpub} | grep "+") ]]; then
            continue
        fi
        break
    done
}


install_prepare_port() {
    while true
    do
        gen_random_prot
        echo -e "\n请输入Shadowsocks-libev端口 [1-65535]"
        read -e -p "(默认: ${ran_prot}):" shadowsocksport
        [ -z "${shadowsocksport}" ] && shadowsocksport=${ran_prot}
        expr ${shadowsocksport} + 1 &>/dev/null
        if [ $? -eq 0 ]; then
            if [ ${shadowsocksport} -ge 1 ] && [ ${shadowsocksport} -le 65535 ] && [ ${shadowsocksport:0:1} != 0 ]; then
                echo
                echo -e "${Red}  port = ${shadowsocksport}${suffix}"
                echo
                echo -e "${Tip} 如果插件选择v2ray(1|2|3)、goquiet、cloak时，此端口会被重置为 80 或 443，且插件选择${Red}v2ray(4|5)${suffix}时，该端口不能是443"
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
    read -e -p "(默认: ${ran_str8}):" shadowsockspwd
    [ -z "${shadowsockspwd}" ] && shadowsockspwd=${ran_str8}
    echo
    echo -e "${Red}  password = ${shadowsockspwd}${suffix}"
    echo
}

install_prepare_cipher(){
    while true
    do
        echo -e "\n请选择Shadowsocks-libev加密方式"

        for ((i=1;i<=${#SHADOWSOCKS_CIPHERS[@]};i++ )); do
            hint="${SHADOWSOCKS_CIPHERS[$i-1]}"
            if [[ ${i} -le 9 ]]; then
                echo -e "${Green}  ${i}.${suffix} ${hint}"
            else
                echo -e "${Green} ${i}.${suffix} ${hint}"
            fi
        done
        
        echo
        read -e -p "(默认: ${SHADOWSOCKS_CIPHERS[14]}):" pick
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
        echo -e "${Red}  cipher = ${shadowsockscipher}${suffix}"
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

intall_acme_tool(){
    # Install certificate generator tools
    if [ ! -e ~/.acme.sh/acme.sh ]; then
        echo
        echo -e "${Info} 开始安装实现了 acme 协议, 可以从 letsencrypt 生成免费的证书的 acme.sh "
        echo
        curl  https://get.acme.sh | sh
        echo
        echo -e "${Info} acme.sh 安装完成. "
        echo
    else
        echo
        echo -e "${Info} 证书生成工具 acme.sh 已经安装，自动进入下一步，请选择... "
        echo
    fi
}

install_prepare_libev_v2ray(){
    while true
    do
        echo -e "请为v2ray-plugin选择 Transport mode\n"
        for ((i=1;i<=${#V2RAY_PLUGIN_TRANSPORT_MODE[@]};i++ )); do
            hint="${V2RAY_PLUGIN_TRANSPORT_MODE[$i-1]}"
            echo -e "${Green}  ${i}.${suffix} ${hint}"
        done
        echo
        read -e -p "(默认: ${V2RAY_PLUGIN_TRANSPORT_MODE[0]}):" libev_v2ray
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
        echo -e "${Red}  over = ${shadowsocklibev_v2ray}${suffix}"
        echo 
        
        break
    done
    
 
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
        
        while true
        do    
            echo
            read -e -p "请输入你的域名：" domain
            echo
            # Is the test domain correct.
            ping ${domain} -c 1 | sed '1{s/[^(]*(//;s/).*//;q}' | head -n 1 | grep -P ${IPV4_RE} > /dev/null 2>&1
            # if [[ $? -eq 0 ]] && test "$(ping ${domain} -c 1 | sed '1{s/[^(]*(//;s/).*//;q}' | head -n 1)" = $(get_ip); then
            if [[ $? -eq 0 ]]; then
                echo
                echo -e "${Red}  host = ${domain}${suffix}"
                echo
                break
            else
                echo
                echo -e "${Error} 请确认该域名是否被域名服务器成功解析，如果没有，则请在解析成功后，再次重试..."
                echo
                continue
            fi
        done

        echo 
        echo -e "是否使用CloudFlare域API自动颁发证书(否，则由acme.sh假装一个webserver, 临时监听在80 端口, 完成验证，强制生成)? [Y/n]\n" 
        read -e -p "(默认: n):" yn
        [[ -z "${yn}" ]] && yn="n"
        if [[ $yn == [Yy] ]]; then
            echo
            read -e -p "请输入你的Cloudflare的Global API Key：" CF_Key
            echo
            echo -e "${Red}  CF_Key = ${CF_Key}${suffix}"
            echo 
            read -e -p "请输入你的Cloudflare的账号Email：" CF_Email
            echo
            echo -e "${Red}  CF_Email = ${CF_Email}${suffix}"
            echo
            
            intall_acme_tool
            
            echo
            echo -e "${Info} 开始生成域名 ${domain} 相关的证书 "
            echo
            export CF_Key=${CF_Key}
            export CF_Email=${CF_Email}
            ~/.acme.sh/acme.sh --issue --dns dns_cf -d ${domain}
            
            cerpath="/root/.acme.sh/${domain}/fullchain.cer"
            keypath="/root/.acme.sh/${domain}/${domain}.key"
            
            echo
            echo -e "${Info} ${domain} 证书生成完成. "
            echo
            
        else
            intall_acme_tool
            
            if [ ! "$(command -v socat)" ]; then
                echo -e "${Info} 开始安装强制生成时必要的socat 软件包."
                if check_sys packageManager yum; then
                    yum install -y socat > /dev/null 2>&1
                    if [ $? -ne 0 ]; then
                        echo -e "${Error} 安装socat失败."
                        exit 1
                    fi
                elif check_sys packageManager apt; then
                    apt-get -y update > /dev/null 2>&1
                    apt-get -y install socat > /dev/null 2>&1
                    if [ $? -ne 0 ]; then
                        echo -e "${Error} 安装socat失败."
                        exit 1
                    fi
                fi
                echo -e "${Info} socat 安装完成."
            fi
            
            echo
            echo -e "${Info} 开始生成域名 ${domain} 相关的证书 "
            echo
            ~/.acme.sh/acme.sh --issue -d ${domain}   --standalone
            
            cerpath="/root/.acme.sh/${domain}/fullchain.cer"
            keypath="/root/.acme.sh/${domain}/${domain}.key"
            
            echo
            echo -e "${Info} ${domain} 证书生成完成. "
            echo
        fi  

    elif [[ ${libev_v2ray} = "4" ]]; then
        while true
        do
            echo
            read -e -p "请输入你的域名(必须成功解析过本机ip)：" domain
            echo
            
            # Is the test domain correct.
            ping ${domain} -c 1 | sed '1{s/[^(]*(//;s/).*//;q}' | head -n 1 | grep -P ${IPV4_RE} > /dev/null 2>&1
            if [[ $? -eq 0 ]] && test "$(ping ${domain} -c 1 | sed '1{s/[^(]*(//;s/).*//;q}' | head -n 1 )" = $(get_ip); then
                echo
                echo -e "${Red}  host = ${domain}${suffix}"
                echo
                break
            else
                echo
                echo -e "${Error} 请确认该域名是否有解析过本机ip地址，如果没有，前往域名服务商解析本机ip地址至该域名，并重新尝试."
                echo
                continue
            fi
        done
            
            echo 
            read -e -p "请输入供于域名证书生成所需的 Email：" email
            echo
            echo -e "${Red}  email = ${email}${suffix}"
            echo
            
            echo
            read -e -p "请输入你的WebSocket分流路径(默认：/v2ray)：" path
            echo
            [ -z "${path}" ] && path="/v2ray"
            echo
            echo -e "${Red}  path = ${path}${suffix}"
            echo
            
            echo
            echo -e "${Tip} 该站点建议满足(位于海外、支持HTTPS协议、会用来传输大流量... )的条件，默认站点，随意找的，不建议使用"
            read -e -p "请输入你需要镜像到的站点(默认：https://www.bostonusa.com)：" mirror_site
            echo
            [ -z "${mirror_site}" ] && mirror_site="https://www.bostonusa.com"
            echo
            echo -e "${Red}  mirror_site = ${mirror_site}${suffix}"
            echo 

    elif [[ ${libev_v2ray} = "5" ]]; then
        while true
        do
            echo
            read -e -p "请输入你的域名(必须是交由Cloudflare域名服务器托管且成功解析过本机ip)：" domain
            echo
            
            # Is the test domain correct.
            ping ${domain} -c 1 | sed '1{s/[^(]*(//;s/).*//;q}' | head -n 1 | grep -P ${IPV4_RE} > /dev/null 2>&1
            # if [[ $? -eq 0 ]] && test "$(ping ${domain} -c 1 | sed '1{s/[^(]*(//;s/).*//;q}' | head -n 1)" = $(get_ip); then
            if [[ $? -eq 0 ]]; then
                echo
                echo -e "${Red}  host = ${domain}${suffix}"
                echo
                break
            else
                echo
                echo -e "${Error} 请确认该域名是否有交给 Cloudflare 托管，并解析过本机ip地址"
                echo -e "         如果没有，前往域名服务商将域名DNS服务器更改为 Cloudflare 的DNS服务器，并在 Cloudflare 上解析本机ip地址至该域名，并重新尝试."
                echo
                continue
            fi
        done
            
            echo
            read -e -p "请输入你的WebSocket分流路径(默认：/v2ray)：" path
            echo
            [ -z "${path}" ] && path="/v2ray"
            echo
            echo -e "${Red}  path = ${path}${suffix}"
            echo 

            echo
            echo -e "${Tip} 该站点建议满足(位于海外、支持HTTPS协议、会用来传输大流量... )的条件，默认站点，随意找的，不建议使用"
            read -e -p "请输入你需要镜像到的站点(默认：https://www.bostonusa.com)：" mirror_site
            echo
            [ -z "${mirror_site}" ] && mirror_site="https://www.bostonusa.com"
            echo
            echo -e "${Red}  mirror_site = ${mirror_site}${suffix}"
            echo 
            
            echo
            read -e -p "请输入你的Cloudflare的Global API Key：" CF_Key
            echo
            echo -e "${Red}  cloudflare_api_key = ${CF_Key}${suffix}"
            echo 
            read -e -p "请输入你的Cloudflare的账号Email：" CF_Email
            echo
            echo -e "${Red}  cloudflare_email = ${CF_Email}${suffix}"
            echo
    fi
}

install_prepare_libev_kcptun(){ 
    # 设置 Kcptun 服务器监听端口 listen_port
    while true
    do
        echo -e "请输入 Kcptun 服务端运行端口 [1-65535]\n${Tip} 这个端口，就是 Kcptun 客户端要连接的端口."
        read -e -p "(默认: 29900):" listen_port
        [ -z "${listen_port}" ] && listen_port=29900
        expr ${listen_port} + 1 &>/dev/null
        if [ $? -eq 0 ]; then
            if [ ${listen_port} -ge 1 ] && [ ${listen_port} -le 65535 ] && [ ${listen_port:0:1} != 0 ]; then
                echo
                echo -e "${Red}  port = ${listen_port}${suffix}"
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
        read -e -p "(默认: 127.0.0.1):" target_addr
        [ -z "${target_addr}" ] && target_addr=127.0.0.1
        if is_ipv4_or_ipv6 ${target_addr}; then
            echo
            echo -e "${Red}  ip(target) = ${target_addr}${suffix}"
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
        echo -e "请输入需要加速的端口 [1-65535]\n${Tip} 这里用来加速SS，那就输入前面填写过的SS的端口: ${Red}${shadowsocksport}${suffix}"
        read -e -p "(默认: ${shadowsocksport}):" target_port
        [ -z "${target_port}" ] && target_port=${shadowsocksport}
        expr ${target_port} + 1 &>/dev/null
        if [ $? -eq 0 ]; then
            if [ ${target_port} -ge 1 ] && [ ${target_port} -le 65535 ] && [ ${target_port:0:1} != 0 ]; then
                echo
                echo -e "${Red}  port(target) = ${target_port}${suffix}"
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
    read -e -p "(默认: ${ran_str8}):" key
    [ -z "${key}" ] && key=${ran_str8}
    echo
    echo -e "${Red}  key = ${key}${suffix}"
    echo
    
    # 设置 Kcptun 加密方式 crypt
    while true
    do
        echo -e "请选择加密方式(crypt)\n${Tip} 强加密对 CPU 要求较高，如果是在路由器上配置客户端，请尽量选择弱加密或者不加密。该参数必须两端一致"

        for ((i=1;i<=${#KCPTUN_CRYPT[@]};i++ )); do
            hint="${KCPTUN_CRYPT[$i-1]}"
            if [[ ${i} -le 9 ]]; then
                echo -e "${Green}  ${i}.${suffix} ${hint}"
            else
                echo -e "${Green} ${i}.${suffix} ${hint}"
            fi
        done
        
        echo
        read -e -p "(默认: ${KCPTUN_CRYPT[0]}):" crypt
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
        echo -e "${Red}  crypt = ${crypt}${suffix}"
        echo
        break
    done
    
    # 设置 Kcptun 加速模式 mode
    while true
    do
        echo -e "请选择加速模式(mode)\n${Tip} 加速模式和发送窗口大小共同决定了流量的损耗大小. ${Red}未支持(手动模式 manual)${suffix}”"

        for ((i=1;i<=${#KCPTUN_MODE[@]};i++ )); do
            hint="${KCPTUN_MODE[$i-1]}"
            if [[ ${i} -le 9 ]]; then
                echo -e "${Green}  ${i}.${suffix} ${hint}"
            else
                echo -e "${Green} ${i}.${suffix} ${hint}"
            fi
        done
        
        echo
        read -e -p "(默认: ${KCPTUN_MODE[1]}):" mode
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
        echo -e "${Red}  mode = ${mode}${suffix}"
        echo
        break
    done
    
    # 设置 UDP 数据包的 MTU (最大传输单元)值
    while true
    do
        echo -e "请设置 UDP 数据包的 MTU (最大传输单元)值"
        read -e -p "(默认: 1350):" MTU
        [ -z "${MTU}" ] && MTU=1350
        expr ${MTU} + 1 &>/dev/null
        if [ $? -eq 0 ]; then
            if [ ${MTU} -ge 1 ] && [ ${MTU:0:1} != 0 ]; then
                echo
                echo -e "${Red}  MTU = ${MTU}${suffix}"
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
        read -e -p "(默认: 1024):" sndwnd
        [ -z "${sndwnd}" ] && sndwnd=1024
        expr ${sndwnd} + 1 &>/dev/null
        if [ $? -eq 0 ]; then
            if [ ${sndwnd} -ge 1 ] && [ ${sndwnd:0:1} != 0 ]; then
                echo
                echo -e "${Red}  sndwnd = ${sndwnd}${suffix}"
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
        read -e -p "(默认: 1024):" rcvwnd
        [ -z "${rcvwnd}" ] && rcvwnd=1024
        expr ${rcvwnd} + 1 &>/dev/null
        if [ $? -eq 0 ]; then
            if [ ${rcvwnd} -ge 1 ] && [ ${rcvwnd:0:1} != 0 ]; then
                echo
                echo -e "${Red}  rcvwnd = ${rcvwnd}${suffix}"
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
        read -e -p "(默认: 10):" datashard
        [ -z "${datashard}" ] && datashard=10
        expr ${datashard} + 1 &>/dev/null
        if [ $? -eq 0 ]; then
            if [ ${datashard} -ge 1 ] && [ ${datashard:0:1} != 0 ]; then
                echo
                echo -e "${Red}  datashard = ${datashard}${suffix}"
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
        read -e -p "(默认: 3):" parityshard
        [ -z "${parityshard}" ] && parityshard=3
        expr ${parityshard} + 1 &>/dev/null
        if [ $? -eq 0 ]; then
            if [ ${parityshard} -ge 1 ] && [ ${parityshard:0:1} != 0 ]; then
                echo
                echo -e "${Red}  parityshard = ${parityshard}${suffix}"
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
        read -e -p "(默认: 46):" DSCP
        [ -z "${DSCP}" ] && DSCP=46
        expr ${DSCP} + 1 &>/dev/null
        if [ $? -eq 0 ]; then
            if [ ${DSCP} -ge 1 ] && [ ${DSCP:0:1} != 0 ]; then
                echo
                echo -e "${Red}  DSCP = ${DSCP}${suffix}"
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

install_prepare_libev_obfs(){
    if ! autoconf_version || centosversion 6; then
        echo
        echo -e "${Info} autoconf 版本小于 2.67，Shadowsocks-libev 插件 simple-obfs 的安装将被终止."
        echo
        exit 1
    fi
    
    while true
    do
        echo -e "请为simple-obfs选择obfs\n"
        for ((i=1;i<=${#OBFUSCATION_WRAPPER[@]};i++ )); do
            hint="${OBFUSCATION_WRAPPER[$i-1]}"
            echo -e "${Green}  ${i}.${suffix} ${hint}"
        done
        echo
        read -e -p "(默认: ${OBFUSCATION_WRAPPER[0]}):" libev_obfs
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
        echo -e "${Red}  obfs = ${shadowsocklibev_obfs}${suffix}"
        echo
        break
    done
    
    echo
    echo -e "请为simple-obfs输入用于混淆的域名"
    echo
    read -e -p "(默认: www.bing.com):" domain
    [ -z "$domain" ] && domain="www.bing.com"
    echo
    echo -e "${Red}  obfs-host = ${domain}${suffix}"
    echo

}

install_prepare_libev_goquiet(){
    gen_random_str
    shadowsocksport=443
    echo
    echo -e "请为GoQuiet输入重定向ip:port [留空以将其设置为bing.com的204.79.197.200:443]"
    read -e -p "(默认: 204.79.197.200:443):" gqwebaddr
    [ -z "$gqwebaddr" ] && gqwebaddr="204.79.197.200:443"
    echo
    echo -e "${Red}  WebServerAddr = ${gqwebaddr}${suffix}"
    echo
    echo -e "${Tip} server_port已被重置为：port = ${shadowsocksport}"
    echo 
    echo
    echo -e "请为GoQuiet输入重定向ip:port相对应的域名"
    echo
    read -e -p "(默认: www.bing.com):" domain
    [ -z "$domain" ] && domain="www.bing.com"
    echo
    echo -e "${Red}  ServerName = ${domain}${suffix}"
    echo
    echo
    echo -e "请为GoQuiet输入密钥 [留空以将其设置为16位随机字符串]"
    echo
    read -e -p "(默认: ${ran_str16}):" gqkey
    [ -z "$gqkey" ] && gqkey=${ran_str16}
    echo
    echo -e "${Red}  Key = ${gqkey}${suffix}"
    echo
}

install_prepare_libev_cloak(){
    shadowsocksport=443
    echo -e "请为Cloak输入重定向ip:port [留空以将其设置为bing.com的204.79.197.200:443]"
    echo
    read -e -p "(默认: 204.79.197.200:443):" ckwebaddr
    [ -z "$ckwebaddr" ] && ckwebaddr="204.79.197.200:443"
    echo
    echo -e "${Red}  WebServerAddr = ${ckwebaddr}${suffix}"
    echo
    echo -e "${Tip} server_port已被重置为：port = ${shadowsocksport}"
    echo 
    echo
    echo -e "请为Cloak输入重定向ip:port相对应的域名"
    echo
    read -e -p "(默认: www.bing.com):" domain
    [ -z "$domain" ] && domain="www.bing.com"
    echo
    echo -e "${Red}  ServerName = ${domain}${suffix}"
    echo
    echo
    echo -e "请为Cloak设置一个userinfo.db存放路径"
    read -e -p "(默认: $CK_DB_PATH)" ckdbp
    [ -z "$ckdbp" ] && ckdbp=$CK_DB_PATH
    if [ ! -e "${ckdbp}" ]; then
        mkdir -p "${ckdbp}/db-backup"
    fi
    echo
    echo -e "${Red}  DatabasePath = ${ckdbp}${suffix}"
    echo
}


install_prepare(){
    install_prepare_port
    install_prepare_password
    install_prepare_cipher
    echo -e "请选择要安装的SS-Plugin
    
  ${Green}1.${suffix} v2ray
  ${Green}2.${suffix} kcptun
  ${Green}3.${suffix} simple-obfs
  ${Green}4.${suffix} goquiet (unofficial)
  ${Green}5.${suffix} cloak (based goquiet)
  "
    echo && read -e -p "(默认: 不安装)：" plugin_num
    [[ -z "${plugin_num}" ]] && plugin_num="" && echo -e "\n${Tip} 当前未选择任何插件，仅安装Shadowsocks-libev."
    if [[ ${plugin_num} == "1" ]]; then
        install_prepare_libev_v2ray
    elif [[ ${plugin_num} == "2" ]]; then
        install_prepare_libev_kcptun
    elif [[ ${plugin_num} == "3" ]]; then
        install_prepare_libev_obfs
    elif [[ ${plugin_num} == "4" ]]; then
        install_prepare_libev_goquiet
    elif [[ ${plugin_num} == "5" ]]; then
        install_prepare_libev_cloak
    elif [[ ${plugin_num} == "" ]]; then
        :
    else
        echo -e "${Error} 请输入正确的数字 [1-5]" && exit 1
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
        echo -e "${Error} 依赖包${red}${depend}${suffix}安装失败，请检查. "
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
            gettext gcc pcre pcre-devel autoconf libtool automake make asciidoc xmlto c-ares-devel libev-devel zlib-devel openssl-devel git wget qrencode
        )
        for depend in ${yum_depends[@]}; do
            error_detect_depends "yum -y install ${depend}"
        done
    elif check_sys packageManager apt; then
        apt_depends=(
            gettext gcc build-essential autoconf libtool libpcre3-dev asciidoc xmlto libev-dev libc-ares-dev automake libssl-dev git wget qrencode
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
    
    # Download Shadowsocks-libev
    get_ver
    shadowsocks_libev_file="shadowsocks-libev-${libev_ver}"
    shadowsocks_libev_url="https://github.com/shadowsocks/shadowsocks-libev/releases/download/v${libev_ver}/shadowsocks-libev-${libev_ver}.tar.gz"
    download "${shadowsocks_libev_file}.tar.gz" "${shadowsocks_libev_url}"
    if check_sys packageManager yum; then
        download "${SHADOWSOCKS_LIBEV_INIT}" "${SHADOWSOCKS_LIBEV_CENTOS}"
    elif check_sys packageManager apt; then
        download "${SHADOWSOCKS_LIBEV_INIT}" "${SHADOWSOCKS_LIBEV_DEBIAN}"
    fi
    
    if [[ "${plugin_num}" == "1" ]]; then        
        # Download v2ray-plugin
        v2ray_plugin_file="v2ray-plugin-linux-amd64-v${v2ray_plugin_ver}"
        v2ray_plugin_url="https://github.com/shadowsocks/v2ray-plugin/releases/download/v${v2ray_plugin_ver}/v2ray-plugin-linux-amd64-v${v2ray_plugin_ver}.tar.gz"
        download "${v2ray_plugin_file}.tar.gz" "${v2ray_plugin_url}"
        
    elif [[ "${plugin_num}" == "2" ]]; then        
        # Download kcptun
        kcptun_file="kcptun-linux-amd64-${kcptun_ver}"
        kcptun_url="https://github.com/xtaci/kcptun/releases/download/v${kcptun_ver}/kcptun-linux-amd64-${kcptun_ver}.tar.gz"
        download "${kcptun_file}.tar.gz" "${kcptun_url}"
        
        if check_sys packageManager yum; then
            download "${KCPTUN_INIT}" "${KCPTUN_CENTOS}"
        elif check_sys packageManager apt; then
            download "${KCPTUN_INIT}" "${KCPTUN_DEBIAN}"
        fi
        
    elif [[ "${plugin_num}" == "4" ]]; then        
        # Download goquiet
        goquiet_file="gq-server-linux-amd64-${goquiet_ver}"
        goquiet_url="https://github.com/cbeuw/GoQuiet/releases/download/v${goquiet_ver}/gq-server-linux-amd64-${goquiet_ver}"
        download "${goquiet_file}" "${goquiet_url}"
        
    elif [[ "${plugin_num}" == "5" ]]; then        
        # Download cloak server
        cloak_file="ck-server-linux-amd64-${cloak_ver}"
        cloak_url="https://github.com/cbeuw/Cloak/releases/download/v${cloak_ver}/ck-server-linux-amd64-${cloak_ver}"
        download "${cloak_file}" "${cloak_url}"
        
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

    # shadowsocklibev-libev config
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

    # kcptun config
    if [[ ${plugin_num} == "2" ]]; then
        if [ ! -d "$(dirname ${KCPTUN_CONFIG})" ]; then
            mkdir -p $(dirname ${KCPTUN_CONFIG})
        fi
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
    fi

    # "mode":"tcp_and_udp" after add a ,
    if [[ ${plugin_num} -ge "1" && ${plugin_num} -le "5" && ${plugin_num} -ne "2" ]]; then
        sed 's/"mode.*/&,/g' -i ${SHADOWSOCKS_LIBEV_CONFIG}
    fi

    # write config of plugin
    if [[ ${plugin_num} == "1" ]]; then
        if [[ ${libev_v2ray} == "1" ]]; then
            sed '/^}/i\    "plugin":"v2ray-plugin",\n    "plugin_opts":"server"' -i ${SHADOWSOCKS_LIBEV_CONFIG}
        elif [[ ${libev_v2ray} == "2" ]]; then    
           sed '/^}/i\    "plugin":"v2ray-plugin",\n    "plugin_opts":"'"server;tls;host=${domain};cert=${cerpath};key=${keypath}"'"' -i ${SHADOWSOCKS_LIBEV_CONFIG}
        elif [[ ${libev_v2ray} == "3" ]]; then
            sed 's/tcp_and_udp/tcp_only/' -i ${SHADOWSOCKS_LIBEV_CONFIG}
            sed '/^}/i\    "plugin":"v2ray-plugin",\n    "plugin_opts":"'"server;mode=quic;host=${domain};cert=${cerpath};key=${keypath}"'"' -i ${SHADOWSOCKS_LIBEV_CONFIG}
        elif [[ ${libev_v2ray} == "4" ]]; then
            sed '/^}/i\    "plugin":"v2ray-plugin",\n    "plugin_opts":"'"server;path=${path};loglevel=none"'"' -i ${SHADOWSOCKS_LIBEV_CONFIG}
            
            # write caddy confing
            cat > ${CADDY_CONF_FILE}<<-EOF
${domain}:443 {
    gzip
    tls ${email}
    timeouts none
    proxy ${path} localhost:${shadowsocksport} {
        websocket
        header_upstream -Origin
    }
    proxy / ${mirror_site} {
        except ${path}
    }
}
EOF
            
        elif [[ ${libev_v2ray} == "5" ]]; then
            sed '/^}/i\    "plugin":"v2ray-plugin",\n    "plugin_opts":"'"server;path=${path};loglevel=none"'"' -i ${SHADOWSOCKS_LIBEV_CONFIG}
            
            # write caddy confing
            cat > ${CADDY_CONF_FILE}<<-EOF
${domain}:443 {
    gzip
    tls {
        dns cloudflare
    }
    timeouts none
    proxy ${path} localhost:${shadowsocksport} {
        websocket
        header_upstream -Origin
    }
    proxy / ${mirror_site} {
        except ${path}
    }
}
EOF
        fi
    elif [[ ${plugin_num} == "3" ]]; then
        sed '/^}/i\    "plugin":"obfs-server",\n    "plugin_opts":"'"obfs=${shadowsocklibev_obfs}"'"' -i ${SHADOWSOCKS_LIBEV_CONFIG}
    elif [[ ${plugin_num} == "4" ]]; then
        sed '/^}/i\    "plugin":"gq-server",\n    "plugin_opts":"'"WebServerAddr=${gqwebaddr};Key=${gqkey}"'"' -i ${SHADOWSOCKS_LIBEV_CONFIG}
    elif [[ ${plugin_num} == "5" ]]; then
        sed '/^}/i\    "plugin":"ck-server",\n    "plugin_opts":"'"WebServerAddr=${ckwebaddr};PrivateKey=${ckpv};AdminUID=${ckauid};DatabasePath=${ckdbp}/userinfo.db;BackupDirPath=${ckdbp}/db-backup"'"' -i ${SHADOWSOCKS_LIBEV_CONFIG}
        
        # write ck-client config
        if [ ! -d "$(dirname ${CK_CLIENT_CONFIG})" ]; then
            mkdir -p $(dirname ${CK_CLIENT_CONFIG})
        fi
        cat > ${CK_CLIENT_CONFIG}<<-EOF
{
    "UID":"${ckauid}",
    "PublicKey":"${ckpub}",
    "ServerName":"${domain}",
    "TicketTimeHint":3600,
    "NumConn":4,
    "MaskBrowser":"chrome"
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
        tar xf ${MBEDTLS_FILE}-gpl.tgz
        cd ${MBEDTLS_FILE}
        echo -e "${Info} 编译安装${MBEDTLS_FILE}..."
        make SHARED=1 CFLAGS=-fPIC
        make DESTDIR=/usr install
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
        
    
    if [[ ${libev_v2ray} == "4" ]]; then
        wget -qO- https://git.io/fjuAR | bash -s install
    elif [[ ${libev_v2ray} == "5" ]]; then
        wget -qO- https://git.io/fjuAR | bash -s install tls.dns.cloudflare
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

install_goquiet(){
    cd ${CUR_DIR}
    chmod +x ${goquiet_file}
    mv ${goquiet_file} /usr/local/bin/gq-server
    if [ $? -eq 0 ]; then
        echo -e "${Info} GoQuiet安装成功."
    else
        echo
        echo -e "${Error} GoQuiet安装失败."
        echo
        install_cleanup
        exit 1
    fi
}

install_cloak(){
    cd ${CUR_DIR}
    chmod +x ${cloak_file}
    mv ${cloak_file} /usr/local/bin/ck-server
    if [ $? -eq 0 ]; then
        echo -e "${Info} Cloak安装成功."
    else
        echo
        echo -e "${Error} Cloak安装失败."
        echo
        install_cleanup
        exit 1
    fi
}

qr_generate_libev(){
    local link_head="ss://"
    local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
    local ip_port_plugin="@$(get_ip):${shadowsocksport}/?plugin=${plugin_client_name}"
    
    if [[ ${plugin_num} == "1" ]]; then
        if [[ ${libev_v2ray} == "1" ]]; then
            local plugin_opts=""
            ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
            
        elif [[ ${libev_v2ray} == "2" ]]; then
            local plugin_opts=$(get_str_replace ";tls;host=${domain}")
            ip_port_plugin="@${domain}:${shadowsocksport}/?plugin=${plugin_client_name}"
            ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
            
        elif [[ ${libev_v2ray} == "3" ]]; then
            local plugin_opts=$(get_str_replace ";mode=quic;host=${domain}")
            ip_port_plugin="@${domain}:${shadowsocksport}/?plugin=${plugin_client_name}"
            ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
        elif [[ (${libev_v2ray} == "4") || (${libev_v2ray} == "5") ]]; then
            local plugin_opts=$(get_str_replace ";tls;host=${domain};path=${path};loglevel=none")
            ip_port_plugin="@${domain}:443/?plugin=${plugin_client_name}"
            ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
        fi
        
    elif [[ ${plugin_num} == "2" ]]; then
        local plugin_opts=$(get_str_replace ";crypt=${crypt};key=${key};mtu=${MTU};sndwnd=${sndwnd};rcvwnd=${rcvwnd};mode=${mode};datashard=${datashard};parityshard=${parityshard};dscp=${DSCP}")
        ip_port_plugin="@$(get_ip):${listen_port}/?plugin=${plugin_client_name}"
        ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
        
    elif [[ ${plugin_num} == "3" ]]; then
        local plugin_opts=$(get_str_replace ";obfs=${shadowsocklibev_obfs}")
        ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
        
    elif [[ ${plugin_num} == "4" ]]; then
        local plugin_opts=$(get_str_replace ";ServerName=${domain};Key=${gqkey};TicketTimeHint=3600;Browser=chrome")
        ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
        
    elif [[ ${plugin_num} == "5" ]]; then
        local plugin_opts=$(get_str_replace ";UID=${ckauid};PublicKey=${ckpub};ServerName=${domain};TicketTimeHint=3600;NumConn=4;MaskBrowser=chrome")
        ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
        
    else
        local tmp=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}@$(get_ip):${shadowsocksport}")
        ss_link="ss://${tmp}"
    fi
    
}

install_completed_libev(){
    ldconfig
    ${SHADOWSOCKS_LIBEV_INIT} start > /dev/null 2>&1
    
    clear -x
    echo >> ${HUMAN_CONFIG}
    echo -e " Shadowsocks的配置信息：" >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    
    # server ip
    if [[ ${libev_v2ray} == "2" || ${libev_v2ray} == "3" || ${libev_v2ray} == "4" || ${libev_v2ray} == "5" ]]; then
        echo -e " 地址     : ${Red}${domain}${suffix}" >> ${HUMAN_CONFIG}  
    else
        echo -e " 地址     : ${Red}$(get_ip)${suffix}" >> ${HUMAN_CONFIG}  
    fi
    
    # server port
    if [ "$(command -v kcptun-server)" ]; then
        echo -e " 端口     : ${Red}${listen_port}${suffix}" >> ${HUMAN_CONFIG}
    elif [[ ${libev_v2ray} == "4" || ${libev_v2ray} == "5" ]]; then
        echo -e " 端口     : ${Red}443${suffix}" >> ${HUMAN_CONFIG}
    else
        echo -e " 端口     : ${Red}${shadowsocksport}${suffix}" >> ${HUMAN_CONFIG}
    fi
    
    echo -e " 密码     : ${Red}${shadowsockspwd}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 加密     : ${Red}${shadowsockscipher}${suffix}" >> ${HUMAN_CONFIG}
    
    if [ "${plugin_num}" == "1" ]; then
        if [ "$(command -v v2ray-plugin)" ]; then
            echo -e " 插件程序 : ${Red}${plugin_client_name}${suffix}" >> ${HUMAN_CONFIG}
            if [[ ${libev_v2ray} == "1" ]]; then
                echo -e " 插件选项 :                                                      " >> ${HUMAN_CONFIG}
            elif [[ ${libev_v2ray} == "2" ]]; then
                echo -e " 插件选项 : ${Red}tls;host=${domain}${suffix}" >> ${HUMAN_CONFIG}
            elif [[ ${libev_v2ray} == "3" ]]; then
                echo -e " 插件选项 : ${Red}mode=quic;host=${domain}${suffix}" >> ${HUMAN_CONFIG}
            elif [[ ${libev_v2ray} == "4" || ${libev_v2ray} == "5" ]]; then
                export CLOUDFLARE_EMAIL="${CF_Email}"
                export CLOUDFLARE_API_KEY="${CF_Key}"
                /etc/init.d/caddy start > /dev/null 2>&1
                echo -e " 插件选项 : ${Red}tls;host=${domain};path=${path};loglevel=none${suffix}" >> ${HUMAN_CONFIG}
            fi
            if ${fast_open}; then
                echo -e " 插件参数 : ${Red}fast-open=${fast_open}${suffix}" >> ${HUMAN_CONFIG}
            else
                echo -e " 插件参数 :                                                                     " >> ${HUMAN_CONFIG}
            fi
            echo >> ${HUMAN_CONFIG}
            echo -e " SS  链接 : ${Green}${ss_link}${suffix}" >> ${HUMAN_CONFIG}
            echo -e " SS二维码 : ./ss-plugins.sh scan < A link at the beginning of ss:// >" >> ${HUMAN_CONFIG}
            echo >> ${HUMAN_CONFIG}
            echo >> ${HUMAN_CONFIG}
            echo -e " ${Tip} SS链接${Red}不支持插件参数${suffix}导入，请手动填写。使用${Red}kcptun${suffix}插件时，该链接仅支持${Red}手机${suffix}导入." >> ${HUMAN_CONFIG}
            echo -e "        插件程序下载：https://github.com/shadowsocks/v2ray-plugin/releases 下载 windows-amd64 版本" >> ${HUMAN_CONFIG}
            echo -e "        请解压将插件重命名为 ${plugin_client_name}.exe 并移动至 SS-Windows 客户端-安装目录的${Red}根目录${suffix}." >> ${HUMAN_CONFIG}
            echo >> ${HUMAN_CONFIG}
        fi
        
    elif [ "${plugin_num}" == "2" ]; then
        ${KCPTUN_INIT} start  > /dev/null 2>&1
        if [ "$(command -v kcptun-server)" ]; then
            echo -e " 插件程序 : ${Red}${plugin_client_name}${suffix}" >> ${HUMAN_CONFIG}
            echo -e " 插件选项 :                                                             " >> ${HUMAN_CONFIG}
            echo -e " 插件参数 : ${Red}-l %SS_LOCAL_HOST%:%SS_LOCAL_PORT% -r %SS_REMOTE_HOST%:%SS_REMOTE_PORT% --crypt ${crypt} --key ${key} --mtu ${MTU} --sndwnd ${sndwnd} --rcvwnd ${rcvwnd} --mode ${mode} --datashard ${datashard} --parityshard ${parityshard} --dscp ${DSCP}${suffix}" >> ${HUMAN_CONFIG}
            echo >> ${HUMAN_CONFIG}
            echo -e " 手机参数 : crypt=${crypt};key=${key};mtu=${MTU};sndwnd=${sndwnd};rcvwnd=${rcvwnd};mode=${mode};datashard=${datashard};parityshard=${parityshard};dscp=${DSCP}" >> ${HUMAN_CONFIG}
            echo >> ${HUMAN_CONFIG}
            echo -e " SS  链接 : ${Green}${ss_link}${suffix}" >> ${HUMAN_CONFIG}
            echo -e " SS二维码 : ./ss-plugins.sh scan < A link at the beginning of ss:// >" >> ${HUMAN_CONFIG}
            echo >> ${HUMAN_CONFIG}
            echo >> ${HUMAN_CONFIG}
            echo -e " ${Tip} SS链接${Red}不支持插件参数${suffix}导入，请手动填写。使用${Red}kcptun${suffix}插件时，该链接仅支持${Red}手机${suffix}导入." >> ${HUMAN_CONFIG}
            echo -e "        插件程序下载：https://github.com/xtaci/kcptun/releases 下载 windows-amd64 版本." >> ${HUMAN_CONFIG}
            echo -e "        请解压将带client字样的文件重命名为 ${plugin_client_name}.exe 并移至 SS-Windows 客户端-安装目录的${Red}根目录${suffix}." >> ${HUMAN_CONFIG}
            echo >> ${HUMAN_CONFIG}
        fi 
        
    elif [ "${plugin_num}" == "3" ]; then
        if [ "$(command -v obfs-server)" ]; then
            echo -e " 插件程序 : ${Red}${plugin_client_name}${suffix}" >> ${HUMAN_CONFIG}
            echo -e " 插件选项 : ${Red}obfs=${shadowsocklibev_obfs}${suffix}" >> ${HUMAN_CONFIG}
            
            if ${fast_open}; then
                echo -e " 插件参数 : ${Red}obfs-host=${domain};fast-open=${fast_open}${suffix}" >> ${HUMAN_CONFIG}
            else
                echo -e " 插件参数 : ${Red}obfs-host=${domain}${suffix}" >> ${HUMAN_CONFIG}
            fi
            echo >> ${HUMAN_CONFIG}
            echo -e " SS  链接 : ${Green}${ss_link}${suffix}" >> ${HUMAN_CONFIG}
            echo -e " SS二维码 : ./ss-plugins.sh scan < A link at the beginning of ss:// >" >> ${HUMAN_CONFIG}
            echo >> ${HUMAN_CONFIG}
            echo >> ${HUMAN_CONFIG}
            echo -e " ${Tip} SS链接${Red}不支持插件参数${suffix}导入，请手动填写。使用${Red}kcptun${suffix}插件时，该链接仅支持${Red}手机${suffix}导入." >> ${HUMAN_CONFIG}
            echo -e "        插件程序下载：https://github.com/shadowsocks/simple-obfs/releases 下载obfs-local.zip 版本." >> ${HUMAN_CONFIG}
            echo -e "        请将 ${plugin_client_name}.exe 和 libwinpthread-1.dll 两个文件解压至 SS-Windows 客户端-安装目录的${Red}根目录${suffix}." >> ${HUMAN_CONFIG}
            echo >> ${HUMAN_CONFIG}
        fi
        
    elif [ "${plugin_num}" == "4" ]; then
        if [ "$(command -v gq-server)" ]; then
            echo -e " 插件程序 : ${Red}${plugin_client_name}${suffix}" >> ${HUMAN_CONFIG}
            echo -e " 插件选项 : ${Red}ServerName=${domain};Key=${gqkey};TicketTimeHint=3600;Browser=chrome${suffix}" >> ${HUMAN_CONFIG}
            
            if ${fast_open}; then
                echo -e " 插件参数 : ${Red}fast-open=${fast_open}${suffix}" >> ${HUMAN_CONFIG}
            else
                echo -e " 插件参数 : ${Red}${suffix}" >> ${HUMAN_CONFIG}
            fi
            echo >> ${HUMAN_CONFIG}
            echo -e " SS  链接 : ${Green}${ss_link}${suffix}" >> ${HUMAN_CONFIG}
            echo -e " SS二维码 : ./ss-plugins.sh scan < A link at the beginning of ss:// >" >> ${HUMAN_CONFIG}
            echo >> ${HUMAN_CONFIG}
            echo >> ${HUMAN_CONFIG}
            echo -e " ${Tip} SS链接${Red}不支持插件参数${suffix}导入，请手动填写。使用${Red}kcptun${suffix}插件时，该链接仅支持${Red}手机${suffix}导入." >> ${HUMAN_CONFIG}
            echo -e "        插件程序下载：https://github.com/cbeuw/GoQuiet/releases 下载windows-amd64版本" >> ${HUMAN_CONFIG}
            echo -e "        请解压将带client字样的文件重命名为 ${plugin_client_name}.exe 并移动至 SS-Windows 客户端-安装目录的${Red}根目录${suffix}." >> ${HUMAN_CONFIG}
            echo >> ${HUMAN_CONFIG}
            echo -e " ${Tip} 插件选项 ServerName 字段，域名用的是默认值，如果你前面填写的是其它的ip:port 这里请换成ip对应的域名." >> ${HUMAN_CONFIG}
            echo >> ${HUMAN_CONFIG}
        fi 
        
    elif [ "${plugin_num}" == "5" ]; then
        if [ "$(command -v ck-server)" ]; then
            echo -e " 插件程序 : ${Red}${plugin_client_name}${suffix}" >> ${HUMAN_CONFIG}
            echo -e " 插件选项 : ${Red}UID=${ckauid};PublicKey=${ckpub};ServerName=${domain};TicketTimeHint=3600;NumConn=4;MaskBrowser=chrome${suffix}" >> ${HUMAN_CONFIG}
            if ${fast_open}; then
                echo -e " 插件参数 : ${Red}fast-open=${fast_open}${suffix}" >> ${HUMAN_CONFIG}
            else
                echo -e " 插件参数 :                                      " >> ${HUMAN_CONFIG}
            fi
            echo >> ${HUMAN_CONFIG}
            echo -e " AdminUID : ${ckauid}" >> ${HUMAN_CONFIG}
            echo -e " CK  公钥 : ${ckpub}" >> ${HUMAN_CONFIG}
            echo -e " CK  私钥 : ${ckpv}" >> ${HUMAN_CONFIG}
            echo >> ${HUMAN_CONFIG}
            echo -e " SS  链接 : ${Green}${ss_link}${suffix}" >> ${HUMAN_CONFIG}
            echo -e " SS二维码 : ./ss-plugins.sh scan < A link at the beginning of ss:// >" >> ${HUMAN_CONFIG}
            echo >> ${HUMAN_CONFIG}
            echo >> ${HUMAN_CONFIG}
            echo -e " ${Tip} SS链接${Red}不支持插件参数${suffix}导入，请手动填写。使用${Red}kcptun${suffix}插件时，该链接仅支持${Red}手机${suffix}导入." >> ${HUMAN_CONFIG}
            echo -e "        插件程序下载：https://github.com/cbeuw/Cloak/releases 下载windows-amd64版本" >> ${HUMAN_CONFIG}
            echo -e "        请解压将带client字样的文件重命名为 ${plugin_client_name}.exe 并移动至 SS-Windows 客户端-安装目录的${Red}根目录${suffix}." >> ${HUMAN_CONFIG}
            echo >> ${HUMAN_CONFIG}
            echo -e " ${Tip} 插件选项 ServerName 字段，域名用的是默认值，如果你前面填写的是其它的ip:port 这里请换成ip对应的域名." >> ${HUMAN_CONFIG}
            echo -e "        另外，你可以使用 ck-client -a -c <path-to-ckclient.json> 进入admin 模式，根据提示添加新用户." >> ${HUMAN_CONFIG}
            echo >> ${HUMAN_CONFIG}
        fi
        
    else
        echo  >> ${HUMAN_CONFIG}
        echo -e " SS  链接 : ${Green}${ss_link}${suffix}" >> ${HUMAN_CONFIG}
        echo -e " SS二维码 : ./ss-plugins.sh scan < A link at the beginning of ss:// >" >> ${HUMAN_CONFIG}
        echo >> ${HUMAN_CONFIG}
    fi
}

install_bbr(){
    download ${BBR_SHELL_FILE} ${BBR_SCRIPT_URL}
    chmod +x ${BBR_SHELL_FILE}
    ./$(basename ${BBR_SHELL_FILE})
    rm -f ${BBR_SHELL_FILE}
    rm -f $(dirname ${BBR_SHELL_FILE})/install_bbr.log
    
}

install_main(){
    install_libsodium
    if ! ldconfig -p | grep -wq "/usr/lib"; then
        echo "/usr/lib" > /etc/ld.so.conf.d/lib.conf
    fi
    ldconfig
    install_mbedtls
    install_shadowsocks_libev
    if [ "${plugin_num}" == "1" ]; then
        install_v2ray_plugin
        plugin_client_name="v2ray"
    elif [ "${plugin_num}" == "2" ]; then
        install_kcptun
        plugin_client_name="kcptun"
    elif [ "${plugin_num}" == "3" ]; then
        install_simple_obfs
        plugin_client_name="obfs-local"
    elif [ "${plugin_num}" == "4" ]; then
        install_goquiet
        plugin_client_name="gq-client"
    elif [ "${plugin_num}" == "5" ]; then
        install_cloak
        gen_credentials
        plugin_client_name="ck-client"
        
    fi
}

install_step_full(){
    [[ -e '/usr/local/bin/ss-server' ]] && echo -e "${Info} Shadowsocks-libev 已经安装..." && exit 1
    disable_selinux
    install_prepare
    install_dependencies
    download_files
    if check_sys packageManager yum; then
        config_firewall
    fi
    install_main
    install_cleanup
    config_shadowsocks
    qr_generate_libev
    install_completed_libev
    config_show
}

install_cleanup(){
    cd ${CUR_DIR}
    rm -rf simple-obfs
    rm -rf ${goquiet_file}
    rm -rf ${cloak_file}
    rm -rf ${LIBSODIUM_FILE} ${LIBSODIUM_FILE}.tar.gz
    rm -rf ${MBEDTLS_FILE} ${MBEDTLS_FILE}-gpl.tgz
    rm -rf ${shadowsocks_libev_file} ${shadowsocks_libev_file}.tar.gz
    rm -rf client_linux_amd64 server_linux_amd64 ${kcptun_file}.tar.gz 
    rm -rf v2ray-plugin_linux_amd64 ${v2ray_plugin_file}.tar.gz

}

do_start(){
    if [ "$(command -v ss-server)" ]; then
        ${SHADOWSOCKS_LIBEV_INIT} start
        if [ "$(command -v kcptun-server)" ]; then
            ${KCPTUN_INIT} start
        elif [ "$(command -v caddy)" ]; then
            /etc/init.d/caddy start
        fi
    else
        echo
        echo -e " ${Red} Shadowsocks-libev 未安装，请尝试安装后，再来执行此操作。${suffix}"
        echo
    fi  
}

do_stop(){
    # kill v2ray-plugin 、obfs-server、gq-server ck-server
    ps -ef |grep -v grep | grep ss-server |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1
    ps -ef |grep -v grep | grep v2ray-plugin |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1
    ps -ef |grep -v grep | grep kcptun-server |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1
    ps -ef |grep -v grep | grep obfs-server |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1
    ps -ef |grep -v grep | grep gq-server |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1
    ps -ef |grep -v grep | grep ck-server |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1
    ps -ef |grep -v grep | grep caddy |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1
    echo
    echo -e " Stopping Shadowsocks-libev success"
    echo
}

do_restart(){
    do_stop
    do_start
}

# install status
do_status(){
    if [[ -e '/usr/local/bin/ss-server' ]]; then
        check_pid
        if [[ ! -z "${PID}" ]]; then
            echo -e " 当前状态: ${Green}已安装${suffix} 并 ${Green}已启动${suffix}"
        else
            echo -e " 当前状态: ${Green}已安装${suffix} 但 ${Red}未启动${suffix}"
        fi
    else
        echo -e " 当前状态: ${Red}未安装${suffix}"
    fi
}

config_show(){
    if [ -e $HUMAN_CONFIG ]; then
        clear -x
        cat $HUMAN_CONFIG
    else
        echo "The visual configuration was not found..."
    fi
}

gen_qr_code_manual(){
    local ss_url=$1
    
    if [[ $(echo "${ss_url}" | grep "^ss://") ]]; then
        if [ "$(command -v qrencode)" ]; then
            echo
            echo -e "生成二维码如下："
            echo
            qrencode -m 2 -l L -t ANSIUTF8 -k "${ss_url}"
            echo
            echo -e " ${Tip} 扫码后请仔细检查配置是否正确，如若存在差异请自行手动调整..."
            echo
        else
            echo
            echo -e " ${Error} 手动生成二维码失败，请确认qrencode是否正常安装..."
            echo
        fi
    else
        echo -e "
 Usage:
    ./ss-plugins.sh scan <a ss url>"
        echo
        echo -e " ${Error} 仅支持生成ss:// 开头的链接，请确认使用方式和要生成的链接是否正确..."
        echo
        exit 1
    fi
}

add_a_new_uid(){
    if [[ -e '/usr/local/bin/ck-server' ]]; then
    
        if [[ ! -e '/usr/local/bin/ck-client' ]]; then
            get_ver
            # Download cloak client
            local cloak_file="ck-client-linux-amd64-${cloak_ver}"
            local cloak_url="https://github.com/cbeuw/Cloak/releases/download/v${cloak_ver}/ck-client-linux-amd64-${cloak_ver}"
            download "${cloak_file}" "${cloak_url}"
            
            # install ck-client
            cd ${CUR_DIR}
            chmod +x ${cloak_file}
            mv ${cloak_file} /usr/local/bin/ck-client
        fi
        
        # get parameter from ss config.json
        gen_credentials
        local new_uid=${ckauid}
        local ip=$(get_ip)
        local port=443
        local admin_uid=$(cat ${SHADOWSOCKS_LIBEV_CONFIG} | grep -o -P "AdminUID=.*?;" | sed 's/AdminUID=//g;s/;//g')

        # show about info
        echo
        echo -e " ${Green}UID  (新)${suffix}：${Red}${new_uid}${suffix}"
        echo
        echo -e " ${Green}IP (端口)${suffix}：${Red}${ip}:${port}${suffix}"
        echo -e " ${Green}UID(管理)${suffix}：${Red}${admin_uid}${suffix}"
        echo
        echo -e "
 添加新用户：
    1. ck-server -u 生成一个New 的 UID
    2. ck-client -a -c <path-to-ckclient.json> 进入admin 模式。
    3. 输入，服务器ip:port 和 AdminUID ，选择4 ，新建一个用户。
    4. 根据提示输入如下：
        1. Newly generated UID      # 输入上方新生成的 UID
        2. SessionsCap              # 用户可以拥有的最大并发会话数(填写 4)
        3. UpRate                   # 上行速度 (单位：bytes/s)
        4. DownRate                 # 下行速度 (单位：bytes/s)
        5. UpCredit                 # 上行限制 (单位：bytes)
        6. DownCredit               # 下行限制 (单位：bytes)
        7. ExpiryTime               # user账号的有效期，unix时间格式(10位时间戳)
    5. 将你的 公钥 和 新生成的UID 给这个新用户。
    
 ${Tip} 下方输入从第3步开始，根据提示输入，退出请按 Ctrl + C ...
 
 "
        
        # Enter admin mode
        ck-client -a -c ${CK_CLIENT_CONFIG}
    else
        echo
        echo -e " ${Error} 仅支持 ss + cloak 下使用，请确认是否是以该组合形式运行..."
        echo
        exit 1
    fi
}

get_new_ck_ssurl(){
    local ckauid=$1
    if [[ -n ${ckauid} ]]; then
        if [[ -e '/usr/local/bin/ck-client' ]]; then
            local shadowsockscipher=$(cat ${SHADOWSOCKS_LIBEV_CONFIG} | grep -o -P "method\":\".*?\"" | sed 's/method\":\"//g;s/\"//g')
            local shadowsockspwd=$(cat ${SHADOWSOCKS_LIBEV_CONFIG} | grep -o -P "password\":\".*?\"" | sed 's/password\":\"//g;s/\"//g')
            local shadowsocksport=$(cat ${SHADOWSOCKS_LIBEV_CONFIG} | grep -o -P "server_port\":.*?\," | sed 's/server_port\"://g;s/\,//g')
            local ckpub=$(cat ${CK_CLIENT_CONFIG} | grep -o -P "PublicKey\":\".*?\"" | sed 's/PublicKey\":\"//g;s/\"//g')
            local ckservername=$(cat /etc/cloak/ckclient.json | grep -o -P "ServerName\":\".*?\"" | sed 's/ServerName\":\"//g;s/\"//g')
            
            local link_head="ss://"
            local cipher_pwd=$(get_str_base64_encode "${shadowsockscipher}:${shadowsockspwd}")
            local ip_port_plugin="@$(get_ip):${shadowsocksport}/?plugin=ck-client"
            local plugin_opts=$(get_str_replace ";UID=${ckauid};PublicKey=${ckpub};ServerName=${ckservername};TicketTimeHint=3600;NumConn=4;MaskBrowser=chrome")

            local ss_link="${link_head}${cipher_pwd}${ip_port_plugin}${plugin_opts}"
            
            echo
            echo -e " ${Green}生成的新用户SS链接：${suffix}"
            echo -e "    ${Red}${ss_link}${suffix}"
            echo
        fi
    else
        echo -e "
 Usage:
    ./ss-plugins.sh url <new add user uid>"
        echo
        echo -e " ${Error} 仅支持 ss + cloak 下使用，请确认是否是以该组合形式运行，并且，使用 ./ss-plugins.sh url 添加过新用户..."
        echo
        exit 1
    fi
}

do_update(){
    if [[ -e '/usr/local/bin/ss-server' ]]; then
        if check_ss_libev_version; then
            do_stop > /dev/null 2>&1
            download_files
            install_shadowsocks_libev
            install_cleanup
            do_restart > /dev/null 2>&1
            echo
            echo -e "${Point} shadowsocklibev-libev升级为 ${latest_ver}最新版本，并已重启运行..."
            echo
        else
            echo
            echo -e "${Point} shadowsocklibev-libev当前已是最新版本 ${curr_ver}，不需要更新..."
            echo
            exit 1
        fi
    fi
    
}

do_uninstall(){
    printf "你确定要卸载Shadowsocks-libev吗? [y/n]\n"
    read -e -p "(默认: n):" answer
    [ -z ${answer} ] && answer="n"
    if [ "${answer}" == "y" ] || [ "${answer}" == "Y" ]; then
        # check Shadowsocks-libev status
        ${SHADOWSOCKS_LIBEV_INIT} status > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            ${SHADOWSOCKS_LIBEV_INIT} stop > /dev/null 2>&1
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
            ${KCPTUN_INIT} stop > /dev/null 2>&1
        fi
        local kcp_service_name=$(basename ${KCPTUN_INIT})
        if check_sys packageManager yum; then
            chkconfig --del ${kcp_service_name}
        elif check_sys packageManager apt; then
            update-rc.d -f ${kcp_service_name} remove
        fi
        
        # kill v2ray-plugin 、obfs-server、gq-server ck-server
        ps -ef |grep -v grep | grep v2ray-plugin |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1
        ps -ef |grep -v grep | grep obfs-server |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1
        ps -ef |grep -v grep | grep gq-server |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1
        ps -ef |grep -v grep | grep ck-server |awk '{print $2}' | xargs kill -9 > /dev/null 2>&1
        
        # uninstall acme.sh
        # ~/.acme.sh/acme.sh --uninstall > /dev/null 2>&1 && rm -rf ~/.acme.sh
        
        # uninstall caddy
        wget -qO- https://git.io/fjuAR | bash -s uninstall > /dev/null 2>&1
        
        rm -fr $(dirname ${SHADOWSOCKS_LIBEV_CONFIG})
        rm -f /usr/local/bin/ss-local
        rm -f /usr/local/bin/ss-tunnel
        rm -f /usr/local/bin/ss-server
        rm -f /usr/local/bin/ss-manager
        rm -f /usr/local/bin/ss-redir
        rm -f /usr/local/bin/ss-nat
        rm -f /usr/local/bin/v2ray-plugin
        rm -f /usr/local/bin/gq-server
        rm -f /usr/local/bin/ck-server
        rm -f /usr/local/bin/ck-client
        rm -fr $(dirname ${CK_CLIENT_CONFIG}) > /dev/null 2>&1
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
        rm -fr $(dirname ${KCPTUN_INSTALL_DIR}) > /dev/null 2>&1
        rm -fr $(dirname ${KCPTUN_CONFIG}) > /dev/null 2>&1
        rm -fr ${KCPTUN_LOG_DIR}
        rm -f ${KCPTUN_INIT}

        echo -e "${Info} Shadowsocks-libev 卸载成功..."
    else
        echo
        echo -e "${Info} Shadowsocks-libev 卸载取消..."
        echo
    fi
}


do_install(){
    # check supported
    if ! install_check; then
        echo -e "[${red}Error${plain}] Your OS is not supported to run it!"
        echo "Please change to CentOS 6+/Debian 7+/Ubuntu 12+ and try again."
        exit 1
    fi
    
    echo -e " Shadowsocks-libev一键管理脚本 ${Red}[v${SHELL_VERSION}]${suffix}

    ${Green}1.${suffix} BBR
    ${Green}2.${suffix} Install
    ${Green}3.${suffix} Uninstall
     "
    do_status
    echo && read -e -p "请输入数字 [1-3]：" menu_num
    case "${menu_num}" in
        1)
            install_bbr
            ;;
        2)
            install_step_full
            ;;
        3)
            do_uninstall
            ;;
        *)
            echo -e "${Error} 请输入正确的数字 [1-3]"
            ;;
    esac
}



action=${1:-"install"}
case ${action} in
    install|uninstall|update|start|stop|restart|status)
        do_${action}
        ;;
    uid)
        add_a_new_${action}
        ;;
    url)
        get_new_ck_ss${action} "${2}"
        ;;
    scan)
        gen_qr_code_manual "${2}"
        ;;
    show)
        config_${action}
        ;;
    help)
        usage 0
        ;;
    *)
        usage 1
        ;;
esac