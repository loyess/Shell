#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH



# shell version
# ====================
SHELL_VERSION="2.0.0"
# ====================


# current path
CUR_DIR=$( pwd )


BASE_URL="https://github.com/loyess/Shell/raw/master"
# BASE_URL="https://github.com/loyess/Shell/raw/test"


# bbr
BBR_SCRIPT_URL="https://git.io/vbUk0"


# Humanization config PATH
HUMAN_CONFIG="/etc/shadowsocks-libev/human-config"


# shadowsocklibev-libev config and init
SHADOWSOCKS_LIBEV_INSTALL_PATH="/usr/local/bin"
SHADOWSOCKS_LIBEV_INIT="/etc/init.d/shadowsocks-libev"
SHADOWSOCKS_LIBEV_CONFIG="/etc/shadowsocks-libev/config.json"
SHADOWSOCKS_LIBEV_CENTOS="${BASE_URL}/service/shadowsocks_libev_centos.sh"
SHADOWSOCKS_LIBEV_DEBIAN="${BASE_URL}/service/shadowsocks-libev_debian.sh"


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
KCPTUN_CENTOS="${BASE_URL}/service/kcptun_centos.sh"
KCPTUN_DEBIAN="${BASE_URL}/service/kcptun_debian.sh"


# cloak
CK_DB_PATH="/etc/cloak/db"
CK_CLIENT_CONFIG="/etc/cloak/ckclient.json"


# caddy
CADDY_CONF_FILE="/usr/local/caddy/Caddyfile"
CADDY_INSTALL_SCRIPT_URL="https://git.io/fjuAR"


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

  请使用: ./ss-plugins.sh [option] [args]

    可使用的参数 <option> 包括:

        install          安装
        uninstall        卸载
        update           升级
        start            启动
        stop             关闭
        restart          重启
        status           查看状态
        show             显示可视化配置
        uid              添加一个新用户 (仅ss + cloak下可用)
        link             生成一个新的SS:// 链接 (仅ss + cloak下可用)
        scan             根据生成的ss:// 链接，在当前终端上，手动生成一个可供扫描的二维码
        help             查看脚本使用说明
        
	EOF

	exit $1
}

