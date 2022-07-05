# shadowsocks-libev dependencies
LIBSODIUM_VERSION="1.0.18"
LIBSODIUM_FILE="libsodium-${LIBSODIUM_VERSION}"
LIBSODIUM_VERSION_FILE=~/.deps-ver/libsodium.v
LIBSODIUM_URL="https://github.com/jedisct1/libsodium/releases/download/${LIBSODIUM_VERSION}-RELEASE/libsodium-${LIBSODIUM_VERSION}.tar.gz"

MBEDTLS_VERSION="2.16.12"
MBEDTLS_FILE="mbedtls-${MBEDTLS_VERSION}"
MBEDTLS_VERSION_FILE=~/.deps-ver/mbedtls.v
MBEDTLS_URL="https://github.com/ARMmbed/mbedtls/archive/${MBEDTLS_FILE}.tar.gz"



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
        _echo -e "依赖包${Red}${depend}${suffix}安装失败，请检查. "
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
            _echo -e "依赖包${Red}${depend}${suffix}安装失败，请检查. "
            echo "Checking the error message and run the script again."
            exit 1
        fi
    fi
}

error_detect_depends(){
    local command=$1
    local depend=`echo "${command}" | awk '{print $4}'`
    _echo -i "开始安装依赖包 ${depend}"
    ${command} > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        if check_sys sysRelease ubuntu || check_sys sysRelease debian; then
            if [ $(get_version) == '19.10' ] && [ ${depend} == 'asciidoc' ]; then
                  error_asciidos_deps_of_ubuntu1901 "${command}" "${depend}"
            else
                  error_detect_deps_of_ubuntu "${command}" "${depend}"
            fi
        else
            _echo -e "依赖包${Red}${depend}${suffix}安装失败，请检查. "
            echo "Checking the error message and run the script again."
            exit 1
        fi
    fi
}

install_dependencies(){
    local depends=($*)

    if check_sys packageManager yum; then
        _echo -i "检查EPEL存储库."
        if [ ! -f /etc/yum.repos.d/epel.repo ]; then
            yum install -y epel-release > /dev/null 2>&1
        fi
        [ ! -f /etc/yum.repos.d/epel.repo ] && _echo -e "安装EPEL存储库失败，请检查它。" && exit 1
        [ ! "$(command -v yum-config-manager)" ] && yum install -y yum-utils > /dev/null 2>&1
        if centosversion 8; then
            [ x"$(yum repolist epel | grep -w epel | awk '{print $NF}')" != x"enabled" ] && yum-config-manager --enable epel > /dev/null 2>&1
        else
            [ x"$(yum-config-manager epel | grep -w enabled | awk '{print $3}')" != x"True" ] && yum-config-manager --enable epel > /dev/null 2>&1
        fi
        _echo -i "EPEL存储库检查完成."

        for depend in ${depends[@]}; do
            error_detect_depends "yum -y install ${depend}"
        done
    elif check_sys packageManager apt; then

        apt-get -y update
        for depend in ${depends[@]}; do
            error_detect_depends "apt-get -y install ${depend}"
        done
    fi
}

install_dependencies_logic(){
    if [[ ${SS_VERSION} = "ss-libev" ]] || [[ "${plugin_num}" == "3" ]]; then
        if check_sys packageManager yum; then
            local depends=(
                gettext gcc pcre pcre-devel autoconf libtool automake make asciidoc xmlto c-ares-devel libev-devel zlib-devel openssl-devel git qrencode jq
            )
        elif check_sys packageManager apt; then
            local depends=(
                gettext gcc build-essential autoconf libtool libpcre3-dev asciidoc xmlto libev-dev libc-ares-dev automake libssl-dev git qrencode jq xz-utils
            )
        fi
        install_dependencies "${depends[*]}"
    fi

    if [ ! "$(command -v qrencode)" ] || [ ! "$(command -v jq)" ]; then
        local depends=(qrencode jq)
        install_dependencies "${depends[*]}"
    fi
}

