#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH


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

error_detect_depends(){
    local command=$1
    local depend=`echo "${command}" | awk '{print $4}'`
    echo -e "${Info} 开始安装依赖包 ${depend}"
    ${command} > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo -e "${Error} 依赖包${Red}${depend}${suffix}安装失败，请检查. "
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
            dos2unix
        )
        for depend in ${yum_depends[@]}; do
            error_detect_depends "yum -y install ${depend}"
        done
    elif check_sys packageManager apt; then
        apt_depends=(
            dos2unix
        )

        apt-get -y update
        for depend in ${apt_depends[@]}; do
            error_detect_depends "apt-get -y install ${depend}"
        done
    fi
}



command -V dos2unix > /dev/null 2>&1

if [ $? -eq 1 ]; then
    install_dependencies
fi

dos2unix ./ss-plugins.sh

dos2unix ./utils/ck_sslink.sh
dos2unix ./utils/ck_user_manager.sh
dos2unix ./utils/qr_code.sh
dos2unix ./utils/view_config.sh


dos2unix ./prepare/ss_libev_prepare.sh
dos2unix ./prepare/v2p_prepare.sh
dos2unix ./prepare/kp_prepare.sh
dos2unix ./prepare/obfs_prepare.sh
dos2unix ./prepare/gq_prepare.sh
dos2unix ./prepare/ck_prepare.sh


dos2unix ./tools/shadowsocks_libev_install.sh
dos2unix ./tools/caddy_install.sh



dos2unix ./plugins/v2ray_plugin_install.sh
dos2unix ./plugins/kcptun_install.sh
dos2unix ./plugins/simple_obfs_install.sh
dos2unix ./plugins/goquiet_install.sh
dos2unix ./plugins/cloak_install.sh


dos2unix ./templates/write_config.sh
dos2unix ./templates/group_sslink.sh
dos2unix ./templates/show_config.sh


dos2unix ./service/caddy_centos.sh
dos2unix ./service/caddy_debian.sh
dos2unix ./service/cloak_centos.sh
dos2unix ./service/cloak_debian.sh
dos2unix ./service/kcptun_centos.sh
dos2unix ./service/kcptun_debian.sh
dos2unix ./service/shadowsocks-libev_centos.sh
dos2unix ./service/shadowsocks-libev_debian.sh
