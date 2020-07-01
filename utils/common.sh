usage() {
	cat >&1 <<-EOF
Usage: 
  ./ss-plugins.sh [options...] [args...]
    
Available Options:
  install          安装
  uninstall        卸载
  update           升级
  start            启动
  stop             关闭
  restart          重启
  status           查看状态
  script           升级脚本
  show             显示可视化配置
  log              查看日志文件
  cert             手动申请Cloudflare CDN证书(仅 .cf .ga .gq .ml .tk，有效期90天)
  uid              为cloak添加一个新的uid用户(仅 Cloak)
  link             用新添加的uid生成一个新的SS://链接(仅 Cloak)
  scan             用ss://链接在当前终端上生成一个可供扫描的二维码
  help             打印帮助信息并退出

	EOF

    exit $1
}

menu_status(){
    local BIN_PATH=$1
    local SS_PID=$2
    local NoInstall=" 当前状态: ${Red}未安装${suffix}"
    local InstallStart=" 当前状态: ${Green}已安装${suffix} 并 ${Green}已启动${suffix}"
    local InstallNoStart=" 当前状态: ${Green}已安装${suffix} 但 ${Red}未启动${suffix}"
    
    if [[ -e ${BIN_PATH} ]] && [[ -e ${V2RAY_PLUGIN_BIN_PATH} ]] && [[ -e ${CADDY_BIN_PATH}  ]]; then
        V2_PID=`ps -ef |grep -v grep | grep v2ray-plugin |awk '{print $2}'`
        CADDY_PID=`ps -ef |grep -v grep | grep caddy |awk '{print $2}'`
        
        if [[ ! -z ${SS_PID} ]] && [[ ! -z ${V2_PID} ]] && [[ ! -z ${CADDY_PID} ]]; then
            echo -e "${InstallStart}"
        else
            echo -e "${InstallNoStart}"
        fi
    elif [[ -e ${BIN_PATH} ]] && [[ -e ${V2RAY_PLUGIN_BIN_PATH} ]] && [[ -e ${NGINX_BIN_PATH}  ]]; then
        V2_PID=`ps -ef |grep -v grep | grep v2ray-plugin |awk '{print $2}'`
        NGINX_PID=`ps -ef |grep -v grep | grep nginx.conf |awk '{print $2}'`
        
        if [[ ! -z ${SS_PID} ]] && [[ ! -z ${V2_PID} ]] && [[ ! -z ${NGINX_PID} ]]; then
            echo -e "${InstallStart}"
        else
            echo -e "${InstallNoStart}"
        fi
    elif [[ -e ${BIN_PATH} ]] && [[ -e ${V2RAY_PLUGIN_BIN_PATH} ]]; then
        V2_PID=`ps -ef |grep -v grep | grep v2ray-plugin |awk '{print $2}'`
        
        if [[ ! -z ${SS_PID} ]] && [[ ! -z ${V2_PID} ]]; then
            echo -e "${InstallStart}"
        else
            echo -e "${InstallNoStart}"
        fi
    elif [[ -e ${BIN_PATH} ]] && [[ -e ${KCPTUN_BIN_PATH} ]]; then
        KP_PID=`ps -ef |grep -v grep | grep kcptun-server |awk '{print $2}'`
        
        if [[ ! -z ${SS_PID} ]] && [[ ! -z ${KP_PID} ]]; then
            echo -e "${InstallStart}"
        else
            echo -e "${InstallNoStart}"
        fi
    elif [[ -e ${BIN_PATH} ]] && [[ -e ${SIMPLE_OBFS_BIN_PATH} ]]; then
        OBFS_PID=`ps -ef |grep -v grep | grep obfs-server |awk '{print $2}'`
        
        if [[ ! -z ${SS_PID} ]] && [[ ! -z ${OBFS_PID} ]]; then
            echo -e "${InstallStart}"
        else
            echo -e "${InstallNoStart}"
        fi
    elif [[ -e ${BIN_PATH} ]] && [[ -e ${GOQUIET_BIN_PATH} ]]; then    
        GQ_PID=`ps -ef |grep -v grep | grep gq-server |awk '{print $2}'`
        
        if [[ ! -z ${SS_PID} ]] && [[ ! -z ${GQ_PID} ]]; then
            echo -e "${InstallStart}"
        else
            echo -e "${InstallNoStart}"
        fi
    elif [[ -e ${BIN_PATH} ]] && [[ -e ${CLOAK_SERVER_BIN_PATH} ]]; then
        CK_PID=`ps -ef |grep -v grep | grep ck-server |awk '{print $2}'`
        
        if [[ ! -z ${SS_PID} ]] && [[ ! -z ${CK_PID} ]]; then
            echo -e "${InstallStart}"
        else
            echo -e "${InstallNoStart}"
        fi
    elif [[ -e ${BIN_PATH} ]] && [[ -e ${MTT_BIN_PATH} ]] && [[ -e ${CADDY_BIN_PATH}  ]]; then
        MTT_PID=`ps -ef |grep -v grep | grep mtt-server |awk '{print $2}'`
        CADDY_PID=`ps -ef |grep -v grep | grep caddy |awk '{print $2}'`
        
        if [[ ! -z ${SS_PID} ]] && [[ ! -z ${MTT_PID} ]] && [[ ! -z ${CADDY_PID} ]]; then
            echo -e "${InstallStart}"
        else
            echo -e "${InstallNoStart}"
        fi
    elif [[ -e ${BIN_PATH} ]] && [[ -e ${MTT_BIN_PATH} ]] && [[ -e ${NGINX_BIN_PATH}  ]]; then
        MTT_PID=`ps -ef |grep -v grep | grep mtt-server |awk '{print $2}'`
        NGINX_PID=`ps -ef |grep -v grep | grep nginx.conf |awk '{print $2}'`
        
        if [[ ! -z ${SS_PID} ]] && [[ ! -z ${MTT_PID} ]] && [[ ! -z ${NGINX_PID} ]]; then
            echo -e "${InstallStart}"
        else
            echo -e "${InstallNoStart}"
        fi
    elif [[ -e ${BIN_PATH} ]] && [[ -e ${MTT_BIN_PATH} ]]; then    
        MTT_PID=`ps -ef |grep -v grep | grep mtt-server |awk '{print $2}'`
        
        if [[ ! -z ${SS_PID} ]] && [[ ! -z ${MTT_PID} ]]; then
            echo -e "${InstallStart}"
        else
            echo -e "${InstallNoStart}"
        fi
    elif [[ -e ${BIN_PATH} ]] && [[ -e ${RABBIT_BIN_PATH} ]]; then
        RABBIT_PID=`ps -ef |grep -v grep | grep rabbit-tcp |awk '{print $2}'`
        
        if [[ ! -z ${SS_PID} ]] && [[ ! -z ${RABBIT_PID} ]]; then
            echo -e "${InstallStart}"
        else
            echo -e "${InstallNoStart}"
        fi
    elif [[ -e ${BIN_PATH} ]] && [[ -e ${SIMPLE_TLS_BIN_PATH} ]]; then
        SIMPLE_TLS_PID=`ps -ef |grep -v grep | grep simple-tls |awk '{print $2}'`

        if [[ ! -z ${SS_PID} ]] && [[ ! -z ${SIMPLE_TLS_PID} ]]; then
            echo -e "${InstallStart}"
        else
            echo -e "${InstallNoStart}"
        fi
    elif [[ -e ${BIN_PATH} ]]; then
        if [[ ! -z ${SS_PID} ]]; then
            echo -e "${InstallStart}"
        else
            echo -e "${InstallNoStart}"
        fi
    else
        echo -e "${NoInstall}"
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
    if version_gt ${latest_v} ${current_v}; then
        return 0
    else
        return 1
    fi
}

