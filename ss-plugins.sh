#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH


# shell version
# ====================
SHELL_VERSION="2.8.0"
# ====================


# current path
CUR_DIR=$( pwd )


# base url
methods="Online"
BASE_URL="https://github.com/loyess/Shell/raw/master"
if [ -e install ] && [ -e prepare ] && [ -e service ] && [ -e templates ] && [ -e utils ] && [ -e webServer ]; then
    methods="Local"
    BASE_URL="${CUR_DIR}" 
fi


# bbr
TEDDYSUN_BBR_SCRIPT_URL="https://git.io/vbUk0"
CHIAKGE_BBR_SCRIPT_URL="https://git.io/vxJ1I"


# Humanization config PATH
HUMAN_CONFIG="/etc/shadowsocks/humanization.conf"


# shadowsocks config
SHADOWSOCKS_CONFIG="/etc/shadowsocks/config.json"

# shadowsocks-libev config and init
SHADOWSOCKS_LIBEV_INSTALL_PATH="/usr/local/bin"
SHADOWSOCKS_LIBEV_BIN_PATH="/usr/local/bin/ss-server"
SHADOWSOCKS_LIBEV_INIT="/etc/init.d/shadowsocks-libev"
SHADOWSOCKS_LIBEV_INIT_LOCAL="./service/shadowsocks-libev.sh"
SHADOWSOCKS_LIBEV_INIT_ONLINE="${BASE_URL}/service/shadowsocks-libev.sh"

# shadowsocks-rust config and init
SHADOWSOCKS_RUST_INSTALL_PATH="/usr/local/bin"
SHADOWSOCKS_RUST_BIN_PATH="/usr/local/bin/ssserver"
SHADOWSOCKS_RUST_INIT="/etc/init.d/shadowsocks-rust"
SHADOWSOCKS_RUST_INIT_LOCAL="./service/shadowsocks-rust.sh"
SHADOWSOCKS_RUST_INIT_ONLINE="${BASE_URL}/service/shadowsocks-rust.sh"

# go-shadowsocks2 config and init
GO_SHADOWSOCKS2_INSTALL_PATH="/usr/local/bin"
GO_SHADOWSOCKS2_BIN_PATH="/usr/local/bin/go-shadowsocks2"
GO_SHADOWSOCKS2_INIT="/etc/init.d/go-shadowsocks2"
GO_SHADOWSOCKS2_INIT_LOCAL="./service/go-shadowsocks2.sh"
GO_SHADOWSOCKS2_INIT_ONLINE="${BASE_URL}/service/go-shadowsocks2.sh"
GO_SHADOWSOCKS2_VERSION_FILE="/etc/shadowsocks/go-shadowsocks2.v"


# v2ray-plugin
V2RAY_PLUGIN_INSTALL_PATH="/usr/local/bin"
V2RAY_PLUGIN_BIN_PATH="/usr/local/bin/v2ray-plugin"


# kcptun
KCPTUN_INSTALL_PATH="/usr/local/kcptun"
KCPTUN_BIN_PATH="/usr/local/kcptun/kcptun-server"
KCPTUN_INIT="/etc/init.d/kcptun"
KCPTUN_CONFIG="/etc/kcptun/config.json"
KCPTUN_INIT_LOCAL="./service/kcptun.sh"
KCPTUN_INIT_ONLINE="${BASE_URL}/service/kcptun.sh"


# simple-obfs
SIMPLE_OBFS_INSTALL_PATH="/usr/local/bin"
SIMPLE_OBFS_BIN_PATH="/usr/local/bin/obfs-server"


# goquiet
GOQUIET_INSTALL_PATH="/usr/local/bin"
GOQUIET_BIN_PATH="/usr/local/bin/gq-server"


# cloak
CLOAK_INSTALL_PATH="/usr/local/bin"
CLOAK_SERVER_BIN_PATH="/usr/local/bin/ck-server"
CLOAK_CLIENT_BIN_PATH="/usr/local/bin/ck-client"
CLOAK_INIT="/etc/init.d/cloak"
CLOAK_INIT_LOCAL="./service/cloak.sh"
CLOAK_INIT_ONLINE="${BASE_URL}/service/cloak.sh"
CK_DB_PATH="/etc/cloak"
CK_CLIENT_CONFIG="/etc/cloak/ckclient.json"
CK_SERVER_CONFIG="/etc/cloak/ckserver.json"


# mos-tls-tunnel
MTT_VERSION_FILE="/etc/shadowsocks/mtt.v"
MTT_INSTALL_PATH="/usr/local/bin"
MTT_BIN_PATH="/usr/local/bin/mtt-server"


# rabbit-tcp
RABBIT_INSTALL_PATH="/usr/local/bin"
RABBIT_BIN_PATH="/usr/local/bin/rabbit-tcp"
RABBIT_INIT="/etc/init.d/rabbit-tcp"
RABBIT_CONFIG="/etc/rabbit-tcp/config.json"
RABBIT_VERSION_FILE="/etc/rabbit-tcp/rabbit-tcp.v"
RABBIT_INIT_LOCAL="./service/rabbit-tcp.sh"
RABBIT_INIT_ONLINE="${BASE_URL}/service/rabbit-tcp.sh"


# simple-tls
SIMPLE_TLS_INSTALL_PATH="/usr/local/bin"
SIMPLE_TLS_BIN_PATH="/usr/local/bin/simple-tls"
SIMPLE_TLS_VERSION_FILE="/etc/shadowsocks/simple-tls.v"


# gost-plugin
GOST_PLUGIN_INSTALL_PATH="/usr/local/bin"
GOST_PLUGIN_BIN_PATH="/usr/local/bin/gost-plugin"
GOST_PLUGIN_VERSION_FILE="/etc/shadowsocks/gost-plugin.v"


# xray-plugin
XRAY_PLUGIN_INSTALL_PATH="/usr/local/bin"
XRAY_PLUGIN_BIN_PATH="/usr/local/bin/xray-plugin"
XRAY_PLUGIN_VERSION_FILE="/etc/shadowsocks/xray-plugin.v"


