improt_package "utils" "downloads.sh"


update_v2ray_plugin(){
    cd ${CUR_DIR}
    
    if [[ -e ${V2RAY_PLUGIN_BIN_PATH} ]]; then
        v2ray_plugin_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/teddysun/v2ray-plugin/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${v2ray_plugin_ver} ] && echo -e "${Error} 获取 v2ray-plugin 最新版本失败." && exit 1
        current_v2ray_plugin_ver=$(v2ray-plugin -version | grep v2ray-plugin | cut -d\  -f2 | sed 's/v//g')
        
        if ! $(v2ray-plugin -version > /dev/null 2>&1); then
            local plugin_num="1"
            echo -e "${Info} 检测到v2ray-plugin有新版本，开始下载."
            download_plugins_file
            echo -e "${Info} 下载完成，开始安装."
            improt_package "plugins" "v2ray_plugin_install.sh"
            do_stop > /dev/null 2>&1
            install_v2ray_plugin
            do_restart > /dev/null 2>&1
            
            echo -e "${Info} v2ray-plugin已成功升级为最新版本${v2ray_plugin_ver}"
            if [[ ! -e ${CADDY_BIN_PATH} ]]; then
                echo
                exit 1
            fi
            
            install_cleanup
            
            update_caddy
            
            exit 0
        fi
        
        if ! check_latest_version ${current_v2ray_plugin_ver} ${v2ray_plugin_ver}; then
            echo -e "${Point} v2ray-plugin当前已是最新版本${current_v2ray_plugin_ver}不需要更新."
            if [[ ! -e ${CADDY_BIN_PATH} ]]; then
                echo
                exit 1
            fi
            
            update_caddy
            
            exit 1
        fi
        
        local plugin_num="1"
        echo -e "${Info} 检测到v2ray-plugin有新版本，开始下载."
        download_plugins_file
        echo -e "${Info} 下载完成，开始安装."
        improt_package "plugins" "v2ray_plugin_install.sh"
        do_stop > /dev/null 2>&1
        install_v2ray_plugin
        do_restart > /dev/null 2>&1
        
        echo -e "${Info} v2ray-plugin已成功升级为最新版本${v2ray_plugin_ver}"
        if [[ ! -e ${CADDY_BIN_PATH} ]]; then
            echo
            exit 1
        fi
        
        install_cleanup
        
        update_caddy
    fi
}

update_kcptun(){
    cd ${CUR_DIR}
    
    if [[ -e ${KCPTUN_BIN_PATH} ]]; then
        kcptun_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/xtaci/kcptun/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${kcptun_ver} ] && echo -e "${Error} 获取 kcptun 最新版本失败." && exit 1
        current_kcptun_ver=$(kcptun-server -v | grep kcptun | cut -d\  -f3)
        if ! check_latest_version ${current_kcptun_ver} ${kcptun_ver}; then
            echo -e "${Point} kcptun当前已是最新版本${current_kcptun_ver}不需要更新."
            echo
            exit 1
        fi
        
        local plugin_num="2"
        echo -e "${Info} 检测到kcptun有新版本，开始下载."
        download_plugins_file
        echo -e "${Info} 下载完成，开始安装."
        improt_package "plugins" "kcptun_install.sh"
        do_stop > /dev/null 2>&1
        install_kcptun
        do_restart > /dev/null 2>&1
        
        echo -e "${Info} kcptun已成功升级为最新版本${kcptun_ver}"
        echo
        
        install_cleanup
    fi
}

update_simple_obfs(){
    cd ${CUR_DIR}
    
    if [[ -e ${SIMPLE_OBFS_BIN_PATH} ]]; then
        simple_obfs_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/shadowsocks/simple-obfs/releases | grep -o '"tag_name": ".*"' | head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${simple_obfs_ver} ] && echo -e "${Error} 获取 simple-obfs 最新版本失败." && exit 1
        current_simple_obfs_ver=$(obfs-server | grep simple-obfs | cut -d\  -f2)
        if ! check_latest_version ${current_simple_obfs_ver} ${simple_obfs_ver}; then
            echo -e "${Point} simple-obfs当前已是最新版本${current_simple_obfs_ver}不需要更新."
            echo
            exit 1
        fi
        improt_package "plugins" "simple_obfs_install.sh"
        echo -e "${Info} 检测到simple-obfs有新版本，开始下载并进行编译安装."
        do_stop > /dev/null 2>&1
        install_simple_obfs
        do_restart > /dev/null 2>&1
        
        echo -e "${Info} simple-obfs已成功升级为最新版本${simple_obfs_ver}"
        echo
        
        install_cleanup
    fi
}