check_port_occupy(){
    local PROT=$1
    
    if [ ! "$(command -v lsof)" ]; then
        package_install "lsof" > /dev/null 2>&1
    fi
    
    if [[ `lsof -i:"${PROT}" | grep -v google_ | grep -v COMMAND | wc -l` -ne 0 ]];then
        # Occupied
        return 0
    else
        # Unoccupied
        return 1
    fi
}

check_script_update(){
    SHELL_VERSION_NEW=$(wget --no-check-certificate -qO- "https://git.io/fjlbl"|grep 'SHELL_VERSION="'|awk -F "=" '{print $NF}'|sed 's/\"//g'|head -1)
    [[ -z ${SHELL_VERSION_NEW} ]] && echo -e "${Error} 无法链接到 Github !" && exit 0
    if version_gt ${SHELL_VERSION_NEW} ${SHELL_VERSION}; then
        echo
        echo -e "${Green}当前脚本版本为：${SHELL_VERSION} 检测到有新版本可更新.${suffix}"
        echo -e "按任意键开始…或按Ctrl+C取消"
        char=`get_char`
        wget -N --no-check-certificate -O ss-plugins.sh "https://git.io/fjlbl" && chmod +x ss-plugins.sh
        echo -e "脚本已更新为最新版本[ ${SHELL_VERSION_NEW} ] !(注意：因为更新方式为直接覆盖当前运行的脚本，所以可能下面会提示一些报错，无视即可)" && exit 0
    else
        echo
        echo -e "${Info} 当前脚本版本为: ${SHELL_VERSION} 未检测到更新版本."
        echo
    fi
}

