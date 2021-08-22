ss_rabbit_tcp_show(){
    echo >> ${HUMAN_CONFIG}
    echo -e " Shadowsocks的配置信息：" >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " 地址     : ${Red}$(get_ip)${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 端口     : ${Red}${listen_port}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 密码     : ${Red}${shadowsockspwd}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 加密     : ${Red}${shadowsockscipher}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 插件程序 : ${Red}${plugin_client_name}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 插件选项 : ${Red}serviceAddr=$(get_ip):${shadowsocksport};password=${rabbitKey};tunnelN=4${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 插件参数 : " >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " SS  链接 : ${Green}${ss_link}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " SS二维码 : ./ss-plugins.sh scan < A link at the beginning of ss:// >" >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " ${Tip} SS链接${Red}不支持插件参数${suffix}导入，请手动填写。使用${Red}kcptun${suffix}插件时，该链接仅支持${Red}手机${suffix}导入." >> ${HUMAN_CONFIG}
    echo -e "        插件程序下载：https://github.com/ihciah/rabbit-plugin/releases 下载 windows-amd64 版本" >> ${HUMAN_CONFIG}
    echo -e "        请解压将插件重命名为 ${plugin_client_name}.exe 并移动至 SS-Windows 客户端-安装目录的${Red}根目录${suffix}." >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
}

ss_rabbit_tcp_visible(){
    ${RABBIT_INIT} start  > /dev/null 2>&1
    ss_rabbit_tcp_show
}