# qtun
QTUN_INSTALL_PATH="/usr/local/bin"
QTUN_BIN_PATH="/usr/local/bin/qtun-server"
QTUN_VERSION_FILE="/etc/shadowsocks/qtun.v"


# gun
GUN_INSTALL_PATH="/usr/local/bin"
GUN_BIN_PATH="/usr/local/bin/gun-server"
GUN_VERSION_FILE="/etc/shadowsocks/gun.v"


SS_PLUGINS_NAME=(
v2ray-plugin
kcptun
simple-obfs
goquiet
cloak
mos-tls-tunnel
rabbit-tcp
simple-tls
gost-plugin
xray-plugin
qtun
gun
)


# caddy
CADDY_INSTALL_PATH="/usr/local/caddy"
CADDY_BIN_PATH="/usr/local/caddy/caddy"
CADDY_CONF_FILE="/usr/local/caddy/Caddyfile"
CADDY_VERSION_FILE="/usr/local/caddy/caddy.v"
CADDY_INIT="/etc/init.d/caddy"
CADDY_INIT_LOCAL="./service/caddy.sh"
CADDY_INIT_ONLINE="${BASE_URL}/service/caddy.sh"
CADDY_V2_INIT_LOCAL="./service/caddy2.sh"
CADDY_V2_INIT_ONLINE="${BASE_URL}/service/caddy2.sh"


# nginx
NGINX_BIN_PATH="/usr/sbin/nginx"
NGINX_CONFIG="/etc/nginx/nginx.conf"


# RE
EMAIL_RE="^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}$"
DOMAIN_RE="^(www\.)?[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+(:\d+)*(\/\w+\.\w+)*$"
IPV4_RE="^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])$"
IPV4_PORT_RE="^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\:443$"
HTTPS_DOMAIN_RE="^(https:\/\/)?(www\.)?[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+(:\d+)*(\/\w+\.\w+)*$"
IPV6_RE="^\s*((([0-9A-Fa-f]{1,4}:){7}(([0-9A-Fa-f]{1,4})|:))|(([0-9A-Fa-f]{1,4}:){6}(:|((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})|(:[0-9A-Fa-f]{1,4})))|(([0-9A-Fa-f]{1,4}:){5}((:((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})?)|((:[0-9A-Fa-f]{1,4}){1,2})))|(([0-9A-Fa-f]{1,4}:){4}(:[0-9A-Fa-f]{1,4}){0,1}((:((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})?)|((:[0-9A-Fa-f]{1,4}){1,2})))|(([0-9A-Fa-f]{1,4}:){3}(:[0-9A-Fa-f]{1,4}){0,2}((:((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})?)|((:[0-9A-Fa-f]{1,4}){1,2})))|(([0-9A-Fa-f]{1,4}:){2}(:[0-9A-Fa-f]{1,4}){0,3}((:((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})?)|((:[0-9A-Fa-f]{1,4}){1,2})))|(([0-9A-Fa-f]{1,4}:)(:[0-9A-Fa-f]{1,4}){0,4}((:((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})?)|((:[0-9A-Fa-f]{1,4}){1,2})))|(:(:[0-9A-Fa-f]{1,4}){0,5}((:((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})?)|((:[0-9A-Fa-f]{1,4}){1,2})))|(((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})))(%.+)?\s*$"


# Font color and background color
Green="\033[32m" && Red="\033[31m" && Yellow="\033[0;33m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && suffix="\033[0m"
Info="${Green}[信息]${suffix}"
Error="${Red}[错误]${suffix}"
Point="${Red}[提示]${suffix}"
Tip="${Green}[注意]${suffix}"
Warning="${Yellow}[警告]${suffix}"
Separator_1="——————————————————————————————"


# Root permission
[ $EUID -ne 0 ] && echo -e "[${Red}Error${suffix}] This script must be run as root!" && exit 1


usage() {
    echo "Usage:"
    echo "  ./ss-plugins.sh [options...] [args...]"
    echo
    echo "Available Options:"
    echo "  install          安装"
    echo "  uninstall        卸载"
    echo "  update           升级"
    echo "  start            启动"
    echo "  stop             关闭"
    echo "  restart          重启"
    echo "  status           查看状态"
    echo "  script           升级脚本"
    echo "  show             可视化配置"
    echo "  log              查看日志文件"
    echo "  catcfg           查看原始配置文件"
    echo "  uid              添加一个新的uid用户(Cloak)"
    echo "  cert             为.cf .ga .gq .ml .tk申请证书(90天)"
    echo "  link             用新添加的uid生成一个新的SS://链接(Cloak)"
    echo "  scan             用ss://链接在当前终端上生成一个可供扫描的二维码"
    echo "  help             打印帮助信息并退出"
    exit $1
}

_echo(){
    case $1 in
    -u|upon)
        echo
        echo -e "${2}"
        ;;
    -d|down)
        echo -e "${2}"
        echo
        ;;
    -r|red)
        echo
        echo -e "${Red}${2}${suffix}"
        echo
        ;;
    -g|green)
        echo
        echo -e "${Green}${2}${suffix}"
        echo
        ;;
    -i|info)
        echo -e "${Info} ${2}"
        ;;
    -e|error)
        echo -e "${Error} ${2}"
        ;;
    -t|tip)
        echo
        echo -e "${Tip} ${2}"
        echo
        ;;
    -w|warning)
        echo -e "${Warning} ${2}"
        ;;
    *)
        echo
        echo -e "${1}"
        echo
        ;;
    esac
}

_read(){
    case $1 in
    -u|upon)
        echo
        read -e -p "${2}" inputInfo
        ;;
    -d|down)
        read -e -p "${2}" inputInfo
        echo
        ;;
    *)
        echo
        read -e -p "${1}" inputInfo
        echo
        ;;
    esac
}