check_ss_port(){
    local SS_PORT=$1
    while true
    do
        if [[ ${SS_PORT} -ne "443" ]]; then
            echo -e "${Tip} SS-libev端口为${Green}${shadowsocksport}${suffix}"
            echo
            break
        fi
        
        gen_random_prot
        if check_port_occupy ${ran_prot}; then
            continue
        fi
        
        shadowsocksport=${ran_prot}
        echo -e "${Tip} SS-libev端口已由${Red}443${suffix}重置为${Green}${shadowsocksport}${suffix}"
        echo  
        break
    done
}

choose_script_bbr(){
    echo
    echo -e "请选择BBR的安装脚本"
    echo
    echo -e "    ${Green}1.${suffix} 秋水逸冰-BBR"
    echo -e "    ${Green}2.${suffix} BBR|BBR魔改|BBRplus|Lotserver版本"
    echo && read -e -p "请输入数字 [1-2]：" bbr_menu_num
    case "${bbr_menu_num}" in
        1)
            source <(curl -sL ${TEDDYSUN_BBR_SCRIPT_URL})
            ;;
        2)
            source <(curl -sL ${CHIAKGE_BBR_SCRIPT_URL})
            ;;
        *)
            echo -e "${Error} 请输入正确的数字 [1-2]"
            ;;
    esac
}

choose_caddy_extension(){
    local libev_v2ray=$1
    
    improt_package "tools" "caddy_install.sh"
    if [[ ${libev_v2ray} == "4" ]]; then
        install_caddy
    elif [[ ${libev_v2ray} == "5" ]]; then
        install_caddy "tls.dns.cloudflare"
    fi
}