install_libsodium(){
    local installStatus=$1

    cd ${CUR_DIR}
    _echo -i "下载${LIBSODIUM_FILE}."
    download "${LIBSODIUM_FILE}.tar.gz" "${LIBSODIUM_URL}"
    _echo -i "解压${LIBSODIUM_FILE}."
    tar zxf ${LIBSODIUM_FILE}.tar.gz && cd ${LIBSODIUM_FILE}
    _echo -i "编译安装${LIBSODIUM_FILE}."
    ./configure --prefix=/usr && make && make install
    if [ $? -ne 0 ]; then
        _echo -e "${LIBSODIUM_FILE} ${installStatus}失败 !"
        install_cleanup
        exit 1
    fi
    # wriet version num
    if [ ! -d "$(dirname ${LIBSODIUM_VERSION_FILE})" ]; then
        mkdir -p $(dirname ${LIBSODIUM_VERSION_FILE})
    fi
    echo ${LIBSODIUM_VERSION} > ${LIBSODIUM_VERSION_FILE}
    _echo -i "${LIBSODIUM_FILE} ${installStatus}成功 !"
}

install_libsodium_logic(){
    if [ ! -f ${LIBSODIUM_VERSION_FILE} ]; then
        install_libsodium '安装'
    else
        read  currentLibsodiumVer < ${LIBSODIUM_VERSION_FILE}
        latestLibsodiumVer=${LIBSODIUM_VERSION}

        if check_latest_version ${currentLibsodiumVer} ${latestLibsodiumVer}; then
            install_libsodium '更新'
        else
            _echo -i "${LIBSODIUM_FILE} 已经安装最新版本."
        fi
    fi
}

install_mbedtls(){
    local installStatus=$1

    cd ${CUR_DIR}
    _echo -i "下载${MBEDTLS_FILE}."
    download "${MBEDTLS_FILE}.tar.gz" "${MBEDTLS_URL}"
    _echo -i "解压${MBEDTLS_FILE}."
    tar zxf ${MBEDTLS_FILE}.tar.gz
    mv "mbedtls-${MBEDTLS_FILE}" ${MBEDTLS_FILE}
    cd ${MBEDTLS_FILE}
    _echo -i "编译安装${MBEDTLS_FILE}."
    make SHARED=1 CFLAGS=-fPIC
    make DESTDIR=/usr install
    if [ $? -ne 0 ]; then
        _echo -e "${MBEDTLS_FILE} ${installStatus}失败."
        install_cleanup
        exit 1
    fi
    # wriet version num
    if [ ! -d "$(dirname ${MBEDTLS_VERSION_FILE})" ]; then
        mkdir -p $(dirname ${MBEDTLS_VERSION_FILE})
    fi
    echo ${MBEDTLS_VERSION} > ${MBEDTLS_VERSION_FILE}
    _echo -i "${MBEDTLS_FILE} ${installStatus}成功 !"
}

install_mbedtls_logic(){
    if [ ! -f ${MBEDTLS_VERSION_FILE} ]; then
        install_mbedtls '安装'
    else
        read  currentMbedtlsVer < ${MBEDTLS_VERSION_FILE}
        latestMbedtlsVer=${MBEDTLS_VERSION}

        if check_latest_version ${currentMbedtlsVer} ${latestMbedtlsVer}; then
            install_mbedtls '更新'
        else
            _echo -i "${MBEDTLS_FILE} 已经安装最新版本."
        fi
    fi
}

add_more_entropy(){
    # Ubuntu series is started by default after installation
    # Debian series needs to add configuration to start after installation
    # CentOS 6 is installed by default but not started. CentOS 7 is not started by default after installation. CentOS 8 is installed and started by default.
    local ENTROPY_SIZE_BEFORE=$(cat /proc/sys/kernel/random/entropy_avail)
    if [[ ${ENTROPY_SIZE_BEFORE} -lt 1000 ]]; then
        _echo -i "安装rng-tools之前熵池的熵值为${Green}${ENTROPY_SIZE_BEFORE}${suffix}"
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
        _echo -i "安装rng-tools之后熵池的熵值为${Green}${ENTROPY_SIZE_BEHIND}${suffix}"
    else
        _echo -i "当前熵池熵值大于或等于1000，未进行更多添加."
    fi 
}