status_init(){
    if [ -e "${SHADOWSOCKS_LIBEV_BIN_PATH}" ]; then
        ssName="Shadowsocks-libev"
        ssPath="${SHADOWSOCKS_LIBEV_BIN_PATH}"
        ssPid=`ps -ef | grep -v grep | grep ss-server | awk '{print $2}'`
    elif [ -e "${SHADOWSOCKS_RUST_BIN_PATH}" ]; then
        ssName="Shadowsocks-rust"
        ssPath="${SHADOWSOCKS_RUST_BIN_PATH}"
        ssPid=`ps -ef | grep -v grep | grep ssserver | awk '{print $2}'`
    elif [ -e "${GO_SHADOWSOCKS2_BIN_PATH}" ]; then
        ssName="Go-shadowsocks2"
        ssPath="${GO_SHADOWSOCKS2_BIN_PATH}"
        ssPid=`ps -ef | grep -v grep | grep go-shadowsocks2 | awk '{print $2}'`
    fi

    if [ -e "${V2RAY_PLUGIN_BIN_PATH}" ]; then
        pluginName="V2ray-plugin"
        pluginPath="${V2RAY_PLUGIN_BIN_PATH}"
        pluginPid=`ps -ef | grep -vE 'grep|-plugin-opts' | grep v2ray-plugin | awk '{print $2}'`
    elif [ -e "${KCPTUN_BIN_PATH}" ]; then
        pluginName="KcpTun"
        pluginPath="${KCPTUN_BIN_PATH}"
        pluginPid=`ps -ef | grep -vE 'grep|-plugin-opts' | grep kcptun-server | awk '{print $2}'`
    elif [ -e "${SIMPLE_OBFS_BIN_PATH}" ]; then
        pluginName="Simple-obfs"
        pluginPath="${SIMPLE_OBFS_BIN_PATH}"
        pluginPid=`ps -ef | grep -vE 'grep|-plugin-opts' | grep obfs-server | awk '{print $2}'`
    elif [ -e "${GOQUIET_BIN_PATH}" ]; then
        pluginName="GoQuiet"
        pluginPath="${GOQUIET_BIN_PATH}"
        pluginPid=`ps -ef | grep -vE 'grep|-plugin-opts' | grep gq-server | awk '{print $2}'`
    elif [ -e "${CLOAK_SERVER_BIN_PATH}" ]; then
        pluginName="Cloak"
        pluginPath="${CLOAK_SERVER_BIN_PATH}"
        pluginPid=`ps -ef | grep -vE 'grep|-plugin-opts' | grep ck-server | awk '{print $2}'`
    elif [ -e "${MTT_BIN_PATH}" ]; then
        pluginName="Mos-tls-tunnel"
        pluginPath="${MTT_BIN_PATH}"
        pluginPid=`ps -ef | grep -vE 'grep|-plugin-opts' | grep mtt-server | awk '{print $2}'`
    elif [ -e "${RABBIT_BIN_PATH}" ]; then
        pluginName="Rabbit-Tcp"
        pluginPath="${RABBIT_BIN_PATH}"
        pluginPid=`ps -ef | grep -vE 'grep|-plugin-opts' | grep rabbit-tcp | awk '{print $2}'`
    elif [ -e "${SIMPLE_TLS_BIN_PATH}" ]; then
        pluginName="Simple-tls"
        pluginPath="${SIMPLE_TLS_BIN_PATH}"
        pluginPid=`ps -ef | grep -vE 'grep|-plugin-opts' | grep simple-tls | awk '{print $2}'`
    elif [ -e "${GOST_PLUGIN_BIN_PATH}" ]; then
        pluginName="Gost-plugin"
        pluginPath="${GOST_PLUGIN_BIN_PATH}"
        pluginPid=`ps -ef | grep -vE 'grep|-plugin-opts' | grep gost-plugin | awk '{print $2}'`
    elif [ -e "${XRAY_PLUGIN_BIN_PATH}" ]; then
        pluginName="Xray-plugin"
        pluginPath="${XRAY_PLUGIN_BIN_PATH}"
        pluginPid=`ps -ef | grep -vE 'grep|-plugin-opts' | grep xray-plugin | awk '{print $2}'`
    elif [ -e "${QTUN_BIN_PATH}" ]; then
        pluginName="qtun"
        pluginPath="${QTUN_BIN_PATH}"
        pluginPid=`ps -ef | grep -vE 'grep|-plugin-opts' | grep qtun-server | awk '{print $2}'`
    elif [ -e "${GUN_BIN_PATH}" ]; then
        pluginName="gun"
        pluginPath="${GUN_BIN_PATH}"
        pluginPid=`ps -ef | grep -vE 'grep|-plugin-opts' | grep gun-server | awk '{print $2}'`
    fi

    if [ -e "${CADDY_BIN_PATH}" ]; then
        webName="Caddy"
        webPath="${CADDY_BIN_PATH}"
        webPid=`ps -ef | grep -vE 'grep|-plugin-opts' | grep caddy | awk '{print $2}'`
    elif [ -e "${NGINX_BIN_PATH}" ]; then
        webName="Nginx"
        webPath="${NGINX_BIN_PATH}"
        webPid=`ps -ef | grep -vE 'grep|-plugin-opts' | grep nginx.conf | awk '{print $2}'`
    fi
}

status_menu(){
    local NoInstall=" 当前状态: ${Red}未安装${suffix}"
    local InstallStart=" 当前状态: ${Green}已安装${suffix} 并 ${Green}已启动${suffix}"
    local InstallNoStart=" 当前状态: ${Green}已安装${suffix} 但 ${Red}未启动${suffix}"

    status_init

    if [ -e "${ssPath}" ] && [ -e "${pluginPath}" ] && [ -e "${webPath}" ]; then
        if [ -n "${ssPid}" ] && [ -n "${pluginPid}" ] && [ -n "${webPid}" ]; then
            echo -e "${InstallStart}"
        else
            echo -e "${InstallNoStart}"
        fi
    elif [ -e "${ssPath}" ] && [ -e "${pluginPath}" ]; then
        if [ -n "${ssPid}" ] && [ -n "${pluginPid}" ]; then
            echo -e "${InstallStart}"
        else
            echo -e "${InstallNoStart}"
        fi
    elif [ -e "${ssPath}" ]; then
        if [ -n "${ssPid}" ]; then
            echo -e "${InstallStart}"
        else
            echo -e "${InstallNoStart}"
        fi
    else
        echo -e "${NoInstall}"
    fi
}