add_more_entropy(){
    # Ubuntu series is started by default after installation
    # Debian series needs to add configuration to start after installation
    # CentOS 6 is installed by default but not started. CentOS 7 is not started by default after installation. CentOS 8 is installed and started by default.
    local ENTROPY_SIZE_BEFORE=$(cat /proc/sys/kernel/random/entropy_avail)
    if [[ ${ENTROPY_SIZE_BEFORE} -lt 1000 ]]; then
        echo -e "${Info} 安装rng-tools之前熵池的熵值为${Green}${ENTROPY_SIZE_BEFORE}${suffix}"
        if [[ ! $(command -v rngd) ]]; then
            package_install "rng-tools"
        fi
        if centosversion 6; then
            chkconfig --add rngd
            chkconfig rngd on
            service rngd start > /dev/null 2>&1
        elif centosversion 7 || centosversion 8; then
            systemctl enable rngd
            systemctl start rngd > /dev/null 2>&1
        elif check_sys sysRelease debian; then
            update-rc.d -f rng-tools defaults
            sed -i '/^HRNGDEVICE/'d /etc/default/rng-tools
            echo "HRNGDEVICE=/dev/urandom" >> /etc/default/rng-tools
            systemctl start rng-tools > /dev/null 2>&1
        fi
        sleep 5
        local ENTROPY_SIZE_BEHIND=$(cat /proc/sys/kernel/random/entropy_avail)
        echo -e "${Info} 安装rng-tools之后熵池的熵值为${Green}${ENTROPY_SIZE_BEHIND}${suffix}"
    else
        echo -e "${Info} 当前熵池熵值大于或等于1000，未进行更多添加."
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
    echo -n $1 | sed 's/:/%3A/g;s/;/%3B/g;s/=/%3D/g;s/\//%2F/g'
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

gen_credentials_cca(){
    local domain=$1
    if [[ ${domainType} = Other ]]; then
        cerPath="/etc/simple-tls/${domain}.cert"
        keyPath="/etc/simple-tls/${domain}.key"
        if [ ! -d "$(dirname ${cerPath})" ]; then
            mkdir -p $(dirname ${cerPath})
        fi
        simple-tls -gen-cert -n ${domain} -key ${keyPath} -cert ${cerPath}
        base64Cert=$(cat ${cerPath} | base64 -w0 | sed 's/=//g')
    fi
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

download_service_file(){
    local filename_path=$1
    local online_centos_url=$2
    local local_centos_file_path=$3
    local online_debian_url=$4
    local local_debian_file_path=$5
    
    if check_sys packageManager yum; then
        if [[ ${methods} == "Online" ]]; then
            download ${filename_path} ${online_centos_url}
        else
            cp -rf ${local_centos_file_path} ${filename_path}
        fi
    elif check_sys packageManager apt; then
        if [[ ${methods} == "Online" ]]; then
            download ${filename_path} ${online_debian_url}
        else
            cp -rf ${local_debian_file_path} ${filename_path}
        fi
    fi
}

download_ss_file(){
    cd ${CUR_DIR}
    if [[ ${SS_VERSION} = "ss-libev" ]]; then
        # Download Shadowsocks-libev
        libev_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/shadowsocks/shadowsocks-libev/releases | grep -o '"tag_name": ".*"' | head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${libev_ver} ] && echo -e "${Error} 获取 shadowsocks-libev 最新版本失败." && exit 1
        local SS_INIT_CENTOS="./service/shadowsocks-libev_centos.sh"
        local SS_INIT_DEBIAN="./service/shadowsocks-libev_debian.sh"
        
        shadowsocks_libev_file="shadowsocks-libev-${libev_ver}"
        shadowsocks_libev_url="https://github.com/shadowsocks/shadowsocks-libev/releases/download/v${libev_ver}/shadowsocks-libev-${libev_ver}.tar.gz"
        download "${shadowsocks_libev_file}.tar.gz" "${shadowsocks_libev_url}"
        download_service_file ${SHADOWSOCKS_LIBEV_INIT} ${SHADOWSOCKS_LIBEV_CENTOS} ${SS_INIT_CENTOS} ${SHADOWSOCKS_LIBEV_DEBIAN} ${SS_INIT_DEBIAN}
    elif [[ ${SS_VERSION} = "ss-rust" ]]; then
        # Download Shadowsocks-rust
        rust_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/shadowsocks/shadowsocks-rust/releases | grep -o '"tag_name": ".*"' | head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${rust_ver} ] && echo -e "${Error} 获取 shadowsocks-rust 最新版本失败." && exit 1
        local SS_INIT_CENTOS="./service/shadowsocks-rust_centos.sh"
        local SS_INIT_DEBIAN="./service/shadowsocks-rust_debian.sh"
        
        shadowsocks_rust_file="shadowsocks-v${rust_ver}.x86_64-unknown-linux-musl"
        shadowsocks_rust_url="https://github.com/shadowsocks/shadowsocks-rust/releases/download/v${rust_ver}/shadowsocks-v${rust_ver}.x86_64-unknown-linux-musl.tar.xz"
        download "${shadowsocks_rust_file}.tar.xz" "${shadowsocks_rust_url}"
        download_service_file ${SHADOWSOCKS_RUST_INIT} ${SHADOWSOCKS_RUST_CENTOS} ${SS_INIT_CENTOS} ${SHADOWSOCKS_RUST_DEBIAN} ${SS_INIT_DEBIAN}
    elif [[ ${SS_VERSION} = "go-ss2" ]]; then
        # Download Go-shadowsocks2
        go_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/shadowsocks/go-shadowsocks2/releases | grep -o '"tag_name": ".*"' | head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${go_ver} ] && echo -e "${Error} 获取 shadowsocks-rust 最新版本失败." && exit 1
        local SS_INIT_CENTOS="./service/go-shadowsocks2_centos.sh"
        local SS_INIT_DEBIAN="./service/go-shadowsocks2_debian.sh"

        # wriet version num
        if [ ! -d "$(dirname ${GO_SHADOWSOCKS2_VERSION_FILE})" ]; then
            mkdir -p $(dirname ${GO_SHADOWSOCKS2_VERSION_FILE})
        fi
        echo ${go_ver} > ${GO_SHADOWSOCKS2_VERSION_FILE}
        go_shadowsocks2_file="shadowsocks2-linux"
        go_shadowsocks2_url="https://github.com/shadowsocks/go-shadowsocks2/releases/download/v${go_ver}/shadowsocks2-linux.gz"
        download "${go_shadowsocks2_file}.gz" "${go_shadowsocks2_url}"
        download_service_file ${GO_SHADOWSOCKS2_INIT} ${GO_SHADOWSOCKS2_CENTOS} ${SS_INIT_CENTOS} ${GO_SHADOWSOCKS2_DEBIAN} ${SS_INIT_DEBIAN}
    fi
}

