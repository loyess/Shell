#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH



base_url="https://github.com/loyess/Shell/tree/test"


source <(curl -sL ${base_url}/utils/constants.sh)
source <(curl -sL ${base_url}/utils/check_tools.sh)
source <(curl -sL ${base_url}/utils/get_tools.sh)
source <(curl -sL ${base_url}/utils/firewall_tools.sh)
source <(curl -sL ${base_url}/utils/dl_tools.sh)
source <(curl -sL ${base_url}/utils/dependencies.sh)


source <(curl -sL ${base_url}/prepare/ss_libev_prepare.sh)
source <(curl -sL ${base_url}/prepare/v2p_prepare.sh)
source <(curl -sL ${base_url}/prepare/kp_prepare.sh)
source <(curl -sL ${base_url}/prepare/obfs_prepare.sh)
source <(curl -sL ${base_url}/prepare/gq_prepare.sh)
source <(curl -sL ${base_url}/prepare/ck_prepare.sh)


source <(curl -sL ${base_url}/tools/shadowsocks_libev_install.sh)
source <(curl -sL ${base_url}/plugins/v2ray_plugin_install.sh)
source <(curl -sL ${base_url}/plugins/kcptun_install.sh)
source <(curl -sL ${base_url}/plugins/simple_obfs_install.sh)
source <(curl -sL ${base_url}/plugins/goquiet_install.sh)
source <(curl -sL ${base_url}/plugins/cloak_install.sh)


source <(curl -sL ${base_url}/templates/write_config.sh)
source <(curl -sL ${base_url}/templates/group_sslink.sh)
source <(curl -sL ${base_url}/templates/show_config.sh)



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
        uid              添加一个新用户 (仅ss + cloak下可用)
        link             生成一个新的SS:// 链接 (仅ss + cloak下可用)
        scan             根据生成的ss:// 链接，在当前终端上，手动生成一个可供扫描的二维码
        help             查看脚本使用说明
        
	EOF

	exit $1
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

install_bbr(){
    download ${BBR_SHELL_FILE} ${BBR_SCRIPT_URL}
    chmod +x ${BBR_SHELL_FILE}
    ./$(basename ${BBR_SHELL_FILE})
    rm -f ${BBR_SHELL_FILE}
    rm -f $(dirname ${BBR_SHELL_FILE})/install_bbr.log
    
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

gen_qr_code(){
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

get_new_ck_sslink(){
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
    ./ss-plugins.sh link <new add user uid>"
        echo
        echo -e " ${Error} 仅支持 ss + cloak 下使用，请确认是否是以该组合形式运行，并且，使用 ./ss-plugins.sh uid 添加过新用户..."
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
        add_a_new_${action}
        ;;
    link)
        get_new_ck_ss${action} "${2}"
        ;;
    scan)
        gen_qr_code "${2}"
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