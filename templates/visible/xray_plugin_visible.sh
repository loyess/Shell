# ss + xray-plugin show
ss_xray_plugin_ws_show(){
    echo >> ${HUMAN_CONFIG}
    echo -e " Shadowsocks的配置信息：" >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " 地址     : ${Red}$(get_ip)${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 端口     : ${Red}${shadowsocksport}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 密码     : ${Red}${shadowsockspwd}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 加密     : ${Red}${shadowsockscipher}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 插件程序 : ${Red}${plugin_client_name}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 插件选项 : ${Red}path=${path}${muxOption}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 插件参数 : " >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " SS  链接 : ${Green}${ss_link}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " SS二维码 : ./ss-plugins.sh scan < A link at the beginning of ss:// >" >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " ${Tip} SS链接${Red}不支持插件参数${suffix}导入，请手动填写。使用${Red}kcptun${suffix}插件时，该链接仅支持${Red}手机${suffix}导入." >> ${HUMAN_CONFIG}
    echo -e "        插件程序下载：https://github.com/teddysun/xray-plugin/releases 下载 windows-amd64 版本" >> ${HUMAN_CONFIG}
    echo -e "        请解压将插件重命名为 ${plugin_client_name}.exe 并移动至 SS-Windows 客户端-安装目录的${Red}根目录${suffix}." >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
}

ss_xray_plugin_ws_with_web_show(){
    echo >> ${HUMAN_CONFIG}
    echo -e " Shadowsocks的配置信息：" >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " 地址     : ${Red}${domain}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 端口     : ${Red}${shadowsocksport}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 密码     : ${Red}${shadowsockspwd}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 加密     : ${Red}${shadowsockscipher}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 插件程序 : ${Red}${plugin_client_name}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 插件选项 : ${Red}tls;host=${domain};path=${path}${muxOption}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 插件参数 : " >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " SS  链接 : ${Green}${ss_link}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " SS二维码 : ./ss-plugins.sh scan < A link at the beginning of ss:// >" >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " ${Tip} SS链接${Red}不支持插件参数${suffix}导入，请手动填写。使用${Red}kcptun${suffix}插件时，该链接仅支持${Red}手机${suffix}导入." >> ${HUMAN_CONFIG}
    echo -e "        插件程序下载：https://github.com/teddysun/xray-plugin/releases 下载 windows-amd64 版本" >> ${HUMAN_CONFIG}
    echo -e "        请解压将插件重命名为 ${plugin_client_name}.exe 并移动至 SS-Windows 客户端-安装目录的${Red}根目录${suffix}." >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
}

ss_xray_plugin_wss_with_cdn_show(){
    echo >> ${HUMAN_CONFIG}
    echo -e " Shadowsocks的配置信息：" >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " 地址     : ${Red}${domain}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 端口     : ${Red}${shadowsocksport}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 密码     : ${Red}${shadowsockspwd}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 加密     : ${Red}${shadowsockscipher}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 插件程序 : ${Red}${plugin_client_name}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 插件选项 : ${Red}tls;host=${domain};path=${path}${muxOption}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 插件参数 : " >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " SS  链接 : ${Green}${ss_link}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " SS二维码 : ./ss-plugins.sh scan < A link at the beginning of ss:// >" >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " ${Tip} SS链接${Red}不支持插件参数${suffix}导入，请手动填写。使用${Red}kcptun${suffix}插件时，该链接仅支持${Red}手机${suffix}导入." >> ${HUMAN_CONFIG}
    echo -e "        插件程序下载：https://github.com/teddysun/xray-plugin/releases 下载 windows-amd64 版本" >> ${HUMAN_CONFIG}
    echo -e "        请解压将插件重命名为 ${plugin_client_name}.exe 并移动至 SS-Windows 客户端-安装目录的${Red}根目录${suffix}." >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
}

ss_xray_plugin_quic_show(){
    echo >> ${HUMAN_CONFIG}
    echo -e " Shadowsocks的配置信息：" >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " 地址     : ${Red}${domain}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 端口     : ${Red}${shadowsocksport}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 密码     : ${Red}${shadowsockspwd}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 加密     : ${Red}${shadowsockscipher}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 插件程序 : ${Red}${plugin_client_name}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 插件选项 : ${Red}mode=quic;host=${domain}${muxOption}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 插件参数 : " >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " SS  链接 : ${Green}${ss_link}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " SS二维码 : ./ss-plugins.sh scan < A link at the beginning of ss:// >" >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " ${Tip} SS链接${Red}不支持插件参数${suffix}导入，请手动填写。使用${Red}kcptun${suffix}插件时，该链接仅支持${Red}手机${suffix}导入." >> ${HUMAN_CONFIG}
    echo -e "        插件程序下载：https://github.com/teddysun/xray-plugin/releases 下载 windows-amd64 版本" >> ${HUMAN_CONFIG}
    echo -e "        请解压将插件重命名为 ${plugin_client_name}.exe 并移动至 SS-Windows 客户端-安装目录的${Red}根目录${suffix}." >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
}

ss_xray_plugin_visible(){
    if [[ ${libev_xray_plugin} == "1" ]]; then
        if [[ ${web_flag} = "1" ]]; then
            # start caddy
            /etc/init.d/caddy start > /dev/null 2>&1
        elif [[ ${web_flag} = "2" ]]; then
            systemctl start nginx
        fi
        if [[ ${isEnableWeb} == enable ]]; then
            ss_xray_plugin_ws_with_web_show
        else
            ss_xray_plugin_ws_show
        fi
    elif [[ ${libev_xray_plugin} == "2" ]]; then
        ss_xray_plugin_wss_with_cdn_show
    elif [[ ${libev_xray_plugin} == "3" ]]; then
        ss_xray_plugin_quic_show  
    fi
}