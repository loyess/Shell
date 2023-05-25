improt_package "utils" "downloads.sh"


judge_is_num(){
    expr ${1} + 1 &>/dev/null
    if [ $? -ne 0 ]; then
        return 1
    else
        return 0
    fi
}

judge_current_version_num_is_none_and_output_error_info(){
    local appName=$1
    local currentVersion=$2
    
    [ -z ${currentVersion} ] && _echo -e "获取${appName}当前版本号失败，退出运行." && exit 1
}

judge_not_update_and_output_point_info(){
    local appName=$1
    local currentVersion=$2
    local latestVersion=$3
    
    if ! check_latest_version ${currentVersion} ${latestVersion}; then
        echo -e "${Point} ${appName}当前已是最新版本${latestVersion}不需要更新."
        exit 0
    fi
}

judge_not_update_when_simple_tls_is_specified_version(){
    local appName=$1
    local currentVersion=$2

    if [[ -e ${SIMPLE_TLS_BIN_PATH} ]]; then
        if ! check_latest_version "0.4.7" ${currentVersion}; then
            echo -e "${Point} ${appName}当前版本是${currentVersion}及以下版本，与最新版本不兼容，脚本不提供更新."
            exit 0
        fi
    fi
}

update_download(){
    local downloadMark=$1
    local downloadFileName=$2
    local SS_VERSION plugin_num
    
    _echo -i "检测到${downloadFileName}有新版本，开始下载."
    if $(judge_is_num "${downloadMark}"); then
        plugin_num=${downloadMark}
        download_plugins_file
    else
        SS_VERSION=${downloadMark}
        download_ss_file
    fi
    _echo -i "${downloadFileName}下载完成，等待安装."
}

update_install(){
    local packageName=$1
    local shFileName=$2
    local calledFuncName=$3

    improt_package "${packageName}" "${shFileName}"
    do_stop > /dev/null 2>&1
    ${calledFuncName}
    do_restart > /dev/null 2>&1
}

update_completed(){
    local appName=$1
    local latestVersion=$2

    _echo -i "${appName}已成功升级为最新版本${latestVersion}" && echo
    install_cleanup
}

read_version_num(){
    local versionNum
    local versionFilePath=$1

    read versionNum < ${versionFilePath}
    echo ${versionNum}
}

ss_update_preparation(){
    ssUpdatePackageName="install"
    if [[ -e ${SHADOWSOCKS_LIBEV_BIN_PATH} ]]; then
        ssNameUpdate="shadowsocks-libev"
        ssUpdateDownloadMark="ss-libev"
        ssUpdateShFileName="shadowsocks_install.sh"
        ssUpdateCalledFuncName="install_shadowsocks_libev"
        ssLatestVersion=$(get_ss_version "${ssNameUpdate}")
        ssCurrentVersion=$(ss-server -v | grep shadowsocks-libev | cut -d\  -f2)
    elif [[ -e ${SHADOWSOCKS_RUST_BIN_PATH} ]]; then
        ssNameUpdate="shadowsocks-rust"
        ssUpdateDownloadMark="ss-rust"
        ssUpdateShFileName="shadowsocks_install.sh"
        ssUpdateCalledFuncName="install_shadowsocks_rust"
        ssLatestVersion=$(get_ss_version "${ssNameUpdate}")
        ssCurrentVersion=$(ssservice -V | grep shadowsocks | cut -d\  -f2)
    elif [[ -e ${GO_SHADOWSOCKS2_BIN_PATH} ]]; then
        ssNameUpdate="go-shadowsocks2"
        ssUpdateDownloadMark="go-ss2"
        ssUpdateShFileName="shadowsocks_install.sh"
        ssUpdateCalledFuncName="install_go_shadowsocks2"
        ssLatestVersion=$(get_ss_version "${ssNameUpdate}")
        ssCurrentVersion=$(read_version_num "${GO_SHADOWSOCKS2_VERSION_FILE}")
    fi
}