check_sys(){
    local checkType=$1
    local value=$2

    local release=''
    local systemPackage=''

    if [ -f /etc/redhat-release ]; then
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

    if [ "${checkType}" == "sysRelease" ]; then
        if [ "${value}" == "${release}" ]; then
            return 0
        else
            return 1
        fi
    elif [ "${checkType}" == "packageManager" ]; then
        if [ "${value}" == "${systemPackage}" ]; then
            return 0
        else
            return 1
        fi
    fi
}

check_arch(){
    case "$(uname -m)" in
      'amd64' | 'x86_64')
        ARCH='amd64'
        ;;
      'armv8' | 'aarch64')
        ARCH='arm64'
        ;;
      *)
        echo "[${Red}Error${suffix}] The architecture is not supported."
        exit 1
        ;;
    esac
}

package_install(){
    local package_name=$1
    
    if check_sys packageManager yum; then
        yum install -y $1 > /dev/null 2>&1
        if [ $? -ne 0 ]; then
            _echo -e "安装 $1 失败."
            exit 1
        fi
    elif check_sys packageManager apt; then
        apt-get -y update > /dev/null 2>&1
        apt-get -y install $1 > /dev/null 2>&1
        if [ $? -ne 0 ]; then
            _echo -e "安装 $1 失败."
            exit 1
        fi
    fi
    _echo -i "$1 安装完成."
}

improt_package(){
    local package=$1
    local sh_file=$2
    
    if [ ! "$(command -v curl)" ]; then
        package_install "curl" > /dev/null 2>&1
    fi
    
    if [ "${methods}" = "Online" ]; then
        source <(curl -sL "${BASE_URL}/${package}/${sh_file}")
    else
        cd "${CUR_DIR}"
        source "${BASE_URL}/${package}/${sh_file}"
    fi
}

disable_selinux(){
    if [ -s /etc/selinux/config ] && grep -q 'SELINUX=enforcing' /etc/selinux/config; then
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

check_latest_version(){
    local current_v=$1
    local latest_v=$2
    if version_gt "${latest_v}" "${current_v}"; then
        return 0
    else
        return 1
    fi
}

check_port_occupy(){
    local port=$1
    
    if [ ! "$(command -v lsof)" ]; then
        package_install "lsof" > /dev/null 2>&1
    fi
    if [ `lsof -i:"${port}" | grep -v google_ | grep -v COMMAND | wc -l` -ne 0 ];then
        # Occupied
        return 0
    else
        # Unoccupied
        return 1
    fi
}

kill_process_if_port_occupy(){
    local port=$1

    while true
    do
        if ! check_port_occupy "${port}"; then
            break
        fi
        _echo -g "占用${port}端口的进程信息如下: "
        lsof -i:"${port}"
        _read "检测到${port}端口被占用，是否kill此进程(默认: n) [y/n]: "
        local yn="${inputInfo}"
        [ -z "${yn}" ] && yn="N"
        case "${yn:0:1}" in
            y|Y)
                lsof -i:"${port}" | grep -v grep | grep "${port}" | awk '{print $2}' | xargs kill -9 > /dev/null 2>&1
                _echo -t "占用${port}端口的进程已被杀死."
                break
                ;;
            n|N)
                _echo -e "端口${port}被占用，终止运行."
                exit 1
                ;;
            *)
                _echo -e "输入有误，请重新输入!"
                continue
                ;;
        esac
    done
}

reset_if_ss_port_is_443(){
    while true
    do
        if [ "${shadowsocksport}" -ne 443 ]; then
            break
        fi
        gen_random_prot
        if check_port_occupy "${ran_prot}"; then
            continue
        fi
        shadowsocksport="${ran_prot}"
        break
    done
}

check_script_update(){
    local isShow="${1:-"show"}"

    SHELL_VERSION_NEW=$(wget --no-check-certificate -qO- "https://git.io/fjlbl"|grep 'SHELL_VERSION="'|awk -F "=" '{print $NF}'|sed 's/\"//g'|head -1)
    [ -z "${SHELL_VERSION_NEW}" ] && _echo -e "无法链接到 Github !" && exit 0
    if version_gt "${SHELL_VERSION_NEW}" "${SHELL_VERSION}"; then
        _echo -u "${Green}当前脚本版本为：${SHELL_VERSION} 检测到有新版本可更新.${suffix}"
        _echo -d "按任意键开始…或按Ctrl+C取消"
        char=`get_char`
        wget -N --no-check-certificate -O ss-plugins.sh "https://git.io/fjlbl" && chmod +x ss-plugins.sh
        echo -e "脚本已更新为最新版本[ ${SHELL_VERSION_NEW} ] !(注意：因为更新方式为直接覆盖当前运行的脚本，所以可能下面会提示一些报错，无视即可)" && exit 0
    else
        if [ "${isShow}" = "show" ]; then
            _echo -i "当前脚本版本为: ${SHELL_VERSION} 未检测到更新版本."
        fi
    fi
}

choose_script_bbr(){
    local bbrVersion=(
        "秋水逸冰-BBR"
        "BBR|BBR魔改|BBRplus|Lotserver版本"
    )
    generate_menu_logic "${bbrVersion[*]}" "BBR的安装脚本" "1"
    bbr_menu_num="${inputInfo}"
    case "${bbr_menu_num}" in
        1)
            source <(curl -sL "${TEDDYSUN_BBR_SCRIPT_URL}")
            ;;
        2)
            source <(curl -sL "${CHIAKGE_BBR_SCRIPT_URL}")
            ;;
        *)
            _echo -e "请输入正确的数字 [1-2]"
            ;;
    esac
}

get_ip(){
    local IP=$( ip addr | egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | egrep -v "^192\.168|^172\.1[6-9]\.|^172\.2[0-9]\.|^172\.3[0-2]\.|^10\.|^127\.|^255\.|^0\." | head -n 1 )
    [ -z "${IP}" ] && IP=$( wget -qO- -t1 -T2 ipv4.icanhazip.com )
    [ -z "${IP}" ] && IP=$( wget -qO- -t1 -T2 ipinfo.io/ip )
    echo "${IP}"
}