download_plugins_file(){
    cd ${CUR_DIR}
    if [[ "${plugin_num}" == "1" ]]; then        
        # Download v2ray-plugin
        v2ray_plugin_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/teddysun/v2ray-plugin/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${v2ray_plugin_ver} ] && echo -e "${Error} 获取 v2ray-plugin 最新版本失败." && exit 1
        v2ray_plugin_file="v2ray-plugin-linux-amd64-v${v2ray_plugin_ver}"
        v2ray_plugin_url="https://github.com/teddysun/v2ray-plugin/releases/download/v${v2ray_plugin_ver}/v2ray-plugin-linux-amd64-v${v2ray_plugin_ver}.tar.gz"
        download "${v2ray_plugin_file}.tar.gz" "${v2ray_plugin_url}"
        
    elif [[ "${plugin_num}" == "2" ]]; then        
        # Download kcptun
        kcptun_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/xtaci/kcptun/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${kcptun_ver} ] && echo -e "${Error} 获取 kcptun 最新版本失败." && exit 1
        kcptun_file="kcptun-linux-amd64-${kcptun_ver}"
        kcptun_url="https://github.com/xtaci/kcptun/releases/download/v${kcptun_ver}/kcptun-linux-amd64-${kcptun_ver}.tar.gz"
        download "${kcptun_file}.tar.gz" "${kcptun_url}"
        download_service_file ${KCPTUN_INIT} ${KCPTUN_CENTOS} "./service/kcptun_centos.sh" ${KCPTUN_DEBIAN} "./service/kcptun_debian.sh"
        
    elif [[ "${plugin_num}" == "4" ]]; then        
        # Download goquiet
        goquiet_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/cbeuw/GoQuiet/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${goquiet_ver} ] && echo -e "${Error} 获取 goquiet 最新版本失败." && exit 1
        goquiet_file="gq-server-linux-amd64-${goquiet_ver}"
        goquiet_url="https://github.com/cbeuw/GoQuiet/releases/download/v${goquiet_ver}/gq-server-linux-amd64-${goquiet_ver}"
        download "${goquiet_file}" "${goquiet_url}"
        
    elif [[ "${plugin_num}" == "5" ]]; then
        # Download cloak server
        cloak_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/cbeuw/Cloak/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${cloak_ver} ] && echo -e "${Error} 获取 cloak 最新版本失败." && exit 1
        # cloak_ver="2.1.1"
        cloak_file="ck-server-linux-amd64-${cloak_ver}"
        cloak_url="https://github.com/cbeuw/Cloak/releases/download/v${cloak_ver}/ck-server-linux-amd64-${cloak_ver}"
        download "${cloak_file}" "${cloak_url}"
        download_service_file ${CLOAK_INIT} ${CLOAK_CENTOS} "./service/cloak_centos.sh" ${CLOAK_DEBIAN} "./service/cloak_debian.sh"
    
    elif [[ "${plugin_num}" == "6" ]]; then
        # Download mos-tls-tunnel
        mtt_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/IrineSistiana/mos-tls-tunnel/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${mtt_ver} ] && echo -e "${Error} 获取 mos-tls-tunnel 最新版本失败." && exit 1
        # wriet version num
        if [ ! -d "$(dirname ${SHADOWSOCKS_CONFIG})" ]; then
            mkdir -p $(dirname ${SHADOWSOCKS_CONFIG})
        fi
        echo ${mtt_ver} > ${MTT_VERSION_FILE}
        mtt_file="mos-tls-tunnel-linux-amd64"
        mtt_url="https://github.com/IrineSistiana/mos-tls-tunnel/releases/download/v${mtt_ver}/mos-tls-tunnel-linux-amd64.zip"
        download "${mtt_file}.zip" "${mtt_url}"
    elif [[ "${plugin_num}" == "7" ]]; then
        # Download rabbit-tcp
        rabbit_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/ihciah/rabbit-tcp/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${rabbit_ver} ] && echo -e "${Error} 获取 rabbit-tcp 最新版本失败." && exit 1
        # wriet version num
        if [ ! -d "$(dirname ${RABBIT_VERSION_FILE})" ]; then
            mkdir -p $(dirname ${RABBIT_VERSION_FILE})
        fi
        echo ${rabbit_ver} > ${RABBIT_VERSION_FILE}
        rabbit_file="rabbit-linux-amd64"
        rabbit_url="https://github.com/ihciah/rabbit-tcp/releases/download/v${rabbit_ver}/rabbit-linux-amd64.gz"
        download "${rabbit_file}.gz" "${rabbit_url}"
        download_service_file ${RABBIT_INIT} ${RABBIT_CENTOS} "./service/rabbit-tcp_centos.sh" ${RABBIT_DEBIAN} "./service/rabbit-tcp_debian.sh"
    elif [[ "${plugin_num}" == "8" ]]; then
        # Download simple-tls
        simple_tls_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/IrineSistiana/simple-tls/releases | grep -o '"tag_name": ".*"' | head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${simple_tls_ver} ] && echo -e "${Error} 获取 simple-tls 最新版本失败." && exit 1
        simple_tls_ver="0.3.4"
        # wriet version num
        if [ ! -d "$(dirname ${SIMPLE_TLS_VERSION_FILE})" ]; then
            mkdir -p $(dirname ${SIMPLE_TLS_VERSION_FILE})
        fi
        echo ${simple_tls_ver} > ${SIMPLE_TLS_VERSION_FILE}
        simple_tls_file="simple-tls-linux-amd64"
        simple_tls_url="https://github.com/IrineSistiana/simple-tls/releases/download/v${simple_tls_ver}/simple-tls-linux-amd64.zip"
        download "${simple_tls_file}.zip" "${simple_tls_url}"
    fi
}

