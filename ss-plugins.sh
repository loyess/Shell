#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH



# shell version
# ====================
SHELL_VERSION="2.5.9"
# ====================


# current path
CUR_DIR=$( pwd )


# base url
methods="Online"
BASE_URL="https://github.com/loyess/Shell/raw/master"
if [ -e plugins ] && [ -e prepare ] && [ -e service ] && [ -e templates ] && [ -e tools ] && [ -e utils ]; then
    methods="Local"
    BASE_URL="." 
fi


# Root permission
[[ $EUID -ne 0 ]] && echo -e "[${Red}Error${suffix}] This script must be run as root!" && exit 1


# Font color and background color
Green="\033[32m" && Red="\033[31m" && Yellow="\033[0;33m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && suffix="\033[0m"
Info="${Green}[信息]${suffix}"
Error="${Red}[错误]${suffix}"
Point="${Red}[提示]${suffix}"
Tip="${Green}[注意]${suffix}"
Warning="${Yellow}[警告]${suffix}"
Separator_1="——————————————————————————————"



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

package_install(){
    local package_name=$1
    
    if check_sys packageManager yum; then
        yum install -y $1 > /dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo -e "${Error} 安装 $1 失败."
            exit 1
        fi
    elif check_sys packageManager apt; then
        apt-get -y update > /dev/null 2>&1
        apt-get -y install $1 > /dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo -e "${Error} 安装 $1 失败."
            exit 1
        fi
    fi
    echo -e "${Info} $1 安装完成."
}

improt_package(){
    local package=$1
    local sh_file=$2
    
    if [ ! "$(command -v curl)" ]; then
        package_install "curl" > /dev/null 2>&1
    fi
    
    if [[ ${methods} == "Online" ]]; then
        source <(curl -sL ${BASE_URL}/${package}/${sh_file})
    else
        cd ${CUR_DIR}
        source ${BASE_URL}/${package}/${sh_file}
    fi
}

config_ss(){
    local server_value="\"0.0.0.0\""

    if get_ipv6; then
        local V=${SS_VERSION}
        local N=${plugin_num}
        if [[ ${V} = "ss-libev" ]] && [[ ${N} = "2" ]] || [[ ${N} = "3" ]] || [[ ${N} == "5" ]] || [[ -z ${N} ]]; then
            server_value="[\"[::0]\",\"0.0.0.0\"]"
        fi
    fi

    if [ ! -d "$(dirname ${SHADOWSOCKS_CONFIG})" ]; then
        mkdir -p $(dirname ${SHADOWSOCKS_CONFIG})
    fi

    # start wriet config
    improt_package "templates" "config_file_templates.sh"

    # Only SS
    if [[ ${plugin_num} == "" ]]; then
        ss_config_standalone
    fi

    # SS + V2ray-plugin
    if [[ ${plugin_num} == "1" ]]; then
        if [[ ${libev_v2ray} == "1" ]]; then
           ss_v2ray_ws_http_config
        elif [[ ${libev_v2ray} == "2" ]]; then    
           ss_v2ray_ws_tls_cdn_config
        elif [[ ${libev_v2ray} == "3" ]]; then
            ss_v2ray_quic_tls_cdn_config
        elif [[ ${libev_v2ray} == "4" ]]; then
            ss_v2ray_ws_tls_web_config
            if [[ ${web_flag} = "1" ]]; then
                caddy_config_none_cdn
            elif [[ ${web_flag} = "2" ]]; then
                mirror_domain=$(echo ${mirror_site} | sed 's/https:\/\///g')
                nginx_config
            fi 
        elif [[ ${libev_v2ray} == "5" ]]; then
            ss_v2ray_ws_tls_web_cdn_config
            if [[ ${web_flag} = "1" ]]; then
                caddy_config_with_cdn
            elif [[ ${web_flag} = "2" ]]; then
                mirror_domain=$(echo ${mirror_site} | sed 's/https:\/\///g')
                nginx_config
            fi 
        fi
        # disable mux
        if [[ ${isDisable} == disable ]] && [[ ${libev_v2ray} != "3" ]]; then
            sed 's/"plugin_opts":"/"plugin_opts":"mux=0;/' -i ${SHADOWSOCKS_CONFIG}
        fi
    fi

    # SS + KcpTun
    if [[ ${plugin_num} == "2" ]]; then
        if [ ! -d "$(dirname ${KCPTUN_CONFIG})" ]; then
            mkdir -p $(dirname ${KCPTUN_CONFIG})
        fi
        ss_config_standalone
        kcptun_config_standalone
    fi

    # SS + Simple-obfs
    if [[ ${plugin_num} == "3" ]]; then
        if [[ ${libev_obfs} == "1" ]]; then
           ss_obfs_http_config
        elif [[ ${libev_obfs} == "2" ]]; then    
           ss_obfs_tls_config
        fi
    fi

    # SS + Goquite
    if [[ ${plugin_num} == "4" ]]; then
        ss_goquiet_config
    fi

    # SS + Cloak
    if [[ ${plugin_num} == "5" ]]; then
        if [ ! -d "$(dirname ${CK_SERVER_CONFIG})" ]; then
            mkdir -p $(dirname ${CK_SERVER_CONFIG})
        fi
        ss_config_standalone
        cloak2_server_config
        cloak2_client_config
    fi

    # SS + Mos-tls-tunnel
    if [[ ${plugin_num} == "6" ]]; then
        if [[ ${libev_mtt} == "1" ]]; then
            if [[ ${domainType} = DNS-Only ]]; then
                ss_mtt_tls_dns_only_config
            else
                ss_mtt_tls_config
            fi
        elif [[ ${libev_mtt} == "2" ]]; then
            if [[ ${isEnableWeb} = disable ]]; then
                ss_mtt_wss_dns_only_or_cdn_config
            elif [[ ${isEnableWeb} = enable ]]; then
                ss_mtt_wss_dns_only_or_cdn_web_config
                domain=${serverName}
                path=${wssPath}
                if [[ ${domainType} = DNS-Only ]] && [[ ${web_flag} = "1" ]]; then
                    caddy_config_none_cdn
                elif [[ ${domainType} = CDN ]] && [[ ${web_flag} = "1" ]]; then
                    caddy_config_with_cdn
                elif [[ ${web_flag} = "2" ]]; then
                    mirror_domain=$(echo ${mirror_site} | sed 's/https:\/\///g')
                    nginx_config
                fi 
            else
                ss_mtt_wss_config
            fi
        fi
        
        if [[ ${isEnable} == enable ]]; then
            sed 's/"plugin_opts":"/"plugin_opts":"mux;/' -i ${SHADOWSOCKS_CONFIG}
        fi
    fi

    # SS + Rabbit-tcp
    if [[ ${plugin_num} == "7" ]]; then
        if [ ! -d "$(dirname ${RABBIT_CONFIG})" ]; then
            mkdir -p $(dirname ${RABBIT_CONFIG})
        fi
        ss_config_standalone
        rabbit_tcp_config_standalone
    fi

    # SS + Simple-tls
    if [[ ${plugin_num} == "8" ]]; then
        if [[ ${libev_simple_tls} == "1" ]]; then
            ss_simple_tls_config
        elif [[ ${libev_simple_tls} == "2" ]]; then
            ss_simple_tls_wss_config
        fi

        if [[ ${isEnable} == enable ]]; then
            sed 's/"plugin_opts":"s/"plugin_opts":"s;rh/' -i ${SHADOWSOCKS_CONFIG}
        fi
    fi
}

gen_ss_links(){
    improt_package "templates" "sip002_url_templates.sh"

    # Only SS
    if [[ ${plugin_num} == "" ]]; then
        ss_link
    fi

    # SS + V2ray-plugin
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
    fi

    # SS + KcpTun
    if [[ ${plugin_num} == "2" ]]; then
        ss_kcptun_link
    fi

    # SS + Simple-obfs
    if [[ ${plugin_num} == "3" ]]; then
        if [[ ${libev_obfs} == "1" ]]; then
           ss_obfs_http_link
        elif [[ ${libev_obfs} == "2" ]]; then    
           ss_obfs_tls_link
        fi
    fi

    # SS + Goquite
    if [[ ${plugin_num} == "4" ]]; then
        ss_goquiet_link
    fi

    # SS + Cloak
    if [[ ${plugin_num} == "5" ]]; then
        ss_cloak_link_new
    fi

    # SS + Mos-tls-tunnel
    if [[ ${plugin_num} == "6" ]]; then
        if [[ ${libev_mtt} == "1" ]]; then
            if [[ ${domainType} = DNS-Only ]]; then
                ss_mtt_tls_dns_only_link
            else
                ss_mtt_tls_link
            fi
        elif [[ ${libev_mtt} == "2" ]]; then
            if [[ ${isEnableWeb} = disable ]]; then
                ss_mtt_wss_dns_only_or_cdn_link
            elif [[ ${isEnableWeb} = enable ]]; then
                ss_mtt_wss_dns_only_or_cdn_web_link
            else
                ss_mtt_wss_link
            fi
        fi
    fi

    # SS + Rabbit-tcp
    if [[ ${plugin_num} == "7" ]]; then
        ss_rabbit_tcp_link
    fi

    # SS + Simple-tls
    if [[ ${plugin_num} == "8" ]]; then
        if [[ ${libev_simple_tls} == "1" ]]; then
            ss_simple_tls_link
        elif [[ ${libev_simple_tls} == "2" ]]; then
            ss_simple_tls_wss_link
        fi
    fi
}

install_completed(){
    ldconfig
    if [[ ${SS_VERSION} = "ss-libev" ]]; then
        ${SHADOWSOCKS_LIBEV_INIT} start > /dev/null 2>&1
    elif [[ ${SS_VERSION} = "ss-rust" ]]; then
        ${SHADOWSOCKS_RUST_INIT} start > /dev/null 2>&1
    elif [[ ${SS_VERSION} = "go-ss2" ]]; then
        ${GO_SHADOWSOCKS2_INIT} start > /dev/null 2>&1
    fi
    
    clear -x
    
    improt_package "templates" "terminal_config_templates.sh"

    # Only SS
    if [[ ${plugin_num} == "" ]]; then
        ss_show
    fi

    # SS + V2ray-plugin
    if [[ ${plugin_num} == "1" ]]; then
        if [[ ${libev_v2ray} == "1" ]]; then
            ss_v2ray_ws_http_show
        elif [[ ${libev_v2ray} == "2" ]]; then
            ss_v2ray_ws_tls_cdn_show
        elif [[ ${libev_v2ray} == "3" ]]; then
            ss_v2ray_quic_tls_cdn_show
        elif [[ ${libev_v2ray} == "4" ]]; then
            if [[ ${web_flag} = "1" ]]; then
                # start caddy
                /etc/init.d/caddy start > /dev/null 2>&1
            elif [[ ${web_flag} = "2" ]]; then
                systemctl start nginx
            fi 
            ss_v2ray_ws_tls_web_show
        elif [[ ${libev_v2ray} == "5" ]]; then
            if [[ ${web_flag} = "1" ]]; then
                /etc/init.d/caddy start > /dev/null 2>&1
            elif [[ ${web_flag} = "2" ]]; then
                systemctl start nginx
            fi 
            ss_v2ray_ws_tls_web_cdn_show
        fi
    fi

    if [[ ${plugin_num} == "2" ]]; then
        ${KCPTUN_INIT} start  > /dev/null 2>&1
        ss_kcptun_show
    fi

    # SS + Simple-obfs
    if [[ ${plugin_num} == "3" ]]; then
        if [[ ${libev_obfs} == "1" ]]; then
           ss_obfs_http_show
        elif [[ ${libev_obfs} == "2" ]]; then    
           ss_obfs_tls_show
        fi
    fi

    # SS + Goquite
    if [[ ${plugin_num} == "4" ]]; then
        ss_goquiet_show
    fi

    # SS + Cloak
    if [[ ${plugin_num} == "5" ]]; then
        ${CLOAK_INIT} start  > /dev/null 2>&1
        ss_cloak_show_new
    fi

    # SS + Mos-tls-tunnel
    if [[ ${plugin_num} == "6" ]]; then
        if [[ ${libev_mtt} == "1" ]]; then
            if [[ ${domainType} = DNS-Only ]]; then
                ss_mtt_tls_dns_only_show
            else
                ss_mtt_tls_show
            fi
        elif [[ ${libev_mtt} == "2" ]]; then
            if [[ ${isEnableWeb} = disable ]]; then
                ss_mtt_wss_dns_only_or_cdn_show
            elif [[ ${isEnableWeb} = enable ]]; then
                if [[ ${web_flag} = "1" ]]; then
                    # start caddy
                    /etc/init.d/caddy start > /dev/null 2>&1
                elif [[ ${web_flag} = "2" ]]; then
                    systemctl start nginx
                fi 
                ss_mtt_wss_dns_only_or_cdn_web_show
            else
                ss_mtt_wss_show
            fi
        fi
    fi

    # SS + Rabbit-tcp
    if [[ ${plugin_num} == "7" ]]; then
        ${RABBIT_INIT} start  > /dev/null 2>&1
        ss_rabbit_tcp_show
    fi

    # SS + Simple-tls
    if [[ ${plugin_num} == "8" ]]; then
        if [[ ${libev_simple_tls} == "1" ]]; then
            ss_simple_tls_show
        elif [[ ${libev_simple_tls} == "2" ]]; then
            ss_simple_tls_wss_show
        fi
    fi
}

install_prepare(){
    improt_package "prepare" "shadowsocks_prepare.sh"
    choose_ss_install_version
    install_prepare_port
    install_prepare_password
    install_prepare_cipher
    echo && echo -e "请选择要安装的SS插件
    
  ${Green}1.${suffix} v2ray-plugin
  ${Green}2.${suffix} kcptun
  ${Green}3.${suffix} simple-obfs
  ${Green}4.${suffix} goquiet (unofficial)
  ${Green}5.${suffix} cloak (based goquiet)
  ${Green}6.${suffix} mos-tls-tunnel
  ${Green}7.${suffix} rabbit-tcp
  ${Green}8.${suffix} simple-tls
  "
    echo && read -e -p "(默认: 不安装)：" plugin_num
    [[ -z "${plugin_num}" ]] && plugin_num="" && echo -e "\n${Tip} 当前未选择任何插件，仅安装${SS_VERSION}."
    if [[ ${plugin_num} == "1" ]]; then
        improt_package "prepare" "v2ray_plugin_prepare.sh"
        install_prepare_libev_v2ray
    elif [[ ${plugin_num} == "2" ]]; then
        improt_package "prepare" "kcptun_prepare.sh"
        install_prepare_libev_kcptun
    elif [[ ${plugin_num} == "3" ]]; then
        improt_package "prepare" "simple_obfs_prepare.sh"
        install_prepare_libev_obfs
    elif [[ ${plugin_num} == "4" ]]; then
        improt_package "prepare" "goquiet_prepare.sh"
        install_prepare_libev_goquiet
    elif [[ ${plugin_num} == "5" ]]; then
        improt_package "prepare" "cloak_prepare.sh"
        install_prepare_libev_cloak
    elif [[ ${plugin_num} == "6" ]]; then
        improt_package "prepare" "mos_tls_tunnel_prepare.sh"
        install_prepare_libev_mos_tls_tunnel
    elif [[ ${plugin_num} == "7" ]]; then
        improt_package "prepare" "rabbit_tcp_prepare.sh"
        install_prepare_libev_rabbit_tcp
    elif [[ ${plugin_num} == "8" ]]; then
        improt_package "prepare" "simple_tls_prepare.sh"
        install_prepare_libev_simple_tls
    elif [[ ${plugin_num} == "" ]]; then
        :
    else
        echo -e "${Error} 请输入正确的数字 [1-7]" && exit 1
    fi
    
    echo
    echo "按任意键开始…或按Ctrl+C取消"
    char=`get_char`
    
    if [[ ${SS_VERSION} = "ss-rust" ]] || [[ ${SS_VERSION} = "go-ss2" ]] && [[ "${plugin_num}" != "3" ]]; then
        echo
        echo -e "${Info} 即将开始下载相关文件请稍等."
    fi
}

install_main(){
    if [[ ${SS_VERSION} = "ss-libev" ]]; then
        install_libsodium
        if ! ldconfig -p | grep -wq "/usr/lib"; then
            echo "/usr/lib" > /etc/ld.so.conf.d/lib.conf
        fi
        ldconfig
        install_mbedtls
    fi
    
    improt_package "tools" "shadowsocks_install.sh"
    if [[ ${SS_VERSION} = "ss-libev" ]]; then
        install_shadowsocks_libev
    elif [[ ${SS_VERSION} = "ss-rust" ]]; then
        install_shadowsocks_rust
    elif [[ ${SS_VERSION} = "go-ss2" ]]; then
        install_go_shadowsocks2
    fi
    
    if [ "${plugin_num}" == "1" ]; then
        improt_package "plugins" "v2ray_plugin_install.sh"
        install_v2ray_plugin
        if [[ ${web_flag} = "1" ]]; then
            choose_caddy_extension ${libev_v2ray}
        elif [[ ${web_flag} = "2" ]]; then
            improt_package "tools" "nginx_install.sh"
            install_nginx
        fi
        plugin_client_name="v2ray-plugin"
    elif [ "${plugin_num}" == "2" ]; then
        improt_package "plugins" "kcptun_install.sh"
        install_kcptun
        plugin_client_name="kcptun"
    elif [ "${plugin_num}" == "3" ]; then
        improt_package "plugins" "simple_obfs_install.sh"
        install_simple_obfs
        plugin_client_name="obfs-local"
    elif [ "${plugin_num}" == "4" ]; then
        improt_package "plugins" "goquiet_install.sh"
        install_goquiet
        plugin_client_name="gq-client"
    elif [ "${plugin_num}" == "5" ]; then
        improt_package "plugins" "cloak_install.sh"
        install_cloak
        gen_credentials
        plugin_client_name="ck-client"
    elif [ "${plugin_num}" == "6" ]; then
        improt_package "plugins" "mos_tls_tunnel_install.sh"
        install_mos_tls_tunnel
        if [[ ${web_flag} = "1" ]]; then
            improt_package "tools" "caddy_install.sh"
            if [[ ${domainType} = DNS-Only ]] && [[ ${isEnableWeb} = enable ]]; then
                install_caddy
            elif [[ ${domainType} = CDN ]] && [[ ${isEnableWeb} = enable ]]; then
                install_caddy "tls.dns.cloudflare"
            fi
        elif [[ ${web_flag} = "2" ]]; then
            improt_package "tools" "nginx_install.sh"
            install_nginx
        fi
        plugin_client_name="mostlstunnel"
    elif [ "${plugin_num}" == "7" ]; then
        improt_package "plugins" "rabbit_tcp_install.sh"
        install_rabbit_tcp
        plugin_client_name="rabbit-plugin"
    elif [ "${plugin_num}" == "8" ]; then
        improt_package "plugins" "simple_tls_install.sh"
        install_simple_tls
        gen_credentials_cca "${serverName}"
        plugin_client_name="simple-tls"
    fi
}

install_step_all(){
    [[ -e ${SHADOWSOCKS_LIBEV_BIN_PATH} ]] && echo -e "${Info} Shadowsocks-libev 已经安装." && exit 1
    [[ -e ${SHADOWSOCKS_RUST_BIN_PATH} ]] && echo -e "${Info} Shadowsocks-rust 已经安装." && exit 1
    [[ -e ${GO_SHADOWSOCKS2_BIN_PATH} ]] && echo -e "${Info} Go-shadowsocks2 已经安装." && exit 1
    disable_selinux
    install_prepare
    if [[ ${SS_VERSION} = "ss-libev" ]]; then
        install_dependencies
    fi
    if [[ ${SS_VERSION} = "ss-rust" ]] || [[ ${SS_VERSION} = "go-ss2" ]]; then
        if [ ! "$(command -v qrencode)" ]; then
            package_install "qrencode" > /dev/null 2>&1
        fi
    fi
    if [[ ${SS_VERSION} = "ss-rust" ]] || [[ ${SS_VERSION} = "go-ss2" ]] && [[ "${plugin_num}" == "3" ]]; then
        install_dependencies
    fi
    if [[ ${SS_VERSION} = "ss-rust" ]] && [[ "${plugin_num}" == "5" ]] || [[ "${plugin_num}" == "7" ]]; then
        if [ ! "$(command -v jq)" ]; then
            package_install "jq" > /dev/null 2>&1
        fi
    fi
    if [[ ${SS_VERSION} = "go-ss2" ]]; then
        if [ ! "$(command -v jq)" ]; then
            package_install "jq" > /dev/null 2>&1
        fi
    fi
    download_ss_file
    download_plugins_file
    config_firewall_logic
    install_main
    add_more_entropy
    install_cleanup
    config_ss
    gen_ss_links
    install_completed
    improt_package "utils" "view_config.sh"
    show_config "all"
}

install_cleanup(){
    cd ${CUR_DIR}
    # ss-libev
    rm -rf ${LIBSODIUM_FILE} ${LIBSODIUM_FILE}.tar.gz
    rm -rf ${MBEDTLS_FILE} ${MBEDTLS_FILE}-gpl.tgz
    rm -rf ${shadowsocks_libev_file} ${shadowsocks_libev_file}.tar.gz
    
    # ss-rust
    rm -rf ${shadowsocks_rust_file}.tar.xz
    
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
    
    # mos-tls-tunnel
    rm -rf ${mtt_file}.zip LICENSE README.md mtt-client

    #simple-tls
    rm -rf ${simple_tls_file}.zip LICENSE  README.md
}

do_uid(){
    if [ "$(command -v ck-server)" ]; then
        improt_package "utils" "ck_user_manager.sh"
        ck2_users_manager
        sleep 0.5
        
        is_the_api_open "stop"
    else
        echo
        echo -e "${Error} 仅支持 ss + cloak 组合下使用，请确认是否是以该组合形式运行."
        echo
    fi
}

do_link(){
    local CK_UID=$1
    
    if [ "$(command -v ck-server)" ]; then
        improt_package "utils" "ck_sslink.sh"
        get_link_of_ck2 "${CK_UID}"
    else
        echo
        echo -e "${Error} 仅支持 ss + cloak 组合下使用，请确认是否是以该组合形式运行."
        echo
    fi
}

do_scan(){
    local SS_URL=$1
    
    improt_package "utils" "qr_code.sh"
    gen_qr_code "${SS_URL}"
}

do_show(){
    improt_package "utils" "view_config.sh"
    show_config "standalone"
}

do_log(){
    improt_package "utils" "view_log.sh"
    show_log
}

do_cert(){
    local domain=$1

    improt_package "utils" "gen_certificates.sh"
    get_domain_ip "${domain}"
    if ! (echo ${domain} | grep -qE '.cf$|.ga$|.gq$|.ml$|.tk$' && is_cdn_proxied "${domain_ip}"); then
        echo
        echo -e "${Error} 此选项为手动申请Cloudflare CDN模式 证书(有效期3个月)，仅支持后缀为.cf .ga .gq .ml .tk的域名。"
        echo
        exit 1
    fi
    acme_get_certificate_by_manual "${domain}" "--force"
}

do_start(){
    if [[ ! "$(command -v ss-server)" ]] && [[ ! "$(command -v ssserver)" ]] && [[ ! "$(command -v go-shadowsocks2)" ]]; then
        echo
        echo -e " ${Red} Shadowsocks 未安装，请尝试安装后，再来执行此操作。${suffix}"
        echo
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
    local mark=$1
    if [ "$(command -v ss-server)" ]; then
        PID=`ps -ef |grep -v grep | grep ss-server |awk '{print $2}'`
        local BIN_PATH=${SHADOWSOCKS_LIBEV_BIN_PATH}
        local SS_PID=${PID}
    elif [ "$(command -v ssserver)" ]; then
        RUST_PID=`ps -ef |grep -v grep | grep ssserver |awk '{print $2}'`
        local BIN_PATH=${SHADOWSOCKS_RUST_BIN_PATH}
        local SS_PID=${RUST_PID}
    elif [ "$(command -v go-shadowsocks2)" ]; then
        GO_PID=`ps -ef |grep -v grep | grep go-shadowsocks2 |awk '{print $2}'`
        local BIN_PATH=${GO_SHADOWSOCKS2_BIN_PATH}
        local SS_PID=${GO_PID}
    fi
    
    if [[ ${mark} == "menu" ]]; then
        menu_status ${BIN_PATH} ${SS_PID}
    else
        if [[ ! -e ${BIN_PATH} ]]; then
            echo
            echo -e "${Error} shadowsocks and related plugins are not installed."
            echo
            exit 1
        fi
        
        improt_package "utils" "status.sh"
        other_status
    fi
}

do_update(){
    cd ${CUR_DIR}
    
    improt_package "utils" "update.sh"
    
    if [[ -e ${SHADOWSOCKS_LIBEV_BIN_PATH} ]]; then
        update_shadowsocks_libev
    elif [[ -e ${SHADOWSOCKS_RUST_BIN_PATH} ]]; then
        update_shadowsocks_rust
    elif [[ -e ${GO_SHADOWSOCKS2_BIN_PATH} ]]; then
        update_go_shadowsocks2
    fi
}

do_uninstall(){
    printf "你确定要卸载Shadowsocks吗? [y/n]\n"
    read -e -p "(默认: n):" answer
    [ -z ${answer} ] && answer="n"
    if [ "${answer}" != "y" ] && [ "${answer}" != "Y" ]; then
        echo
        echo -e "${Info} Shadowsocks 卸载取消."
        echo
        exit 1
    fi
    
    # start uninstall
    improt_package "utils" "uninstall.sh"
    uninstall_services
    echo -e "${Info} Shadowsocks 卸载成功."
}

do_install(){
    local FLAG
    
    # check supported
    if ! install_check; then
        echo -e "[${Red}Error${suffix}] Your OS is not supported to run it!"
        echo "Please change to CentOS 6+/Debian 7+/Ubuntu 12+ and try again."
        exit 1
    fi
    
    if [[ -e ${SHADOWSOCKS_LIBEV_BIN_PATH} ]]; then
        FLAG="Shadowsocks-libev"
    elif [[ -e ${SHADOWSOCKS_RUST_BIN_PATH} ]]; then
        FLAG="Shadowsocks-rust"
    elif [[ -e ${GO_SHADOWSOCKS2_BIN_PATH} ]]; then
        FLAG="Go-shadowsocks2"
    else
        FLAG="Shadowsocks"
    fi
    
    echo -e " ${FLAG}一键脚本 ${Red}[v${SHELL_VERSION} ${methods}]${suffix}

    ${Green}1.${suffix} BBR
    ${Green}2.${suffix} Install
    ${Green}3.${suffix} Uninstall
     "
    do_status "menu"
    echo && read -e -p "请输入数字 [1-3]：" menu_num
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
            echo -e "${Error} 请输入正确的数字 [1-3]"
            ;;
    esac
}



# install and tools
action=${1:-"install"}

improt_package "utils" "constants.sh"
improt_package "utils" "common.sh"

case ${action} in
    install|uninstall|update|start|stop|restart)
        do_${action}
        ;;
    status)
        do_${action} "status"
        ;;
    script)
        check_script_update
        ;;
    uid)
        do_${action} 
        ;;
    link)
        do_${action}  "${2}"
        ;;
    scan)
        do_${action}  "${2}"
        ;;
    show)
        do_${action}
        ;;
    log)
        do_${action}
        ;;
    cert)
        do_${action} "${2}"
        ;;
    help)
        usage 0
        ;;
    *)
        usage 1
        ;;
esac