update_goquiet(){
    cd ${CUR_DIR}
    
    if [[ -e ${GOQUIET_BIN_PATH} ]]; then
        goquiet_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/cbeuw/GoQuiet/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${goquiet_ver} ] && echo -e "${Error} 获取 goquiet 最新版本失败." && exit 1
        current_goquiet_ver=$(gq-server -v | grep gq-server | cut -d\  -f2)
        if ! check_latest_version ${current_goquiet_ver} ${goquiet_ver}; then
            echo -e "${Point} goquiet当前已是最新版本${current_goquiet_ver}不需要更新."
            echo
            exit 1
        fi
        
        local plugin_num="4"
        echo -e "${Info} 检测到goquiet有新版本，开始下载."
        download_plugins_file
        echo -e "${Info} 下载完成，开始安装."
        improt_package "plugins" "goquiet_install.sh"
        do_stop > /dev/null 2>&1
        install_goquiet
        do_restart > /dev/null 2>&1

        echo -e "${Info} goquiet已成功升级为最新版本${goquiet_ver}"
        echo
        
        install_cleanup
    fi
}

update_cloak(){
    cd ${CUR_DIR}
    
    if [[ -e ${CLOAK_SERVER_BIN_PATH} ]]; then
        cloak_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/cbeuw/Cloak/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${cloak_ver} ] && echo -e "${Error} 获取 cloak 最新版本失败." && exit 1
        current_cloak_ver=$(ck-server -v | grep ck-server | cut -d\  -f2 | sed 's/v//g')
        if ! check_latest_version ${current_cloak_ver} ${cloak_ver}; then
            echo -e "${Point} cloak当前已是最新版本${current_cloak_ver}不需要更新."
            echo
            exit 1
        fi
        
        local plugin_num="5"
        echo -e "${Info} 检测到cloak有新版本，开始下载."
        download_plugins_file
        echo -e "${Info} 下载完成，开始安装."
        improt_package "plugins" "cloak_install.sh"
        do_stop > /dev/null 2>&1
        install_cloak
        do_restart > /dev/null 2>&1
        
        echo -e "${Info} cloak已成功升级为最新版本${cloak_ver}"
        echo
        
        install_cleanup
    fi
}

update_mtt(){
    cd ${CUR_DIR}
    
    if [[ -e ${MTT_BIN_PATH} ]]; then
        mtt_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/IrineSistiana/mos-tls-tunnel/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${mtt_ver} ] && echo -e "${Error} 获取 mos-tls-tunnel 最新版本失败." && exit 1
        read current_mtt_ver < ${MTT_VERSION_FILE}
        if ! check_latest_version ${current_mtt_ver} ${mtt_ver}; then
            echo -e "${Point} mos-tls-tunnel当前已是最新版本${current_mtt_ver}不需要更新."
            if [[ ! -e ${CADDY_BIN_PATH} ]]; then
                echo
                exit 1
            fi
            update_caddy
            exit 0
        fi
        
        local plugin_num="6"
        echo -e "${Info} 检测到mos-tls-tunnel有新版本，开始下载."
        download_plugins_file
        echo -e "${Info} 下载完成，开始安装."
        improt_package "plugins" "mos_tls_tunnel_install.sh"
        do_stop > /dev/null 2>&1
        install_mos_tls_tunnel
        do_restart > /dev/null 2>&1

        echo -e "${Info} mos-tls-tunnel已成功升级为最新版本${mtt_ver}"
        echo
        
        install_cleanup
        update_caddy
    fi
}