disable_selinux(){
    if [ -s /etc/selinux/config ] && grep 'SELINUX=enforcing' /etc/selinux/config; then
        sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
        setenforce 0
    fi
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

config_ss(){

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

    # start wriet config
    source <(curl -sL ${BASE_URL}/templates/write_config.sh)
    
    if [[ ${plugin_num} == "1" ]]; then
        if [[ ${libev_v2ray} == "1" ]]; then
           ss_v2ray_ws_http_config
        elif [[ ${libev_v2ray} == "2" ]]; then    
           ss_v2ray_ws_tls_cdn_config
        elif [[ ${libev_v2ray} == "3" ]]; then
            ss_v2ray_quic_tls_cdn_config
        elif [[ ${libev_v2ray} == "4" ]]; then
            ss_v2ray_ws_tls_web_config
            caddy_config_none_cdn    
        elif [[ ${libev_v2ray} == "5" ]]; then
            ss_v2ray_ws_tls_web_cdn_config
            caddy_config_with_cdn
        fi
    elif [[ ${plugin_num} == "2" ]]; then
        if [ ! -d "$(dirname ${KCPTUN_CONFIG})" ]; then
            mkdir -p $(dirname ${KCPTUN_CONFIG})
        fi
        
        ss_config_standalone
        kcptun_config_standalone
    elif [[ ${plugin_num} == "3" ]]; then
        if [[ ${libev_obfs} == "1" ]]; then
           ss_obfs_http_config
        elif [[ ${libev_obfs} == "2" ]]; then    
           ss_obfs_tls_config
        fi
    elif [[ ${plugin_num} == "4" ]]; then
        ss_goquiet_config
    elif [[ ${plugin_num} == "5" ]]; then
        ss_cloak_server_config
        
        if [ ! -d "$(dirname ${CK_CLIENT_CONFIG})" ]; then
            mkdir -p $(dirname ${CK_CLIENT_CONFIG})
        fi
        ss_cloak_client_config
    else
        ss_config_standalone
    fi
}

gen_ss_links(){
    source <(curl -sL ${BASE_URL}/templates/group_sslink.sh)
    if [[ ${plugin_num} == "1" ]]; then
        if [[ ${libev_v2ray} == "1" ]]; then
            ss_v2ray_ws_http_link
        elif [[ ${libev_v2ray} == "2" ]]; then
            ss_v2ray_ws_tls_cdn_link
        elif [[ ${libev_v2ray} == "3" ]]; then
            ss_v2ray_quic_tls_cdn_link
        elif [[ ${libev_v2ray} == "4" ]]; then
            ss_v2ray_ws_tls_web_link
        elif [[ ${libev_v2ray} == "5" ]]; then
            ss_v2ray_ws_tls_web_cdn_link
        fi
    elif [[ ${plugin_num} == "2" ]]; then
        ss_kcptun_link
    elif [[ ${plugin_num} == "3" ]]; then
        if [[ ${libev_obfs} == "1" ]]; then
           ss_obfs_http_link
        elif [[ ${libev_obfs} == "2" ]]; then    
           ss_obfs_tls_link
        fi
    elif [[ ${plugin_num} == "4" ]]; then
        ss_goquiet_link
    elif [[ ${plugin_num} == "5" ]]; then
        ss_cloak_link
    else
        ss_link
    fi
}

install_completed(){
    ldconfig
    ${SHADOWSOCKS_LIBEV_INIT} start > /dev/null 2>&1
    
    source <(curl -sL ${BASE_URL}/templates/show_config.sh)
    clear -x
    if [[ ${plugin_num} == "1" ]]; then
        if [[ ${libev_v2ray} == "1" ]]; then
            ss_v2ray_ws_http_show
        elif [[ ${libev_v2ray} == "2" ]]; then
            ss_v2ray_ws_tls_cdn_show
        elif [[ ${libev_v2ray} == "3" ]]; then
            ss_v2ray_quic_tls_cdn_show
        elif [[ ${libev_v2ray} == "4" ]]; then
            # start caddy
            /etc/init.d/caddy start > /dev/null 2>&1
            
            ss_v2ray_ws_tls_web_show
        elif [[ ${libev_v2ray} == "5" ]]; then
            # cloudflare email & api key
            export CLOUDFLARE_EMAIL="${CF_Email}"
            export CLOUDFLARE_API_KEY="${CF_Key}"
            
            # start caddy
            /etc/init.d/caddy start > /dev/null 2>&1
            
            ss_v2ray_ws_tls_web_cdn_show
        fi
    elif [[ ${plugin_num} == "2" ]]; then
        # start kcptun
        ${KCPTUN_INIT} start  > /dev/null 2>&1
        
        ss_kcptun_show
    elif [[ ${plugin_num} == "3" ]]; then
        if [[ ${libev_obfs} == "1" ]]; then
           ss_obfs_http_show
        elif [[ ${libev_obfs} == "2" ]]; then    
           ss_obfs_tls_show
        fi
    elif [[ ${plugin_num} == "4" ]]; then
        ss_goquiet_show
    elif [[ ${plugin_num} == "5" ]]; then
        ss_cloak_show
    else
        ss_show
    fi
}

install_prepare(){
    source <(curl -sL ${BASE_URL}/prepare/ss_libev_prepare.sh)
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
        source <(curl -sL ${BASE_URL}/prepare/v2p_prepare.sh)
        install_prepare_libev_v2ray
    elif [[ ${plugin_num} == "2" ]]; then
        source <(curl -sL ${BASE_URL}/prepare/kp_prepare.sh)
        install_prepare_libev_kcptun
    elif [[ ${plugin_num} == "3" ]]; then
        source <(curl -sL ${BASE_URL}/prepare/obfs_prepare.sh)
        install_prepare_libev_obfs
    elif [[ ${plugin_num} == "4" ]]; then
        source <(curl -sL ${BASE_URL}/prepare/gq_prepare.sh)
        install_prepare_libev_goquiet
    elif [[ ${plugin_num} == "5" ]]; then
        source <(curl -sL ${BASE_URL}/prepare/ck_prepare.sh)
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

install_main(){
    install_libsodium
    if ! ldconfig -p | grep -wq "/usr/lib"; then
        echo "/usr/lib" > /etc/ld.so.conf.d/lib.conf
    fi
    ldconfig
    install_mbedtls
    source <(curl -sL ${BASE_URL}/tools/shadowsocks_libev_install.sh)
    install_shadowsocks_libev
    if [ "${plugin_num}" == "1" ]; then
        source <(curl -sL ${BASE_URL}/plugins/v2ray_plugin_install.sh)
        install_v2ray_plugin
        plugin_client_name="v2ray"
    elif [ "${plugin_num}" == "2" ]; then
        source <(curl -sL ${BASE_URL}/plugins/kcptun_install.sh)
        install_kcptun
        plugin_client_name="kcptun"
    elif [ "${plugin_num}" == "3" ]; then
        source <(curl -sL ${BASE_URL}/plugins/simple_obfs_install.sh)
        install_simple_obfs
        plugin_client_name="obfs-local"
    elif [ "${plugin_num}" == "4" ]; then
        source <(curl -sL ${BASE_URL}/plugins/goquiet_install.sh)
        install_goquiet
        plugin_client_name="gq-client"
    elif [ "${plugin_num}" == "5" ]; then
        source <(curl -sL ${BASE_URL}/plugins/cloak_install.sh)
        install_cloak
        gen_credentials
        plugin_client_name="ck-client"
        
    fi
}

install_step_all(){
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
    config_ss
    gen_ss_links
    install_completed
    source <(curl -sL ${BASE_URL}/utils/view_config.sh)
    show_config
}

install_cleanup(){
    cd ${CUR_DIR}
    # ss-libev
    rm -rf ${LIBSODIUM_FILE} ${LIBSODIUM_FILE}.tar.gz
    rm -rf ${MBEDTLS_FILE} ${MBEDTLS_FILE}-gpl.tgz
    rm -rf ${shadowsocks_libev_file} ${shadowsocks_libev_file}.tar.gz
    
    # v2ray-plugin
    rm -rf v2ray-plugin_linux_amd64 ${v2ray_plugin_file}.tar.gz
    
    # kcptun
    rm -rf client_linux_amd64 server_linux_amd64 ${kcptun_file}.tar.gz
    
    # simple-obfs
    rm -rf simple-obfs
    
    # goquiet
    rm -rf ${goquiet_file}
    
    # cloak
    rm -rf ${cloak_file}
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
        
        # uninstall ss-libev
        rm -fr $(dirname ${SHADOWSOCKS_LIBEV_CONFIG})
        rm -f /usr/local/bin/ss-local
        rm -f /usr/local/bin/ss-tunnel
        rm -f /usr/local/bin/ss-server
        rm -f /usr/local/bin/ss-manager
        rm -f /usr/local/bin/ss-redir
        rm -f /usr/local/bin/ss-nat
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
        
        # uninstall v2ray-plugin
        rm -f /usr/local/bin/v2ray-plugin
        
        # uninstall kcptun
        rm -fr $(dirname ${KCPTUN_INSTALL_DIR}) > /dev/null 2>&1
        rm -fr $(dirname ${KCPTUN_CONFIG}) > /dev/null 2>&1
        rm -fr ${KCPTUN_LOG_DIR}
        rm -f ${KCPTUN_INIT}
        
        # uninstall simple-obfs
        rm -f /usr/local/bin/obfs-local
        rm -f /usr/local/bin/obfs-server
        
        # uninstall goquiet
        rm -f /usr/local/bin/gq-server
        
        # uninstall cloak
        rm -f /usr/local/bin/ck-server
        rm -f /usr/local/bin/ck-client
        rm -fr $(dirname ${CK_CLIENT_CONFIG}) > /dev/null 2>&1
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
            source <(curl -sL ${BBR_SCRIPT_URL})
            ;;
        2)
            install_step_all
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
        source <(curl -sL ${BASE_URL}/utils/ck_user_manager.sh)
        add_a_new_uid
        ;;
    link)
        source <(curl -sL ${BASE_URL}/utils/ck_sslink.sh)
        get_new_ck_sslink "${2}"
        ;;
    scan)
        source <(curl -sL ${BASE_URL}/utils/qr_code.sh)
        gen_qr_code "${2}"
        ;;
    show)
        source <(curl -sL ${BASE_URL}/utils/view_config.sh)
        show_config
        ;;
    help)
        usage 0
        ;;
    *)
        usage 1
        ;;
esac