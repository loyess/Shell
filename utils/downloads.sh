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

download_service_file(){
    local filePath=$1
    local onlineServiceFileUrl=$2
    local localServiceFilePath=$3
    
    if [[ ${methods} == "Online" ]]; then
        download ${filePath} ${onlineServiceFileUrl}
    else
        cp -rf ${localServiceFilePath} ${filePath}
    fi
}

get_version_by_github_api(){
    local owner=$1
    local repositoryName=$2
    local apiUrl allVersion latestVersion

    apiUrl="https://api.github.com/repos/${owner}/${repositoryName}/releases"
    allVersion=$(wget --no-check-certificate -qO- ${apiUrl} | grep -o '"tag_name": ".*"')
    if [ "${repositoryName}" = "shadowsocks-rust" ]; then
        allVersion=$(echo "${allVersion}" | grep -v "alpha")
    fi
    latestVersion=$(echo "${allVersion}" | head -n 1 | sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
    echo ${latestVersion}
}

get_ss_version(){
    local ssName=$1

    get_version_by_github_api "shadowsocks" "${ssName}"
}

get_plugins_version(){
    local pluginName=$1

    if [ ${pluginName} = "v2ray-plugin" ]; then
        get_version_by_github_api "teddysun" "${pluginName}"
    elif [ ${pluginName} = "kcptun" ]; then
        get_version_by_github_api "xtaci" "${pluginName}"
    elif [ ${pluginName} = "simple-obfs" ]; then
        get_version_by_github_api "shadowsocks" "${pluginName}"
    elif [ ${pluginName} = "GoQuiet" ]; then
        get_version_by_github_api "cbeuw" "${pluginName}"
    elif [ ${pluginName} = "Cloak" ]; then
        get_version_by_github_api "cbeuw" "${pluginName}"
    elif [ ${pluginName} = "mos-tls-tunnel" ]; then
        get_version_by_github_api "IrineSistiana" "${pluginName}"
    elif [ ${pluginName} = "rabbit-tcp" ]; then
        get_version_by_github_api "ihciah" "${pluginName}"
    elif [ ${pluginName} = "simple-tls" ]; then
        get_version_by_github_api "IrineSistiana" "${pluginName}"
    elif [ ${pluginName} = "gost-plugin" ]; then
        get_version_by_github_api "maskedeken" "${pluginName}"
    elif [ ${pluginName} = "xray-plugin" ]; then
        get_version_by_github_api "teddysun" "${pluginName}"
    elif [ ${pluginName} = "qtun" ]; then
        get_version_by_github_api "shadowsocks" "${pluginName}"
    fi
}

judge_latest_version_num_is_none_and_output_error_info(){
    local appName=$1
    local latestVersion=$2

    [ -z ${latestVersion} ] && echo -e "${Error} 获取${appName}最新版本号失败，退出运行." && exit 1
}

download_ss_file(){
    cd ${CUR_DIR}
    if [[ ${SS_VERSION} = "ss-libev" ]]; then
        local ssName="shadowsocks-libev"
        libev_ver=$(get_ss_version "${ssName}")
        judge_latest_version_num_is_none_and_output_error_info "${ssName}" "${libev_ver}"

        shadowsocks_libev_file="shadowsocks-libev-${libev_ver}"
        shadowsocks_libev_url="https://github.com/shadowsocks/shadowsocks-libev/releases/download/v${libev_ver}/shadowsocks-libev-${libev_ver}.tar.gz"
        download "${shadowsocks_libev_file}.tar.gz" "${shadowsocks_libev_url}"
        download_service_file ${SHADOWSOCKS_LIBEV_INIT} ${SHADOWSOCKS_LIBEV_INIT_ONLINE} ${SHADOWSOCKS_LIBEV_INIT_LOCAL}
    elif [[ ${SS_VERSION} = "ss-rust" ]]; then
        local ssName="shadowsocks-rust"
        rust_ver=$(get_ss_version "${ssName}")
        judge_latest_version_num_is_none_and_output_error_info "${ssName}" "${rust_ver}"

        if [[ ${ARCH} = "amd64" ]]; then
            local MACHINE="x86_64"
        else
            local MACHINE="aarch64"
        fi

        shadowsocks_rust_file="shadowsocks-v${rust_ver}.${MACHINE}-unknown-linux-gnu"
        shadowsocks_rust_url="https://github.com/shadowsocks/shadowsocks-rust/releases/download/v${rust_ver}/shadowsocks-v${rust_ver}.${MACHINE}-unknown-linux-gnu.tar.xz"
        download "${shadowsocks_rust_file}.tar.xz" "${shadowsocks_rust_url}"
        download_service_file ${SHADOWSOCKS_RUST_INIT} ${SHADOWSOCKS_RUST_INIT_ONLINE} ${SHADOWSOCKS_RUST_INIT_LOCAL}
    elif [[ ${SS_VERSION} = "go-ss2" ]]; then
        if [[ ${ARCH} != "amd64" ]]; then
            echo "[${Red}Error${suffix}] The architecture is not supported."
            exit 1
        fi

        local ssName="go-shadowsocks2"
        go_ver=$(get_ss_version "${ssName}")
        judge_latest_version_num_is_none_and_output_error_info "${ssName}" "${go_ver}"

        # wriet version num
        if [ ! -d "$(dirname ${GO_SHADOWSOCKS2_VERSION_FILE})" ]; then
            mkdir -p $(dirname ${GO_SHADOWSOCKS2_VERSION_FILE})
        fi
        echo ${go_ver} > ${GO_SHADOWSOCKS2_VERSION_FILE}

        go_shadowsocks2_file="shadowsocks2-linux"
        go_shadowsocks2_url="https://github.com/shadowsocks/go-shadowsocks2/releases/download/v${go_ver}/shadowsocks2-linux.gz"
        download "${go_shadowsocks2_file}.gz" "${go_shadowsocks2_url}"
        download_service_file ${GO_SHADOWSOCKS2_INIT} ${GO_SHADOWSOCKS2_INIT_ONLINE} ${GO_SHADOWSOCKS2_INIT_LOCAL}
    fi
}

download_plugins_file(){
    cd ${CUR_DIR}
    if [[ "${plugin_num}" == "1" ]]; then        
        local pluginName="v2ray-plugin"
        v2ray_plugin_ver=$(get_plugins_version "${pluginName}")
        judge_latest_version_num_is_none_and_output_error_info "${pluginName}" "${v2ray_plugin_ver}"

        v2ray_plugin_file="v2ray-plugin-linux-${ARCH}-v${v2ray_plugin_ver}"
        v2ray_plugin_url="https://github.com/teddysun/v2ray-plugin/releases/download/v${v2ray_plugin_ver}/v2ray-plugin-linux-${ARCH}-v${v2ray_plugin_ver}.tar.gz"
        download "${v2ray_plugin_file}.tar.gz" "${v2ray_plugin_url}"
    elif [[ "${plugin_num}" == "2" ]]; then        
        local pluginName="kcptun"
        kcptun_ver=$(get_plugins_version "${pluginName}")
        judge_latest_version_num_is_none_and_output_error_info "${pluginName}" "${kcptun_ver}"

        kcptun_file="kcptun-linux-${ARCH}-${kcptun_ver}"
        kcptun_url="https://github.com/xtaci/kcptun/releases/download/v${kcptun_ver}/kcptun-linux-${ARCH}-${kcptun_ver}.tar.gz"
        download "${kcptun_file}.tar.gz" "${kcptun_url}"
        download_service_file ${KCPTUN_INIT} ${KCPTUN_INIT_ONLINE} ${KCPTUN_INIT_LOCAL}
    elif [[ "${plugin_num}" == "4" ]]; then        
        local pluginName="GoQuiet"
        goquiet_ver=$(get_plugins_version "${pluginName}")
        judge_latest_version_num_is_none_and_output_error_info "${pluginName}" "${goquiet_ver}"

        goquiet_file="gq-server-linux-${ARCH}-${goquiet_ver}"
        goquiet_url="https://github.com/cbeuw/GoQuiet/releases/download/v${goquiet_ver}/gq-server-linux-${ARCH}-${goquiet_ver}"
        download "${goquiet_file}" "${goquiet_url}"
    elif [[ "${plugin_num}" == "5" ]]; then
        local pluginName="Cloak"
        cloak_ver=$(get_plugins_version "${pluginName}")
        judge_latest_version_num_is_none_and_output_error_info "${pluginName}" "${cloak_ver}"
        # cloak_ver="2.1.1"

        cloak_file="ck-server-linux-${ARCH}-v${cloak_ver}"
        cloak_url="https://github.com/cbeuw/Cloak/releases/download/v${cloak_ver}/ck-server-linux-${ARCH}-v${cloak_ver}"
        download "${cloak_file}" "${cloak_url}"
        download_service_file ${CLOAK_INIT} ${CLOAK_INIT_ONLINE} ${CLOAK_INIT_LOCAL}
    elif [[ "${plugin_num}" == "6" ]]; then
        if [[ ${ARCH} != "amd64" ]]; then
            echo "[${Red}Error${suffix}] The architecture is not supported."
            exit 1
        fi

        local pluginName="mos-tls-tunnel"
        mtt_ver=$(get_plugins_version "${pluginName}")
        judge_latest_version_num_is_none_and_output_error_info "${pluginName}" "${mtt_ver}"

        # wriet version num
        if [ ! -d "$(dirname ${SHADOWSOCKS_CONFIG})" ]; then
            mkdir -p $(dirname ${SHADOWSOCKS_CONFIG})
        fi
        echo ${mtt_ver} > ${MTT_VERSION_FILE}

        mtt_file="mos-tls-tunnel-linux-amd64"
        mtt_url="https://github.com/IrineSistiana/mos-tls-tunnel/releases/download/v${mtt_ver}/mos-tls-tunnel-linux-amd64.zip"
        download "${mtt_file}.zip" "${mtt_url}"
    elif [[ "${plugin_num}" == "7" ]]; then
        local pluginName="rabbit-tcp"
        rabbit_ver=$(get_plugins_version "${pluginName}")
        judge_latest_version_num_is_none_and_output_error_info "${pluginName}" "${rabbit_ver}"

        # wriet version num
        if [ ! -d "$(dirname ${RABBIT_VERSION_FILE})" ]; then
            mkdir -p $(dirname ${RABBIT_VERSION_FILE})
        fi
        echo ${rabbit_ver} > ${RABBIT_VERSION_FILE}

        rabbit_file="rabbit-linux-${ARCH}"
        rabbit_url="https://github.com/ihciah/rabbit-tcp/releases/download/v${rabbit_ver}/rabbit-linux-${ARCH}.gz"
        download "${rabbit_file}.gz" "${rabbit_url}"
        download_service_file ${RABBIT_INIT} ${RABBIT_INIT_ONLINE} ${RABBIT_INIT_LOCAL}
    elif [[ "${plugin_num}" == "8" ]]; then
        local pluginName="simple-tls"
        # simple_tls_ver=$(get_plugins_version "${pluginName}")
        simple_tls_ver="0.5.2"
        judge_latest_version_num_is_none_and_output_error_info "${pluginName}" "${simple_tls_ver}"
        if [[ ${SimpleTlsVer} = "1" ]]; then
            simple_tls_ver="0.3.4"
        elif [[ ${SimpleTlsVer} = "2" ]]; then
            simple_tls_ver="0.4.7"
        fi

        # wriet version num
        if [ ! -d "$(dirname ${SIMPLE_TLS_VERSION_FILE})" ]; then
            mkdir -p $(dirname ${SIMPLE_TLS_VERSION_FILE})
        fi
        echo ${simple_tls_ver} > ${SIMPLE_TLS_VERSION_FILE}

        simple_tls_file="simple-tls-linux-${ARCH}"
        simple_tls_url="https://github.com/IrineSistiana/simple-tls/releases/download/v${simple_tls_ver}/simple-tls-linux-${ARCH}.zip"
        download "${simple_tls_file}.zip" "${simple_tls_url}"
    elif [[ "${plugin_num}" == "9" ]]; then
        local pluginName="gost-plugin"
        # gost_plugin_ver=$(get_plugins_version "${pluginName}")
        gost_plugin_ver="1.6.1"
        judge_latest_version_num_is_none_and_output_error_info "${pluginName}" "${gost_plugin_ver}"

        # wriet version num
        if [ ! -d "$(dirname ${GOST_PLUGIN_VERSION_FILE})" ]; then
            mkdir -p $(dirname ${GOST_PLUGIN_VERSION_FILE})
        fi
        echo ${gost_plugin_ver} > ${GOST_PLUGIN_VERSION_FILE}

        gost_plugin_file="gost-plugin_linux_${ARCH}-${gost_plugin_ver}"
        gost_plugin_url="https://github.com/maskedeken/gost-plugin/releases/download/v${gost_plugin_ver}/${gost_plugin_file}.zip"
        download "${gost_plugin_file}.zip" "${gost_plugin_url}"
    elif [[ "${plugin_num}" == "10" ]]; then
        local pluginName="xray-plugin"
        xray_plugin_ver=$(get_plugins_version "${pluginName}")
        judge_latest_version_num_is_none_and_output_error_info "${pluginName}" "${xray_plugin_ver}"

        # wriet version num
        if [ ! -d "$(dirname ${XRAY_PLUGIN_VERSION_FILE})" ]; then
            mkdir -p $(dirname ${XRAY_PLUGIN_VERSION_FILE})
        fi
        echo ${xray_plugin_ver} > ${XRAY_PLUGIN_VERSION_FILE}

        xray_plugin_file="xray-plugin-linux-${ARCH}-v${xray_plugin_ver}"
        xray_plugin_url="https://github.com/teddysun/xray-plugin/releases/download/v${xray_plugin_ver}/xray-plugin-linux-${ARCH}-v${xray_plugin_ver}.tar.gz"
        download "${xray_plugin_file}.tar.gz" "${xray_plugin_url}"
    elif [[ "${plugin_num}" == "11" ]]; then
        local pluginName="qtun"
        qtun_ver=$(get_plugins_version "${pluginName}")
        judge_latest_version_num_is_none_and_output_error_info "${pluginName}" "${qtun_ver}"

        # wriet version num
        if [ ! -d "$(dirname ${QTUN_VERSION_FILE})" ]; then
            mkdir -p $(dirname ${QTUN_VERSION_FILE})
        fi
        echo ${qtun_ver} > ${QTUN_VERSION_FILE}

        if [[ ${ARCH} = "amd64" ]]; then
            local MACHINE="x86_64"
        else
            local MACHINE="aarch64"
        fi

        qtun_file="qtun-v${qtun_ver}.${MACHINE}-unknown-linux-musl"
        qtun_url="https://github.com/shadowsocks/qtun/releases/download/v${qtun_ver}/qtun-v${qtun_ver}.${MACHINE}-unknown-linux-musl.tar.xz"
        download "${qtun_file}.tar.xz" "${qtun_url}"
    fi
}