plugins_update_preparation(){
    pluginUpdatePackageName="install"
    if [[ -e ${V2RAY_PLUGIN_BIN_PATH} ]]; then
        pluginNameUpdate="v2ray-plugin"
        pluginUpdateDownloadMark="1"
        pluginUpdateShFileName="v2ray_plugin_install.sh"
        pluginUpdateCalledFuncName="install_v2ray_plugin"
        pluginLatestVersion=$(get_plugins_version "${pluginNameUpdate}")
        pluginCurrentVersion=$(v2ray-plugin -version | grep v2ray-plugin | cut -d\  -f2 | sed 's/v//g')
    elif [[ -e ${KCPTUN_BIN_PATH} ]]; then
        pluginNameUpdate="kcptun"
        pluginUpdateDownloadMark="2"
        pluginUpdateShFileName="kcptun_install.sh"
        pluginUpdateCalledFuncName="install_kcptun"
        pluginLatestVersion=$(get_plugins_version "${pluginNameUpdate}")
        pluginCurrentVersion=$(kcptun-server -v | grep kcptun | cut -d\  -f3)
    elif [[ -e ${SIMPLE_OBFS_BIN_PATH} ]]; then
        pluginNameUpdate="simple-obfs"
        pluginUpdateDownloadMark="3"
        pluginUpdateShFileName="simple_obfs_install.sh"
        pluginUpdateCalledFuncName="install_simple_obfs"
        pluginLatestVersion=$(get_plugins_version "${pluginNameUpdate}")
        pluginCurrentVersion=$(obfs-server | grep simple-obfs | cut -d\  -f2)
    elif [[ -e ${GOQUIET_BIN_PATH} ]]; then
        pluginNameUpdate="GoQuiet"
        pluginUpdateDownloadMark="4"
        pluginUpdateShFileName="goquiet_install.sh"
        pluginUpdateCalledFuncName="install_goquiet"
        pluginLatestVersion=$(get_plugins_version "${pluginNameUpdate}")
        pluginCurrentVersion=$(gq-server -v | grep gq-server | cut -d\  -f2)
    elif [[ -e ${CLOAK_SERVER_BIN_PATH} ]]; then
        pluginNameUpdate="Cloak"
        pluginUpdateDownloadMark="5"
        pluginUpdateShFileName="cloak_install.sh"
        pluginUpdateCalledFuncName="install_cloak"
        pluginLatestVersion=$(get_plugins_version "${pluginNameUpdate}")
        pluginCurrentVersion=$(ck-server -v | grep ck-server | cut -d\  -f2 | sed 's/v//g')
    elif [[ -e ${MTT_BIN_PATH} ]]; then
        pluginNameUpdate="mos-tls-tunnel"
        pluginUpdateDownloadMark="6"
        pluginUpdateShFileName="mos_tls_tunnel_install.sh"
        pluginUpdateCalledFuncName="install_mos_tls_tunnel"
        pluginLatestVersion=$(get_plugins_version "${pluginNameUpdate}")
        pluginCurrentVersion=$(read_version_num "${MTT_VERSION_FILE}")
    elif [[ -e ${RABBIT_BIN_PATH} ]]; then
        pluginNameUpdate="rabbit-tcp"
        pluginUpdateDownloadMark="7"
        pluginUpdateShFileName="rabbit_tcp_install.sh"
        pluginUpdateCalledFuncName="install_rabbit_tcp"
        pluginLatestVersion=$(get_plugins_version "${pluginNameUpdate}")
        pluginCurrentVersion=$(read_version_num "${RABBIT_VERSION_FILE}")
    elif [[ -e ${SIMPLE_TLS_BIN_PATH} ]]; then
        pluginNameUpdate="simple-tls"
        pluginUpdateDownloadMark="8"
        pluginUpdateShFileName="simple_tls_install.sh"
        pluginUpdateCalledFuncName="install_simple_tls"
        # pluginLatestVersion=$(get_plugins_version "${pluginNameUpdate}")
        pluginLatestVersion=0.5.2
        pluginCurrentVersion=$(read_version_num "${SIMPLE_TLS_VERSION_FILE}")
    elif [[ -e ${GOST_PLUGIN_BIN_PATH} ]]; then
        pluginNameUpdate="gost-plugin"
        pluginUpdateDownloadMark="9"
        pluginUpdateShFileName="gost_plugin_install.sh"
        pluginUpdateCalledFuncName="install_gost_plugin"
        # pluginLatestVersion=$(get_plugins_version "${pluginNameUpdate}")
        pluginLatestVersion=1.6.1
        pluginCurrentVersion=$(read_version_num "${GOST_PLUGIN_VERSION_FILE}")
    elif [[ -e ${XRAY_PLUGIN_BIN_PATH} ]]; then
        pluginNameUpdate="xray-plugin"
        pluginUpdateDownloadMark="10"
        pluginUpdateShFileName="xray_plugin_install.sh"
        pluginUpdateCalledFuncName="install_xray_plugin"
        pluginLatestVersion=$(get_plugins_version "${pluginNameUpdate}")
        pluginCurrentVersion=$(read_version_num "${XRAY_PLUGIN_VERSION_FILE}")
    elif [[ -e ${QTUN_BIN_PATH} ]]; then
        pluginNameUpdate="qtun"
        pluginUpdateDownloadMark="11"
        pluginUpdateShFileName="qtun_install.sh"
        pluginUpdateCalledFuncName="install_qtun"
        pluginLatestVersion=$(get_plugins_version "${pluginNameUpdate}")
        pluginCurrentVersion=$(read_version_num "${QTUN_VERSION_FILE}")
    elif [[ -e ${GUN_BIN_PATH} ]]; then
        pluginNameUpdate="gun"
        pluginUpdateDownloadMark="12"
        pluginUpdateShFileName="gun_install.sh"
        pluginUpdateCalledFuncName="install_gun"
        pluginLatestVersion=$(get_plugins_version "${pluginNameUpdate}")
        pluginCurrentVersion=$(read_version_num "${GUN_VERSION_FILE}")
    fi
}