get_ipv6(){
    local ipv6=$(wget -qO- -t1 -T2 ipv6.icanhazip.com)
    [ -z "${ipv6}" ] && return 1 || return 0
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

get_domain_ip(){
    local domain=$1
    local ipv4Re="((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])"

    if [ ! "$(command -v nslookup)" ]; then
        if check_sys packageManager yum; then
            package_install "bind-utils" > /dev/null 2>&1
        elif check_sys packageManager apt; then
            package_install "dnsutils" > /dev/null 2>&1
        fi
    fi

    domain_ip=`nslookup ${domain} | grep -E 'Name:' -A 1 | grep -oE $ipv4Re | tail -1`
    if [ -n "${domain_ip}" ]; then
        return 0
    else
        return 1
    fi
}

get_str_replace(){
    echo -n $1 | sed 's/:/%3A/g;s/;/%3B/g;s/=/%3D/g;s/\//%2F/g'
}

get_str_base64_encode(){
    echo -n $1 | base64 -w0
}

gen_random_prot(){
    ran_prot="$(shuf -i 9000-19999 -n 1)"
}

gen_random_str(){
    ran_str5="$(head -c 100 /dev/urandom | tr -dc a-z0-9A-Z | head -c 5)"
    ran_str12="$(head -c 100 /dev/urandom | tr -dc a-z0-9A-Z | head -c 12)"
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
    if [ -s /etc/redhat-release ]; then
        grep -oE  "[0-9.]+" /etc/redhat-release
    else
        grep -oE  "[0-9.]+" /etc/issue
    fi
}

centosversion(){
    if check_sys sysRelease centos; then
        local code=$1
        local version="$(get_version)"
        local main_ver="${version%%.*}"
        if [ "$main_ver" == "$code" ]; then
            return 0
        else
            return 1
        fi
    else
        return 1
    fi
}

judge_is_num(){
    local aNum=$1

    expr "${aNum}" + 1 &>/dev/null
    if [ $? -ne 0 ]; then
        return 1
    else
        return 0
    fi
}

judge_is_zero_begin_num(){
    local aNum=$1

    if [ "${aNum:0:1}" = 0 ]; then
        return 0
    else
        return 1
    fi
}

judge_is_equal_num(){
    local numOne=$1
    local numTwo=$2

    if [ "${numOne}" -eq "${numTwo}" ]; then
        return 0
    else
        return 1
    fi
}

judge_num_in_range(){
    local aNum=$1
    local maxNum=$2

    if [ "${aNum}" -lt 1 ] || [ "${aNum}" -gt "${maxNum}" ]; then
        return 1
    else
        return 0
    fi
}

judge_is_nul_str(){
    local str=$1

    if [ -z "${str}" ]; then
        return 0
    else
        return 1
    fi
}

judge_is_domain(){
    local domain=$1

    if [ -z "$(echo ${domain} | grep -E ${DOMAIN_RE})" ]; then
        return 1
    else
        return 0
    fi
}

judge_is_valid_domain(){
    local domain=$1

    if judge_is_https_begin_site "${domain}"; then
        domain=$(echo ${domain} | sed 's/https:\/\///g')
    fi
    if get_domain_ip "${domain}"; then
        return 0
    else
        return 1
    fi
}

judge_is_ip_colon_port_format(){
    # Match: ip:443 format
    local ipColonPort=$1

    if [ -z "$(echo ${ipColonPort} | grep -E ${IPV4_PORT_RE})" ]; then
        return 1
    else
        return 0
    fi
}

judge_is_path(){
    local path=$1

    if [ -z "$(echo ${path} | grep -E '^\/(\w+\/?)+$')" ]; then
        return 1
    else
        return 0
    fi
}

judge_is_https_begin_site(){
    local domainWithProtocolHeader=$1

    if [ -z "$(echo ${domainWithProtocolHeader} | grep -E ${HTTPS_DOMAIN_RE})" ]; then
        return 1
    else
        return 0
    fi
}

judge_domain_type(){
    local ip=$1

    if is_cdn_proxied "${ip}"; then
        echo "CDN"
    elif is_dns_only "${ip}"; then
        echo "DNS-Only"
    else
        echo "Other"
    fi
}

generate_menu(){
    local aArray=($1)
    local num=$2
    local hint

    for ((i=1;i<="${#aArray[@]}";i++ )); do
        hint="${aArray[$i-1]}"
        if [ "${i}" -le 9 ]; then
            echo -e "${Green}  ${i}.${suffix} ${hint}"
        else
            echo -e "${Green} ${i}.${suffix} ${hint}"
        fi
    done
    _read "(默认: ${aArray[${num}-1]}):"
}

generate_menu_logic(){
    # global var: inputInfo, optionValue
    local aArray=($1)
    local tipText=$2
    local defualtOptNum=$3
    local arrayLong="${#aArray[@]}"

    while true
    do
        _echo "请选择${tipText}："
        generate_menu "${aArray[*]}" "${defualtOptNum}"
        [ -z "${inputInfo}" ] && inputInfo="${defualtOptNum}"
        if ! judge_is_num "${inputInfo}"; then
            _echo -e "请输入一个数字."
            continue
        fi
        if ! judge_num_in_range "${inputInfo}" "${arrayLong}"; then
            _echo -e "请输入一个数字在 [1-${arrayLong}] 之间"
            continue
        fi
        optionValue="${aArray[$inputInfo-1]}"
        _echo -r "  selected = ${optionValue}"
        break
    done
}

config_ss(){
    local ipv6First="false"
    local server_value="\"0.0.0.0\""

    if get_ipv6; then
        local ssVer="${SS_VERSION}"
        local pluginNum="${plugin_num}"

        if [ "${ssVer}" = "ss-libev" ]; then
            server_value="[\"[::0]\",\"0.0.0.0\"]"
            case "${pluginNum}" in
                8|9|12)
                    server_value="\"0.0.0.0\""
                    ;;
            esac
        elif [ "${ssVer}" = "ss-rust" ]; then
            server_value="\"::\""
            case "${pluginNum}" in
                3)
                    server_value="\"0.0.0.0\""
                    ;;
            esac
        fi

        case "${pluginNum}" in
            4|6|7)
                server_value="\"0.0.0.0\""
                ;;
        esac

        if [ "${server_value}" != "\"0.0.0.0\"" ]; then
            ipv6First="true"
        fi
    fi

    if [ ! -d "$(dirname ${SHADOWSOCKS_CONFIG})" ]; then
        mkdir -p $(dirname ${SHADOWSOCKS_CONFIG})
    fi
    case "${plugin_num}" in
        1)
            improt_package "templates/config" "v2ray_plugin_config.sh"
            config_ss_v2ray_plugin
            ;;
        2)
            improt_package "templates/config" "kcptun_config.sh"
            config_ss_kcptun
            ;;
        3)
            improt_package "templates/config" "simple_obfs_config.sh"
            config_ss_simple_obfs
            ;;
        4)
            improt_package "templates/config" "goquiet_config.sh"
            config_ss_goquiet
            ;;
        5)
            improt_package "templates/config" "cloak_config.sh"
            config_ss_cloak
            ;;
        6)
            improt_package "templates/config" "mos_tls_tunnel_config.sh"
            config_ss_mos_tls_tunnel
            ;;
        7)
            improt_package "templates/config" "rabbit_tcp_config.sh"
            config_ss_rabbit_tcp
            ;;
        8)
            improt_package "templates/config" "simple_tls_config.sh"
            config_ss_simple_tls
            ;;
        9)
            improt_package "templates/config" "gost_plugin_config.sh"
            config_ss_gost_plugin
            ;;
        10)
            improt_package "templates/config" "xray_plugin_config.sh"
            config_ss_xray_plugin
            ;;
        11)
            improt_package "templates/config" "qtun_config.sh"
            config_ss_qtun
            ;;
        12)
            improt_package "templates/config" "gun_config.sh"
            config_ss_gun
            ;;
        *)
            ss_server_config
            ;;
    esac
}

