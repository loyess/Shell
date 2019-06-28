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