error_detect_deps_of_ubuntu(){
    local command=$1
    local depend=$2

    if [ ! "$(command -v killall)" ]; then
        # psmisc contains killall & fuser & pstree commands.
        package_install "psmisc" > /dev/null 2>&1
    fi
    sleep 3
    sudo killall -q apt apt-get
    ${command} > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo -e "${Error} 依赖包${Red}${depend}${suffix}安装失败，请检查. "
        echo "Checking the error message and run the script again."
        exit 1
    fi
}

error_asciidos_deps_of_ubuntu1901(){
    local command=$1
    local depend=$2

    sleep 3
    sudo dpkg --configure -a > /dev/null 2>&1
    ${command} > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        if ls -l /var/lib/dpkg/info | grep -qi 'python-sympy'; then
            sudo mv -f /var/lib/dpkg/info/python-sympy.* /tmp
            sudo apt update > /dev/null 2>&1
        fi
        ${command} > /dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo -e "${Error} 依赖包${Red}${depend}${suffix}安装失败，请检查. "
            echo "Checking the error message and run the script again."
            exit 1
        fi
    fi
}

error_detect_depends(){
    local command=$1
    local depend=`echo "${command}" | awk '{print $4}'`
    echo -e "${Info} 开始安装依赖包 ${depend}"
    ${command} > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        if check_sys sysRelease ubuntu || check_sys sysRelease debian; then
            if [ $(get_version) == '19.10' ] && [ ${depend} == 'asciidoc' ]; then
                  error_asciidos_deps_of_ubuntu1901 "${command}" "${depend}"
            else
                  error_detect_deps_of_ubuntu "${command}" "${depend}"
            fi
        else
            echo -e "${Error} 依赖包${Red}${depend}${suffix}安装失败，请检查. "
            echo "Checking the error message and run the script again."
            exit 1
        fi
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
            gettext gcc pcre pcre-devel autoconf libtool automake make asciidoc xmlto c-ares-devel libev-devel zlib-devel openssl-devel git qrencode jq
        )
        for depend in ${yum_depends[@]}; do
            error_detect_depends "yum -y install ${depend}"
        done
    elif check_sys packageManager apt; then
        apt_depends=(
            gettext gcc build-essential autoconf libtool libpcre3-dev asciidoc xmlto libev-dev libc-ares-dev automake libssl-dev git qrencode jq
        )

        apt-get -y update
        for depend in ${apt_depends[@]}; do
            error_detect_depends "apt-get -y install ${depend}"
        done
    fi
}