config_webserver(){
    case "${web_flag}" in
        1)
            improt_package "webServer" "caddy_config.sh"
            caddy_config 
            ;;
        2)
            improt_package "webServer" "nginx_config.sh"
            mirror_domain=$(echo ${mirror_site} | sed 's/https:\/\///g')
            nginx_config
            ;;
    esac
}

gen_ss_links(){
    case "${plugin_num}" in
        1)
            improt_package "templates/sslinks" "v2ray_plugin_link.sh"
            gen_ss_v2ray_plugin_link
            ;;
        2)
            improt_package "templates/sslinks" "kcptun_link.sh"
            gen_ss_kcptun_link
            ;;
        3)
            improt_package "templates/sslinks" "simple_obfs_link.sh"
            gen_ss_simple_obfs_link
            ;;
        4)
            improt_package "templates/sslinks" "goquiet_link.sh"
            gen_ss_goquiet_link
            ;;
        5)
            improt_package "templates/sslinks" "cloak_link.sh"
            gen_ss_cloak_link
            ;;
        6)
            improt_package "templates/sslinks" "mos_tls_tunnel_link.sh"
            gen_ss_mos_tls_tunnel_link
            ;;
        7)
            improt_package "templates/sslinks" "rabbit_tcp_link.sh"
            gen_ss_rabbit_tcp_link
            ;;
        8)
            improt_package "templates/sslinks" "simple_tls_link.sh"
            gen_ss_simple_tls_link
            ;;
        9)
            improt_package "templates/sslinks" "gost_plugin_link.sh"
            gen_ss_gost_plugin_link
            ;;
        10)
            improt_package "templates/sslinks" "xray_plugin_link.sh"
            gen_ss_xray_plugin_link
            ;;
        11)
            improt_package "templates/sslinks" "qtun_link.sh"
            gen_ss_qtun_link
            ;;
        12)
            improt_package "templates/sslinks" "gun_link.sh"
            gen_ss_gun_link
            ;;
        *)
            clientIpOrDomain="$(get_ip)"
            ss_client_links
            ;;
    esac
}

install_completed(){
    case "${plugin_num}" in
        1|3|4|6|7|8|9|10|11|12)
            ss_plugins_show
            ;;
        2)
            ss_kcptun_show
            ;;
        5)
            ss_cloak_show
            ;;
        *)
            ss_base_show
            ;;
    esac
}

whether_to_install_the_plugin(){
    while true
    do
        _read "要安装一个插件吗？(默认: n) [y/n]:"
        local yn="${inputInfo}"
        [ -z "${yn}" ] && yn="N"
        case "${yn:0:1}" in
            y|Y)
                isInstallPlugin=Yes
                ;;
            n|N)
                isInstallPlugin=No
                ;;
            *)
                _echo -e "输入有误，请重新输入."
                continue
                ;;
        esac
        _echo -r "  selected = ${isInstallPlugin}"
        break
    done
}

choose_ss_plugin(){
    generate_menu_logic "${SS_PLUGINS_NAME[*]}" "Shadowsocks插件" "1"
    plugin_num="${inputInfo}" 
    case "${plugin_num}" in
        1)
            improt_package "prepare" "v2ray_plugin_prepare.sh"
            install_prepare_libev_v2ray
            ;;
        2)
            improt_package "prepare" "kcptun_prepare.sh"
            install_prepare_libev_kcptun
            ;;
        3)
            improt_package "prepare" "simple_obfs_prepare.sh"
            install_prepare_libev_obfs
            ;;
        4)
            improt_package "prepare" "goquiet_prepare.sh"
            install_prepare_libev_goquiet
            ;;
        5)
            improt_package "prepare" "cloak_prepare.sh"
            install_prepare_libev_cloak
            ;;
        6)
            improt_package "prepare" "mos_tls_tunnel_prepare.sh"
            install_prepare_libev_mos_tls_tunnel
            ;;
        7)
            improt_package "prepare" "rabbit_tcp_prepare.sh"
            install_prepare_libev_rabbit_tcp
            ;;
        8)
            improt_package "prepare" "simple_tls_prepare.sh"
            install_prepare_libev_simple_tls
            ;;
        9)
            improt_package "prepare" "gost_plugin_prepare.sh"
            install_prepare_libev_gost_plugin
            ;;
        10)
            improt_package "prepare" "xray_plugin_prepare.sh"
            install_prepare_libev_xray_plugin
            ;;
        11)
            improt_package "prepare" "qtun_prepare.sh"
            install_prepare_libev_qtun
            ;;
        12)
            improt_package "prepare" "gun_prepare.sh"
            install_prepare_libev_gun
            ;;
    esac
}