update_caddy_v1(){
    local versionMark=$1
    
    local appName="caddy"
    local packageName="webServer"
    local shFileName="caddy_install.sh"
    local calledFuncName="install_caddy"

    local caddyVerFlag currentVersion latestVersion

    cd ${CUR_DIR}
    currentVersion=$(caddy -version)
    _echo -i "当前版本：${currentVersion}"
    read -p "是否强制覆盖安装caddy(默认: n) [y/n]: " yn
    [ -z "${yn}" ] && yn="N"
    case "${yn:0:1}" in
        y|Y)
            caddyVerFlag="${versionMark}"
            update_install "${packageName}" "${shFileName}" "${calledFuncName}"
            latestVersion=$(caddy -version)
            _echo -i "覆盖版本：${latestVersion}"
            ;;
        *)
            _echo -i "跳过强制安装。"
            ;;
    esac

    install_cleanup
}

update_caddy_v2(){
    local versionMark=$1
    local currentVersion=$2

    local appName="caddy2"
    local packageName="webServer"
    local shFileName="caddy_install.sh"
    local calledFuncName="install_caddy"

    local caddyVerFlag latestVersion

    cd ${CUR_DIR}
    latestVersion=$(wget --no-check-certificate -qO- https://api.github.com/repos/caddyserver/caddy/releases | grep -o '"tag_name": ".*"' | sed 's/"//g;s/v//g' | sed 's/tag_name: //g' | grep -E '^2' | head -n 1)

    judge_current_version_num_is_none_and_output_error_info "${appName}" "${currentVersion}"
    judge_latest_version_num_is_none_and_output_error_info "${appName}" "${latestVersion}"
    judge_not_update_and_output_point_info "${appName}" "${currentVersion}" "${latestVersion}"
    _echo -i "检测到${appName}有新版本，开始下载."
    caddyVerFlag="${versionMark}"
    update_install "${packageName}" "${shFileName}" "${calledFuncName}"
    update_completed "${ssNameUpdate}" "${ssLatestVersion}"
}

ss_update_logic(){
    ss_update_preparation
    judge_current_version_num_is_none_and_output_error_info "${ssNameUpdate}" "${ssCurrentVersion}"
    judge_latest_version_num_is_none_and_output_error_info "${ssNameUpdate}" "${ssLatestVersion}"
    judge_not_update_and_output_point_info "${ssNameUpdate}" "${ssCurrentVersion}" "${ssLatestVersion}"
    update_download "${ssUpdateDownloadMark}" "${ssNameUpdate}"
    update_install "${ssUpdatePackageName}" "${ssUpdateShFileName}" "${ssUpdateCalledFuncName}"
    update_completed "${ssNameUpdate}" "${ssLatestVersion}"

}

plugins_update_logic(){
    plugins_update_preparation
    judge_current_version_num_is_none_and_output_error_info "${pluginNameUpdate}" "${pluginCurrentVersion}"
    judge_latest_version_num_is_none_and_output_error_info "${pluginNameUpdate}" "${pluginLatestVersion}"
    judge_not_update_when_simple_tls_is_specified_version "${pluginNameUpdate}" "${pluginCurrentVersion}"
    judge_not_update_and_output_point_info "${pluginNameUpdate}" "${pluginCurrentVersion}" "${pluginLatestVersion}"
    update_download "${pluginUpdateDownloadMark}" "${pluginNameUpdate}"
    update_install "${pluginUpdatePackageName}" "${pluginUpdateShFileName}" "${pluginUpdateCalledFuncName}"
    update_completed "${pluginNameUpdate}" "${pluginLatestVersion}"
}

caddy_update_logic(){
    if [[ -e ${CADDY_BIN_PATH} ]] && [[ -e ${WEB_INSTALL_MARK} ]]; then
        local versionMark currentVersion

        IFS=, read versionMark currentVersion < ${CADDY_VERSION_FILE}

        if [[ ${versionMark} = "1" ]]; then
            update_caddy_v1 "${versionMark}"
        elif [[ ${versionMark} = "2" ]]; then
            update_caddy_v2 "${versionMark}" "${currentVersion}"
        fi
    fi
}

update_logic(){
    (ss_update_logic)
    (plugins_update_logic)
    (caddy_update_logic)
}