install_libsodium(){    
    if [ ! -f /usr/lib/libsodium.a ]; then
        cd ${CUR_DIR}
        echo -e "${Info} 下载${LIBSODIUM_FILE}."
        download "${LIBSODIUM_FILE}.tar.gz" "${LIBSODIUM_URL}"
        echo -e "${Info} 解压${LIBSODIUM_FILE}."
        tar zxf ${LIBSODIUM_FILE}.tar.gz && cd ${LIBSODIUM_FILE}
        echo -e "${Info} 编译安装${LIBSODIUM_FILE}."
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
        cd ${CUR_DIR}
        echo -e "${Info} 下载${MBEDTLS_FILE}."
        download "${MBEDTLS_FILE}-gpl.tgz" "${MBEDTLS_URL}"
        echo -e "${Info} 解压${MBEDTLS_FILE}."
        tar xf ${MBEDTLS_FILE}-gpl.tgz
        cd ${MBEDTLS_FILE}
        echo -e "${Info} 编译安装${MBEDTLS_FILE}."
        make SHARED=1 CFLAGS=-fPIC
        make DESTDIR=/usr install
        if [ $? -ne 0 ]; then
            echo -e "${Error} ${MBEDTLS_FILE} 安装失败."
            install_cleanup
            exit 1
        fi
        echo -e "${Info} ${MBEDTLS_FILE} 安装成功 !"
    else
        echo -e "${Info} ${MBEDTLS_FILE} 已经安装."
    fi
}