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

download_ss_file(){
    cd ${CUR_DIR}
    if [[ ${SS_VERSION} = "ss-libev" ]]; then
        # Download Shadowsocks-libev
        libev_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/shadowsocks/shadowsocks-libev/releases | grep -o '"tag_name": ".*"' | head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${libev_ver} ] && echo -e "${Error} 获取 shadowsocks-libev 最新版本失败." && exit 1
        
        shadowsocks_libev_file="shadowsocks-libev-${libev_ver}"
        shadowsocks_libev_url="https://github.com/shadowsocks/shadowsocks-libev/releases/download/v${libev_ver}/shadowsocks-libev-${libev_ver}.tar.gz"
        download "${shadowsocks_libev_file}.tar.gz" "${shadowsocks_libev_url}"
        download_service_file ${SHADOWSOCKS_LIBEV_INIT} ${SHADOWSOCKS_LIBEV_INIT_ONLINE} ${SHADOWSOCKS_LIBEV_INIT_LOCAL}
    elif [[ ${SS_VERSION} = "ss-rust" ]]; then
        # Download Shadowsocks-rust
        rust_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/shadowsocks/shadowsocks-rust/releases | grep -o '"tag_name": ".*"' | head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${rust_ver} ] && echo -e "${Error} 获取 shadowsocks-rust 最新版本失败." && exit 1
        
        shadowsocks_rust_file="shadowsocks-v${rust_ver}.x86_64-unknown-linux-musl"
        shadowsocks_rust_url="https://github.com/shadowsocks/shadowsocks-rust/releases/download/v${rust_ver}/shadowsocks-v${rust_ver}.x86_64-unknown-linux-musl.tar.xz"
        download "${shadowsocks_rust_file}.tar.xz" "${shadowsocks_rust_url}"
        download_service_file ${SHADOWSOCKS_RUST_INIT} ${SHADOWSOCKS_RUST_INIT_ONLINE} ${SHADOWSOCKS_RUST_INIT_LOCAL}
    elif [[ ${SS_VERSION} = "go-ss2" ]]; then
        # Download Go-shadowsocks2
        go_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/shadowsocks/go-shadowsocks2/releases | grep -o '"tag_name": ".*"' | head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${go_ver} ] && echo -e "${Error} 获取 shadowsocks-rust 最新版本失败." && exit 1

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
        # Download v2ray-plugin
        v2ray_plugin_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/teddysun/v2ray-plugin/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${v2ray_plugin_ver} ] && echo -e "${Error} 获取 v2ray-plugin 最新版本失败." && exit 1
        v2ray_plugin_file="v2ray-plugin-linux-amd64-v${v2ray_plugin_ver}"
        v2ray_plugin_url="https://github.com/teddysun/v2ray-plugin/releases/download/v${v2ray_plugin_ver}/v2ray-plugin-linux-amd64-v${v2ray_plugin_ver}.tar.gz"
        download "${v2ray_plugin_file}.tar.gz" "${v2ray_plugin_url}"
        
    elif [[ "${plugin_num}" == "2" ]]; then        
        # Download kcptun
        kcptun_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/xtaci/kcptun/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${kcptun_ver} ] && echo -e "${Error} 获取 kcptun 最新版本失败." && exit 1
        kcptun_file="kcptun-linux-amd64-${kcptun_ver}"
        kcptun_url="https://github.com/xtaci/kcptun/releases/download/v${kcptun_ver}/kcptun-linux-amd64-${kcptun_ver}.tar.gz"
        download "${kcptun_file}.tar.gz" "${kcptun_url}"
        download_service_file ${KCPTUN_INIT} ${KCPTUN_INIT_ONLINE} ${KCPTUN_INIT_LOCAL}
        
    elif [[ "${plugin_num}" == "4" ]]; then        
        # Download goquiet
        goquiet_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/cbeuw/GoQuiet/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${goquiet_ver} ] && echo -e "${Error} 获取 goquiet 最新版本失败." && exit 1
        goquiet_file="gq-server-linux-amd64-${goquiet_ver}"
        goquiet_url="https://github.com/cbeuw/GoQuiet/releases/download/v${goquiet_ver}/gq-server-linux-amd64-${goquiet_ver}"
        download "${goquiet_file}" "${goquiet_url}"
        
    elif [[ "${plugin_num}" == "5" ]]; then
        # Download cloak server
        cloak_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/cbeuw/Cloak/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${cloak_ver} ] && echo -e "${Error} 获取 cloak 最新版本失败." && exit 1
        # cloak_ver="2.1.1"
        cloak_file="ck-server-linux-amd64-v${cloak_ver}"
        cloak_url="https://github.com/cbeuw/Cloak/releases/download/v${cloak_ver}/ck-server-linux-amd64-v${cloak_ver}"
        download "${cloak_file}" "${cloak_url}"
        download_service_file ${CLOAK_INIT} ${CLOAK_INIT_ONLINE} ${CLOAK_INIT_LOCAL}
    
    elif [[ "${plugin_num}" == "6" ]]; then
        # Download mos-tls-tunnel
        mtt_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/IrineSistiana/mos-tls-tunnel/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${mtt_ver} ] && echo -e "${Error} 获取 mos-tls-tunnel 最新版本失败." && exit 1
        # wriet version num
        if [ ! -d "$(dirname ${SHADOWSOCKS_CONFIG})" ]; then
            mkdir -p $(dirname ${SHADOWSOCKS_CONFIG})
        fi
        echo ${mtt_ver} > ${MTT_VERSION_FILE}
        mtt_file="mos-tls-tunnel-linux-amd64"
        mtt_url="https://github.com/IrineSistiana/mos-tls-tunnel/releases/download/v${mtt_ver}/mos-tls-tunnel-linux-amd64.zip"
        download "${mtt_file}.zip" "${mtt_url}"
    elif [[ "${plugin_num}" == "7" ]]; then
        # Download rabbit-tcp
        rabbit_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/ihciah/rabbit-tcp/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${rabbit_ver} ] && echo -e "${Error} 获取 rabbit-tcp 最新版本失败." && exit 1
        # wriet version num
        if [ ! -d "$(dirname ${RABBIT_VERSION_FILE})" ]; then
            mkdir -p $(dirname ${RABBIT_VERSION_FILE})
        fi
        echo ${rabbit_ver} > ${RABBIT_VERSION_FILE}
        rabbit_file="rabbit-linux-amd64"
        rabbit_url="https://github.com/ihciah/rabbit-tcp/releases/download/v${rabbit_ver}/rabbit-linux-amd64.gz"
        download "${rabbit_file}.gz" "${rabbit_url}"
        download_service_file ${RABBIT_INIT} ${RABBIT_INIT_ONLINE} ${RABBIT_INIT_LOCAL}
    elif [[ "${plugin_num}" == "8" ]]; then
        # Download simple-tls
        simple_tls_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/IrineSistiana/simple-tls/releases | grep -o '"tag_name": ".*"' | head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
        [ -z ${simple_tls_ver} ] && echo -e "${Error} 获取 simple-tls 最新版本失败." && exit 1
        if [[ ${SimpleTlsVer} = "1" ]]; then
            simple_tls_ver="0.3.4"
        fi
        # wriet version num
        if [ ! -d "$(dirname ${SIMPLE_TLS_VERSION_FILE})" ]; then
            mkdir -p $(dirname ${SIMPLE_TLS_VERSION_FILE})
        fi
        echo ${simple_tls_ver} > ${SIMPLE_TLS_VERSION_FILE}
        simple_tls_file="simple-tls-linux-amd64"
        simple_tls_url="https://github.com/IrineSistiana/simple-tls/releases/download/v${simple_tls_ver}/simple-tls-linux-amd64.zip"
        download "${simple_tls_file}.zip" "${simple_tls_url}"
    fi
}