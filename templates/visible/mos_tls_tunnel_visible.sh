# ss + mos-tls-tunnel show
ss_mtt_tls_show(){
    echo >> ${HUMAN_CONFIG}
    echo -e " Shadowsocks的配置信息：" >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " 地址     : ${Red}$(get_ip)${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 端口     : ${Red}${shadowsocksport}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 密码     : ${Red}${shadowsockspwd}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 加密     : ${Red}${shadowsockscipher}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 插件程序 : ${Red}${plugin_client_name}${suffix}" >> ${HUMAN_CONFIG}
    if [[ ${isEnable} == disable ]]; then
        echo -e " 插件选项 : ${Red}sv;n=${serverName}${suffix}" >> ${HUMAN_CONFIG}
    elif [[ ${isEnable} == enable ]]; then
        echo -e " 插件选项 : ${Red}sv;n=${serverName};mux${suffix}" >> ${HUMAN_CONFIG}
    fi
    echo -e " 插件参数 : " >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " SS  链接 : ${Green}${ss_link}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " SS二维码 : ./ss-plugins.sh scan < A link at the beginning of ss:// >" >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " ${Tip} SS链接${Red}不支持插件参数${suffix}导入，请手动填写。使用${Red}kcptun${suffix}插件时，该链接仅支持${Red}手机${suffix}导入." >> ${HUMAN_CONFIG}
    echo -e "        插件程序下载：https://github.com/IrineSistiana/mos-tls-tunnel/releases 下载 windows-amd64 版本" >> ${HUMAN_CONFIG}
    echo -e "        请解压将插件重命名为 ${plugin_client_name}.exe 并移动至 SS-Windows 客户端-安装目录的${Red}根目录${suffix}." >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
}

ss_mtt_tls_dns_only_show(){
    echo >> ${HUMAN_CONFIG}
    echo -e " Shadowsocks的配置信息：" >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " 地址     : ${Red}$(get_ip)${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 端口     : ${Red}${shadowsocksport}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 密码     : ${Red}${shadowsockspwd}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 加密     : ${Red}${shadowsockscipher}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 插件程序 : ${Red}${plugin_client_name}${suffix}" >> ${HUMAN_CONFIG}
    if [[ ${isEnable} == disable ]]; then
        echo -e " 插件选项 : ${Red}n=${serverName}${suffix}" >> ${HUMAN_CONFIG}
    elif [[ ${isEnable} == enable ]]; then
        echo -e " 插件选项 : ${Red}n=${serverName};mux${suffix}" >> ${HUMAN_CONFIG}
    fi
    echo -e " 插件参数 : " >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " SS  链接 : ${Green}${ss_link}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " SS二维码 : ./ss-plugins.sh scan < A link at the beginning of ss:// >" >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " ${Tip} SS链接${Red}不支持插件参数${suffix}导入，请手动填写。使用${Red}kcptun${suffix}插件时，该链接仅支持${Red}手机${suffix}导入." >> ${HUMAN_CONFIG}
    echo -e "        插件程序下载：https://github.com/IrineSistiana/mos-tls-tunnel/releases 下载 windows-amd64 版本" >> ${HUMAN_CONFIG}
    echo -e "        请解压将插件重命名为 ${plugin_client_name}.exe 并移动至 SS-Windows 客户端-安装目录的${Red}根目录${suffix}." >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
}

ss_mtt_wss_show(){
    echo >> ${HUMAN_CONFIG}
    echo -e " Shadowsocks的配置信息：" >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " 地址     : ${Red}$(get_ip)${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 端口     : ${Red}${shadowsocksport}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 密码     : ${Red}${shadowsockspwd}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 加密     : ${Red}${shadowsockscipher}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 插件程序 : ${Red}${plugin_client_name}${suffix}" >> ${HUMAN_CONFIG}
    if [[ ${isEnable} == disable ]]; then
        echo -e " 插件选项 : ${Red}sv;wss;wss-path=${wssPath};n=${serverName}${suffix}" >> ${HUMAN_CONFIG}
    elif [[ ${isEnable} == enable ]]; then
        echo -e " 插件选项 : ${Red}sv;wss;wss-path=${wssPath};n=${serverName};mux;mux-max-stream=${muxMaxStream}${suffix}" >> ${HUMAN_CONFIG}
    fi
    echo -e " 插件参数 : " >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " SS  链接 : ${Green}${ss_link}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " SS二维码 : ./ss-plugins.sh scan < A link at the beginning of ss:// >" >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " ${Tip} SS链接${Red}不支持插件参数${suffix}导入，请手动填写。使用${Red}kcptun${suffix}插件时，该链接仅支持${Red}手机${suffix}导入." >> ${HUMAN_CONFIG}
    echo -e "        插件程序下载：https://github.com/IrineSistiana/mos-tls-tunnel/releases 下载 windows-amd64 版本" >> ${HUMAN_CONFIG}
    echo -e "        请解压将插件重命名为 ${plugin_client_name}.exe 并移动至 SS-Windows 客户端-安装目录的${Red}根目录${suffix}." >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
}

