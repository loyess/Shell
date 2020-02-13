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
        echo -e "${Info} shadowsocks-libev安装成功."
    else
        echo
        echo -e "${Error} shadowsocks-libev安装失败."
        echo
        install_cleanup
        exit 1
    fi
}

install_shadowsocks_rust(){
    cd ${CUR_DIR}
    tar xf ${shadowsocks_rust_file}.tar.xz
    chmod +x sstunnel sslocal ssserver ssurl ssmanager ssredir
    mv sstunnel sslocal ssserver ssurl ssmanager ssredir ${SHADOWSOCKS_RUST_INSTALL_PATH}
    if [ $? -eq 0 ]; then
        chmod +x ${SHADOWSOCKS_RUST_INIT}
        local service_name=$(basename ${SHADOWSOCKS_RUST_INIT})
        if check_sys packageManager yum; then
            chkconfig --add ${service_name}
            chkconfig ${service_name} on
        elif check_sys packageManager apt; then
            update-rc.d -f ${service_name} defaults
        fi
        echo -e "${Info} shadowsocks-rust安装成功."
    else
        echo
        echo -e "${Error} shadowsocks-rust安装失败."
        echo
        install_cleanup
        exit 1
    fi
}
