update_v2ray_plugin(){
    cd ${CUR_DIR}
    
    if [[ -e '/usr/local/bin/v2ray-plugin' ]]; then
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
            if [[ ! -e ${CADDY_FILE} ]]; then
                echo
            fi
            
            install_cleanup
            
            update_caddy
            
            exit 0
        fi
        
        current_v2ray_plugin_ver=$(v2ray-plugin -version | grep v2ray-plugin | cut -d\  -f2 | sed 's/v//g')
        if ! check_latest_version ${current_v2ray_plugin_ver} ${v2ray_plugin_ver}; then
            echo -e "${Point} v2ray-plugin当前已是最新版本${current_v2ray_plugin_ver}不需要更新."
            if [[ ! -e ${CADDY_FILE} ]]; then
                echo
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
        if [[ ! -e ${CADDY_FILE} ]]; then
            echo
        fi
        
        install_cleanup
        
        update_caddy
    fi
}

update_kcptun(){
    cd ${CUR_DIR}
    
    if [[ -e ${KCPTUN_INSTALL_DIR} ]]; then
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
    
    if [[ -e '/usr/local/bin/obfs-server' ]]; then
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
    
    if [[ -e '/usr/local/bin/gq-server' ]]; then
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
    
    if [[ -e '/usr/local/bin/ck-server' ]]; then
        current_cloak_ver=$(ck-server -v | grep ck-server | cut -d\  -f2)
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

update_caddy(){
    cd ${CUR_DIR}
    
    if [[ -e '/usr/local/caddy/caddy' ]]; then
        current_caddy_ver=$(/usr/local/caddy/caddy -version | grep Caddy | cut -d\  -f2 | sed 's/v//g')
        if ! check_latest_version ${current_caddy_ver} ${caddy_ver}; then
            echo -e "${Point} caddy当前已是最新版本${current_caddy_ver}不需要更新."
            echo
            exit 1
        fi
        
        if ! $(grep -q 'cloudflare' /usr/local/caddy/Caddyfile); then
            libev_v2ray=4
        else
            libev_v2ray=5
        fi
        
        echo -e "${Info} 检测到caddy有新版本，开始下载并安装."
        do_stop > /dev/null 2>&1
        choose_caddy_extension ${libev_v2ray}
        do_restart > /dev/null 2>&1

        echo -e "${Info} caddy已成功升级为最新版本${caddy_ver}"
        echo
        
        install_cleanup
    fi
}