update_rabbit_tcp(){
    cd ${CUR_DIR}
    
    if [[ -e ${RABBIT_BIN_PATH} ]]; then
        rabbit_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/ihciah/rabbit-tcp/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${rabbit_ver} ] && echo -e "${Error} 获取 rabbit-tcp 最新版本失败." && exit 1
        read current_rabbit_ver < ${RABBIT_VERSION_FILE}
        if ! check_latest_version ${current_rabbit_ver} ${rabbit_ver}; then
            echo -e "${Point} rabbit-tcp当前已是最新版本${current_rabbit_ver}不需要更新."
            echo
            exit 1
        fi
        
        local plugin_num="7"
        echo -e "${Info} 检测到rabbit-tcp有新版本，开始下载."
        download_plugins_file
        echo -e "${Info} 下载完成，开始安装."
        improt_package "plugins" "rabbit_tcp_install.sh"
        do_stop > /dev/null 2>&1
        install_rabbit_tcp
        do_restart > /dev/null 2>&1

        echo -e "${Info} rabbit-tcp已成功升级为最新版本${rabbit_ver}"
        echo
        
        install_cleanup
    fi
}

update_simple_tls(){
    cd ${CUR_DIR}

    if [[ -e ${SIMPLE_TLS_BIN_PATH} ]]; then
        simple_tls_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/IrineSistiana/simple-tls/releases | grep -o '"tag_name": ".*"' | head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${simple_tls_ver} ] && echo -e "${Error} 获取 simple-tls 最新版本失败." && exit 1
        read current_simple_tls_ver < ${SIMPLE_TLS_VERSION_FILE}

        if ! check_latest_version "0.4.7" ${current_simple_tls_ver}; then
            echo -e "${Point} simple-tls当前版本是${current_simple_tls_ver}及以下版本，与最新版本不兼容，脚本不提供更新."
            exit 0
        fi

        if ! check_latest_version ${current_simple_tls_ver} ${simple_tls_ver}; then
            echo -e "${Point} simple-tls当前已是最新版本${current_simple_tls_ver}不需要更新."
            exit 0
        fi

        local plugin_num="8"
        echo -e "${Info} 检测到simple-tls有新版本，开始下载."
        download_plugins_file
        echo -e "${Info} 下载完成，开始安装."
        improt_package "plugins" "simple_tls_install.sh"
        do_stop > /dev/null 2>&1
        install_simple_tls
        do_restart > /dev/null 2>&1

        echo -e "${Info} simple-tls已成功升级为最新版本${simple_tls_ver}"
        echo

        install_cleanup
    fi
}

update_gost_plugin(){
    cd ${CUR_DIR}

    if [[ -e ${GOST_PLUGIN_BIN_PATH} ]]; then
        # gost_plugin_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/maskedeken/gost-plugin/releases | grep -o '"tag_name": ".*"' | head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        gost_plugin_ver="1.6.1"
        [ -z ${gost_plugin_ver} ] && echo -e "${Error} 获取 gost-plugin 最新版本失败." && exit 1
        read current_gost_plugin_ver < ${GOST_PLUGIN_VERSION_FILE}

        if ! check_latest_version ${current_gost_plugin_ver} ${gost_plugin_ver}; then
            echo -e "${Point} gost-plugin当前已是最新版本${current_gost_plugin_ver}不需要更新."
            if [[ ! -e ${CADDY_BIN_PATH} ]]; then
                echo
                exit 1
            fi
            update_caddy
            exit 0
        fi

        local plugin_num="9"
        echo -e "${Info} 检测到gost-plugin有新版本，开始下载."
        download_plugins_file
        echo -e "${Info} 下载完成，开始安装."
        improt_package "plugins" "gost_plugin_install.sh"
        do_stop > /dev/null 2>&1
        install_gost_plugin
        do_restart > /dev/null 2>&1

        echo -e "${Info} gost-plugin已成功升级为最新版本${gost_plugin_ver}"
        echo

        install_cleanup
        update_caddy
    fi
}