install_prepare(){
    check_script_update "notShow"
    improt_package "prepare" "shadowsocks_prepare.sh"
    choose_ss_install_version
    install_prepare_port
    install_prepare_password
    install_prepare_cipher
    serverTcpAndUdp="tcp_and_udp"
    firewallNeedOpenPort="${shadowsocksport}"
    whether_to_install_the_plugin
    if [ "${isInstallPlugin}" = "No" ]; then
        _echo -t "当前未选择任何插件，仅安装${SS_VERSION}."
    elif [ "${isInstallPlugin}" = "Yes" ]; then
        choose_ss_plugin
    fi
    echo
    echo "按任意键开始…或按Ctrl+C取消"
    char=`get_char`
}

install_main(){
    if [ "${SS_VERSION}" = "ss-libev" ]; then
        install_libsodium_logic
        if ! ldconfig -p | grep -wq "/usr/lib"; then
            echo "/usr/lib" > /etc/ld.so.conf.d/lib.conf
        fi
        ldconfig
        install_mbedtls_logic
    fi
    improt_package "install" "shadowsocks_install.sh"
    case "${SS_VERSION}" in
        "ss-libev")
            install_shadowsocks_libev
        ;;
        "ss-rust")
            install_shadowsocks_rust
        ;;
        "go-ss2")
            install_go_shadowsocks2
        ;;
    esac
    case "${plugin_num}" in
        1)
            improt_package "install" "v2ray_plugin_install.sh"
            install_v2ray_plugin
            serverPluginName="v2ray-plugin"
            clientPluginName="v2ray-plugin"
            ;;
        2)
            improt_package "install" "kcptun_install.sh"
            install_kcptun
            serverPluginName="kcptun-server"
            clientPluginName="kcptun"
            ;;
        3)
            improt_package "install" "simple_obfs_install.sh"
            install_simple_obfs
            serverPluginName="obfs-server"
            clientPluginName="obfs-local"
            ;;
        4)
            improt_package "install" "goquiet_install.sh"
            install_goquiet
            serverPluginName="gq-server"
            clientPluginName="gq-client"
            ;;
        5)
            improt_package "install" "cloak_install.sh"
            install_cloak
            gen_credentials
            serverPluginName="ck-server"
            clientPluginName="ck-client"
            ;;
        6)
            improt_package "install" "mos_tls_tunnel_install.sh"
            install_mos_tls_tunnel
            serverPluginName="mtt-server"
            clientPluginName="mostlstunnel"
            ;;
        7)
            improt_package "install" "rabbit_tcp_install.sh"
            install_rabbit_tcp
            serverPluginName="rabbit-tcp"
            clientPluginName="rabbit-plugin"
            ;;
        8)
            improt_package "install" "simple_tls_install.sh"
            install_simple_tls
            serverPluginName="simple-tls"
            clientPluginName="simple-tls"
            ;;
        9)
            improt_package "install" "gost_plugin_install.sh"
            install_gost_plugin
            serverPluginName="gost-plugin"
            clientPluginName="gost-plugin"
            ;;
        10)
            improt_package "install" "xray_plugin_install.sh"
            install_xray_plugin
            serverPluginName="xray-plugin"
            clientPluginName="xray-plugin"
            ;;
        11)
            improt_package "install" "qtun_install.sh"
            install_qtun
            serverPluginName="qtun-server"
            clientPluginName="qtun-client"
            ;;
        12)
            improt_package "install" "gun_install.sh"
            install_gun
            serverPluginName="gun-server"
            clientPluginName="gun-client"
            ;;
    esac
}

install_webserver(){
    case "${web_flag}" in
        1)
            improt_package "webServer" "caddy_install.sh"
            install_caddy
        ;;
        2)
            improt_package "webServer" "nginx_install.sh"
            install_nginx
        ;;
    esac
}

gen_random_minute(){
    local _t="$(date -u "+%s")"
    echo "$(($_t % 60))"
}

certificate_renew_by_acme(){
    if ! check_port_occupy "80"; then
        return
    fi
    do_stop > /dev/null
    "/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" > /dev/null
    do_start > /dev/null
}

add_cron_job_for_acme(){
    random_minute="$(gen_random_minute)"
    (crontab -l ; echo "${random_minute} 0 * * * \"/root/.acme.sh\"/acme.sh --cron --home \"/root/.acme.sh\" > /dev/null") | sort - | uniq - | crontab -
}

remove_cron_job_for_acme(){
    if [ -z "$(crontab -l | grep 'acme.sh --cron')" ]; then
        return
    fi
    crontab -l | sed '/acme.sh --cron/d' | crontab -
}

add_cron_job(){
    local random_minute

    if ! check_port_occupy "80"; then
        return
    fi
    remove_cron_job_for_acme
    random_minute="$(gen_random_minute)"
    (crontab -l ; echo "${random_minute} 0 * * * \"${CUR_DIR}\"/ss-plugins.sh renew > /dev/null") | sort - | uniq - | crontab -
}

install_status(){
    status_init

    if [ -e "${ssPath}" ] && [ -e "${pluginPath}" ] && [ -e "${webPath}" ]; then
        echo -e "\n${Info} ${ssName} ${pluginName} ${webName} 已经安装.\n"
        exit 1
    elif [ -e "${ssPath}" ] && [ -e "${pluginPath}" ]; then
        echo -e "\n${Info} ${ssName} ${pluginName} 已经安装.\n"
        exit 1
    elif [ -e "${ssPath}" ]; then
        echo -e "\n${Info} ${ssName} 已经安装.\n"
        exit 1
    fi
}

install_step_all(){
    install_status
    disable_selinux
    install_prepare
    improt_package "utils" "dependencies.sh"
    install_dependencies_logic
    improt_package "utils" "downloads.sh"
    download_ss_file
    download_plugins_file
    improt_package "utils" "firewalls.sh"
    config_firewall_logic
    install_main
    install_webserver
    add_more_entropy
    install_cleanup
    improt_package "templates" "config.sh"
    config_ss
    config_webserver
    gen_ss_links
    install_completed
    ldconfig
    do_start
    add_cron_job
    do_show
}

