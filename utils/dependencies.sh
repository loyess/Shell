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