update_xray_plugin(){
    cd ${CUR_DIR}

    if [[ -e ${XRAY_PLUGIN_BIN_PATH} ]]; then
        xray_plugin_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/teddysun/xray-plugin/releases | grep -o '"tag_name": ".*"' | head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${xray_plugin_ver} ] && echo -e "${Error} 获取 xray-plugin 最新版本失败." && exit 1
        read current_xray_plugin_ver < ${XRAY_PLUGIN_VERSION_FILE}

        if ! check_latest_version ${current_xray_plugin_ver} ${xray_plugin_ver}; then
            echo -e "${Point} xray-plugin当前已是最新版本${current_xray_plugin_ver}不需要更新."
            if [[ ! -e ${CADDY_BIN_PATH} ]]; then
                echo
                exit 1
            fi
            update_caddy
            exit 0
        fi

        local plugin_num="10"
        echo -e "${Info} 检测到xray-plugin有新版本，开始下载."
        download_plugins_file
        echo -e "${Info} 下载完成，开始安装."
        improt_package "plugins" "xray_plugin_install.sh"
        do_stop > /dev/null 2>&1
        install_xray_plugin
        do_restart > /dev/null 2>&1

        echo -e "${Info} xray-plugin已成功升级为最新版本${xray_plugin_ver}"
        echo

        install_cleanup
        update_caddy
    fi
}

update_caddy_v1(){
    cd ${CUR_DIR}
    
    caddy_ver=$(caddy -version)
    echo -e "${Info} 当前版本：${caddy_ver}"
    read -p "是否强制覆盖安装caddy(默认: n) [y/n]: " yn
    [ -z "${yn}" ] && yn="N"
    case "${yn:0:1}" in
        y|Y)
            do_stop > /dev/null 2>&1
            improt_package "tools" "caddy_install.sh"
            install_caddy
            do_restart > /dev/null 2>&1
            caddy_ver=$(caddy -version)
            echo -e "${Info} 覆盖版本：${caddy_ver}"
            ;;
        n|N)
            echo -e "${Info} 跳过强制安装。"
            ;;
        *)
            echo
            echo -e "${Error} 输入有误，请重新输入!"
            echo
            continue
            ;;
    esac

    install_cleanup
}

update_caddy_v2(){
    cd ${CUR_DIR}
    
    caddy_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/caddyserver/caddy/releases | grep -o '"tag_name": ".*"' | sed 's/"//g;s/v//g' | sed 's/tag_name: //g' | grep -E '^2' | head -n 1)
    [ -z ${caddy_ver} ] && echo -e "${Error} 获取 caddy2 最新版本失败." && exit 1
    current_caddy_ver=${caddyCurrentVer}
    if ! check_latest_version ${current_caddy_ver} ${caddy_ver}; then
        echo -e "${Point} caddy2当前已是最新版本${current_caddy_ver}不需要更新."
        echo
        exit 1
    fi

    echo -e "${Info} 检测到caddy2有新版本，开始下载并安装."
    do_stop > /dev/null 2>&1
    improt_package "tools" "caddy_install.sh"
    install_caddy
    do_restart > /dev/null 2>&1

    echo -e "${Info} caddy2已成功升级为最新版本${caddy_ver}"
    echo

    install_cleanup
}

update_caddy(){
    if [[ -e ${CADDY_BIN_PATH} ]]; then
        IFS=, read caddyVerFlag caddyCurrentVer < ${CADDY_VERSION_FILE}
        
        if [[ ${caddyVerFlag} = "1" ]]; then
            update_caddy_v1
        elif [[ ${caddyVerFlag} = "2" ]]; then
            update_caddy_v2
        fi
    fi
}

update_shadowsocks_libev(){
    local SS_VERSION="ss-libev"
    
    echo -e "${Info} 正在进行版本比对请稍等."
    libev_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/shadowsocks/shadowsocks-libev/releases | grep -o '"tag_name": ".*"' | head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
    [ -z ${libev_ver} ] && echo -e "${Error} 获取 shadowsocks-libev 最新版本失败." && exit 1
    current_libev_ver=$(ss-server -v | grep shadowsocks-libev | cut -d\  -f2)
    if ! check_latest_version ${current_libev_ver} ${libev_ver}; then
        echo -e "${Point} shadowsocklibev-libev当前已是最新版本${current_libev_ver}不需要更新."
        
        update_v2ray_plugin
        update_kcptun
        update_simple_obfs
        update_goquiet
        update_cloak
        update_mtt
        update_rabbit_tcp
        update_simple_tls
        update_gost_plugin
        update_xray_plugin
        
        exit 1
    fi
    
    echo -e "${Info} 检测到SS有新版本，开始下载."
    download_ss_file
    echo -e "${Info} 下载完成，开始执行编译安装."
    improt_package "tools" "shadowsocks_install.sh"
    do_stop > /dev/null 2>&1
    install_shadowsocks_libev
    do_restart > /dev/null 2>&1
    echo -e "${Info} shadowsocklibev-libev已成功升级为最新版本${libev_ver}"
    
    install_cleanup

    update_v2ray_plugin
    update_kcptun
    update_simple_obfs
    update_goquiet
    update_cloak
    update_mtt
    update_rabbit_tcp
    update_simple_tls
    update_gost_plugin
    update_xray_plugin
}

