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
        wget -qO- ${CADDY_INSTALL_SCRIPT_URL} | bash -s install
    elif [[ ${libev_v2ray} == "5" ]]; then
        wget -qO- ${CADDY_INSTALL_SCRIPT_URL} | bash -s install tls.dns.cloudflare
    fi
}