install_cleanup(){
    cd "${CUR_DIR}"
    # ss-libev
    rm -rf "${LIBSODIUM_FILE}" "${LIBSODIUM_FILE}.tar.gz"
    rm -rf "${MBEDTLS_FILE}" "${MBEDTLS_FILE}.tar.gz"
    rm -rf "${shadowsocks_libev_file}" "${shadowsocks_libev_file}.tar.gz"
    
    # ss-rust
    rm -rf "${shadowsocks_rust_file}.tar.xz"
    
    # v2ray-plugin
    rm -rf "${v2ray_plugin_file}.tar.gz"
    
    # kcptun
    rm -rf "client_linux_${ARCH}" "${kcptun_file}.tar.gz"
    
    # simple-obfs
    rm -rf simple-obfs
    
    # mos-tls-tunnel
    rm -rf "${mtt_file}.zip" LICENSE README.md mtt-client

    #simple-tls
    rm -rf "${simple_tls_file}.zip" LICENSE  README.md README_zh.md README_en.md

    # gost-plugin
    rm -rf "${gost_plugin_file}.zip"

    # xray-plugin
    rm -rf "${xray_plugin_file}.tar.gz"

    # qtun
    rm -rf qtun-client "${qtun_file}.tar.xz"
}

do_uid(){
    improt_package "utils" "ck_user_manager.sh"
    user_manager_by_uid
}

do_link(){
    improt_package "utils" "ck_sslink.sh"
    gen_ssurl_by_uid "$1"
}

do_scan(){
    improt_package "utils" "qr_code.sh"
    gen_qr_code "$1"
}

do_show(){
    local mark=$1

    if [ ! -e "${HUMAN_CONFIG}" ]; then
        echo "The visible config not found."
        exit 1
    fi
    if [ "${mark}" = "cleanScreen" ]; then
        clear -x
    fi
    cat "${HUMAN_CONFIG}"
}

do_log(){
    improt_package "utils" "view_log.sh"
    show_log
}

do_cert(){
    improt_package "utils" "gen_certificates.sh"
    acme_get_certificate_by_manual_force "$1"
}

do_catcfg(){
    improt_package "utils" "view_config.sh"
    view_config_logic
}

do_start(){
    status_init
    if [ -z "${ssPath}" ]; then
        _echo -r "Shadowsocks未安装，请尝试安装后，再来执行此操作."
        exit 1
    fi
    improt_package "utils" "start.sh"
    start_services
}

do_stop(){
    improt_package "utils" "stop.sh"
    stop_services
}

do_restart(){
    do_stop
    do_start
}

do_status(){
    improt_package "utils" "status.sh"
    other_status
}

do_update(){
    cd "${CUR_DIR}"
    improt_package "utils" "update.sh"
    update_logic
}

do_uninstall(){
    status_init
    if [ -e "${ssPath}" ] && [ -e "${pluginPath}" ] && [ -e "${webPath}" ]; then
        local pkgName="${ssName} ${pluginName} ${webName}"
    elif [ -e "${ssPath}" ] && [ -e "${pluginPath}" ]; then
        local pkgName="${ssName} ${pluginName}"
    elif [ -e "${ssPath}" ]; then
        local pkgName="${ssName}"
    else
        local pkgName="Shadowsocks"
    fi
    _read "你确定要卸载${pkgName}吗?(默认: n) [y/n]"
    local yn="${inputInfo}"
    [ -z "${yn}" ] && yn="N"
    case "${yn:0:1}" in
        y|Y)
            improt_package "utils" "uninstall.sh"
            uninstall_services
            _echo -i "${pkgName} 卸载成功."
            ;;
        *)
            _echo -i "${pkgName} 卸载取消."
            exit 1
            ;;
    esac
}

do_install(){
    local mark

    if ! install_check; then
        echo -e "[${Red}Error${suffix}] Your OS is not supported to run it!"
        echo "Please change to CentOS 6+/Debian 7+/Ubuntu 12+ and try again."
        exit 1
    fi
    if [ -e "${SHADOWSOCKS_LIBEV_BIN_PATH}" ]; then
        mark="Shadowsocks-libev"
    elif [ -e "${SHADOWSOCKS_RUST_BIN_PATH}" ]; then
        mark="Shadowsocks-rust"
    elif [ -e "${GO_SHADOWSOCKS2_BIN_PATH}" ]; then
        mark="Go-shadowsocks2"
    else
        mark="Shadowsocks"
    fi
    echo -e " ${mark}一键脚本 ${Red}[v${SHELL_VERSION} ${methods}]${suffix}\n"
    echo -e "    ${Green}1.${suffix} BBR"
    echo -e "    ${Green}2.${suffix} Install"
    echo -e "    ${Green}3.${suffix} Uninstall\n"
    status_menu
    _read -u "请输入数字 (默认: 2)："
    menu_num="${inputInfo}"
    [ -z "${menu_num}" ] && menu_num=2
    case "${menu_num}" in
        1)   
            choose_script_bbr
            ;;
        2)
            install_step_all
            ;;
        3)
            do_uninstall
            ;;
        *)
            _echo -e "请输入正确的数字 [1-3]"
            ;;
    esac
}



# install and tools
check_arch
action=${1:-"install"}

case ${action} in
    install|uninstall|update|start|stop|restart)
        do_${action}
        ;;
    status)
        do_${action}
        ;;
    script)
        check_script_update
        ;;
    uid)
        do_${action} 
        ;;
    link)
        do_${action} "${2}"
        ;;
    scan)
        do_${action} "${2}"
        ;;
    show)
        do_${action} "cleanScreen"
        ;;
    log)
        do_${action}
        ;;
    cert)
        do_${action} "${2}"
        ;;
    catcfg)
        do_${action} "${2}"
        ;;
    renew)
        certificate_renew_by_acme
        ;;
    help)
        usage 0
        ;;
    *)
        usage 1
        ;;
esac