update_shadowsocks_rust(){
    local SS_VERSION="ss-rust"
    
    echo -e "${Info} 正在进行版本比对请稍等."
    rust_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/shadowsocks/shadowsocks-rust/releases | grep -o '"tag_name": ".*"' | grep -v 'alpha' | head -n 1 | sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
    [ -z ${rust_ver} ] && echo -e "${Error} 获取 shadowsocks-rust 最新版本失败." && exit 1
    current_rust_ver=$(ssserver -V | grep shadowsocks | cut -d\  -f2)
    if ! check_latest_version ${current_rust_ver} ${rust_ver}; then
        echo -e "${Point} shadowsocklibev-rust当前已是最新版本$(ssserver -V | grep shadowsocks | cut -d\  -f2)不需要更新."
        
        update_v2ray_plugin
        update_kcptun
        update_simple_obfs
        update_goquiet
        update_cloak
        update_mtt
        update_rabbit_tcp
        update_simple_tls
        update_gost_plugin
        update_xray_plugin
        
        exit 1
    fi
    
    echo -e "${Info} 检测到SS有新版本，开始下载."
    download_ss_file
    echo -e "${Info} 下载完成，开始进行覆盖安装."
    improt_package "tools" "shadowsocks_install.sh"
    do_stop > /dev/null 2>&1
    install_shadowsocks_rust
    do_restart > /dev/null 2>&1
    echo -e "${Info} shadowsocklibev-rust已成功升级为最新版本${rust_ver}"
    
    install_cleanup

    update_v2ray_plugin
    update_kcptun
    update_simple_obfs
    update_goquiet
    update_cloak
    update_mtt
    update_rabbit_tcp
    update_simple_tls
    update_gost_plugin
    update_xray_plugin
}

update_go_shadowsocks2(){
    local SS_VERSION="go-ss2"

    echo -e "${Info} 正在进行版本比对请稍等."
    go_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/shadowsocks/go-shadowsocks2/releases | grep -o '"tag_name": ".*"' | head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
    [ -z ${go_ver} ] && echo -e "${Error} 获取 go-shadowsocks2 最新版本失败." && exit 1
    read current_go_ver < ${GO_SHADOWSOCKS2_VERSION_FILE}
    if ! check_latest_version ${current_go_ver} ${go_ver}; then
        echo -e "${Point} go-shadowsocks2当前已是最新版本${current_go_ver}不需要更新."

        update_v2ray_plugin
        update_kcptun
        update_simple_obfs
        update_goquiet
        update_cloak
        update_mtt
        update_rabbit_tcp
        update_simple_tls
        update_gost_plugin
        update_xray_plugin

        exit 1
    fi

    echo -e "${Info} 检测到SS有新版本，开始下载."
    download_ss_file
    echo -e "${Info} 下载完成，开始执行覆盖安装."
    improt_package "tools" "shadowsocks_install.sh"
    do_stop > /dev/null 2>&1
    install_go_shadowsocks2
    do_restart > /dev/null 2>&1
    echo -e "${Info} go-shadowsocks2已成功升级为最新版本${go_ver}"

    install_cleanup

    update_v2ray_plugin
    update_kcptun
    update_simple_obfs
    update_goquiet
    update_cloak
    update_mtt
    update_rabbit_tcp
    update_simple_tls
    update_gost_plugin
    update_xray_plugin
}

update_logic(){
    if [[ -e ${SHADOWSOCKS_LIBEV_BIN_PATH} ]]; then
        update_shadowsocks_libev
    elif [[ -e ${SHADOWSOCKS_RUST_BIN_PATH} ]]; then
        update_shadowsocks_rust
    elif [[ -e ${GO_SHADOWSOCKS2_BIN_PATH} ]]; then
        update_go_shadowsocks2
    fi
}