ss_mtt_wss_dns_only_or_cdn_show(){
    echo >> ${HUMAN_CONFIG}
    echo -e " Shadowsocks的配置信息：" >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    if [[ ${domainType} = DNS-Only ]]; then
        echo -e " 地址     : ${Red}$(get_ip)${suffix}" >> ${HUMAN_CONFIG}
    elif [[ ${domainType} = CDN ]]; then
        echo -e " 地址     : ${Red}${serverName}${suffix}" >> ${HUMAN_CONFIG}
    fi
    echo -e " 端口     : ${Red}${shadowsocksport}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 密码     : ${Red}${shadowsockspwd}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 加密     : ${Red}${shadowsockscipher}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 插件程序 : ${Red}${plugin_client_name}${suffix}" >> ${HUMAN_CONFIG}
    if [[ ${isEnable} == disable ]]; then
        echo -e " 插件选项 : ${Red}wss;wss-path=${wssPath};n=${serverName}${suffix}" >> ${HUMAN_CONFIG}
    elif [[ ${isEnable} == enable ]]; then
        echo -e " 插件选项 : ${Red}wss;wss-path=${wssPath};n=${serverName};mux;mux-max-stream=${muxMaxStream}${suffix}" >> ${HUMAN_CONFIG}
    fi
    echo -e " 插件参数 : " >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " SS  链接 : ${Green}${ss_link}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " SS二维码 : ./ss-plugins.sh scan < A link at the beginning of ss:// >" >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " ${Tip} SS链接${Red}不支持插件参数${suffix}导入，请手动填写。使用${Red}kcptun${suffix}插件时，该链接仅支持${Red}手机${suffix}导入." >> ${HUMAN_CONFIG}
    echo -e "        插件程序下载：https://github.com/IrineSistiana/mos-tls-tunnel/releases 下载 windows-amd64 版本" >> ${HUMAN_CONFIG}
    echo -e "        请解压将插件重命名为 ${plugin_client_name}.exe 并移动至 SS-Windows 客户端-安装目录的${Red}根目录${suffix}." >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
}

ss_mtt_wss_dns_only_or_cdn_web_show(){
    echo >> ${HUMAN_CONFIG}
    echo -e " Shadowsocks的配置信息：" >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    if [[ ${domainType} = DNS-Only ]]; then
        echo -e " 地址     : ${Red}$(get_ip)${suffix}" >> ${HUMAN_CONFIG}
    elif [[ ${domainType} = CDN ]]; then
        echo -e " 地址     : ${Red}${serverName}${suffix}" >> ${HUMAN_CONFIG}
    fi
    echo -e " 端口     : ${Red}443${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 密码     : ${Red}${shadowsockspwd}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 加密     : ${Red}${shadowsockscipher}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 插件程序 : ${Red}${plugin_client_name}${suffix}" >> ${HUMAN_CONFIG}
    if [[ ${isEnable} == disable ]]; then
        echo -e " 插件选项 : ${Red}wss;wss-path=${wssPath};n=${serverName}${suffix}" >> ${HUMAN_CONFIG}
    elif [[ ${isEnable} == enable ]]; then
        echo -e " 插件选项 : ${Red}wss;wss-path=${wssPath};n=${serverName};mux;mux-max-stream=${muxMaxStream}${suffix}" >> ${HUMAN_CONFIG}
    fi
    echo -e " 插件参数 : " >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " SS  链接 : ${Green}${ss_link}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " SS二维码 : ./ss-plugins.sh scan < A link at the beginning of ss:// >" >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " ${Tip} SS链接${Red}不支持插件参数${suffix}导入，请手动填写。使用${Red}kcptun${suffix}插件时，该链接仅支持${Red}手机${suffix}导入." >> ${HUMAN_CONFIG}
    echo -e "        插件程序下载：https://github.com/IrineSistiana/mos-tls-tunnel/releases 下载 windows-amd64 版本" >> ${HUMAN_CONFIG}
    echo -e "        请解压将插件重命名为 ${plugin_client_name}.exe 并移动至 SS-Windows 客户端-安装目录的${Red}根目录${suffix}." >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
}

ss_mos_tls_tunnel_visible(){
    if [[ ${libev_mtt} == "1" ]]; then
        if [[ ${domainType} = DNS-Only ]]; then
            ss_mtt_tls_dns_only_show
        else
            ss_mtt_tls_show
        fi
    elif [[ ${libev_mtt} == "2" ]]; then
        if [[ ${isEnableWeb} = disable ]]; then
            ss_mtt_wss_dns_only_or_cdn_show
        elif [[ ${isEnableWeb} = enable ]]; then
            if [[ ${web_flag} = "1" ]]; then
                # start caddy
                /etc/init.d/caddy start > /dev/null 2>&1
            elif [[ ${web_flag} = "2" ]]; then
                systemctl start nginx
            fi 
            ss_mtt_wss_dns_only_or_cdn_web_show
        else
            ss_mtt_wss_show
        fi
    fi
}