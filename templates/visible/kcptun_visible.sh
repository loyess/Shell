# ss + kcptun show
ss_kcptun_show(){
    echo >> ${HUMAN_CONFIG}
    echo -e " Shadowsocks的配置信息：" >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " 地址     : ${Red}$(get_ip)${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 端口     : ${Red}${listen_port}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 密码     : ${Red}${shadowsockspwd}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 加密     : ${Red}${shadowsockscipher}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 插件程序 : ${Red}${plugin_client_name}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " 插件选项 :                                      " >> ${HUMAN_CONFIG}
    if [[ ${nocomp} == false ]] && [[ ${KP_TCP} == false ]]; then
        echo -e " 插件参数 : ${Red}-l %SS_LOCAL_HOST%:%SS_LOCAL_PORT% -r %SS_REMOTE_HOST%:%SS_REMOTE_PORT% --crypt ${crypt} --key ${key} --mtu ${MTU} --sndwnd ${rcvwnd} --rcvwnd ${sndwnd} --mode ${mode} --datashard ${datashard} --parityshard ${parityshard} --dscp ${DSCP}${suffix}" >> ${HUMAN_CONFIG}
        echo >> ${HUMAN_CONFIG}
        echo -e " 手机参数 : crypt=${crypt};key=${key};mtu=${MTU};sndwnd=${rcvwnd};rcvwnd=${sndwnd};mode=${mode};datashard=${datashard};parityshard=${parityshard};dscp=${DSCP}" >> ${HUMAN_CONFIG}
    elif [[ ${nocomp} == true ]] && [[ ${KP_TCP} == false ]]; then
        echo -e " 插件参数 : ${Red}-l %SS_LOCAL_HOST%:%SS_LOCAL_PORT% -r %SS_REMOTE_HOST%:%SS_REMOTE_PORT% --crypt ${crypt} --key ${key} --mtu ${MTU} --sndwnd ${rcvwnd} --rcvwnd ${sndwnd} --mode ${mode} --datashard ${datashard} --parityshard ${parityshard} --dscp ${DSCP} --nocomp ${nocomp}${suffix}" >> ${HUMAN_CONFIG}
        echo >> ${HUMAN_CONFIG}
        echo -e " 手机参数 : crypt=${crypt};key=${key};mtu=${MTU};sndwnd=${rcvwnd};rcvwnd=${sndwnd};mode=${mode};datashard=${datashard};parityshard=${parityshard};dscp=${DSCP};nocomp=${nocomp}" >> ${HUMAN_CONFIG}
    else
        echo -e " 插件参数 : ${Red}-l %SS_LOCAL_HOST%:%SS_LOCAL_PORT% -r %SS_REMOTE_HOST%:%SS_REMOTE_PORT% --crypt ${crypt} --key ${key} --mtu ${MTU} --sndwnd ${rcvwnd} --rcvwnd ${sndwnd} --mode ${mode} --datashard ${datashard} --parityshard ${parityshard} --dscp ${DSCP} --nocomp ${nocomp} --tcp ${KP_TCP}${suffix}" >> ${HUMAN_CONFIG}
        echo >> ${HUMAN_CONFIG}
        echo -e " 手机参数 : crypt=${crypt};key=${key};mtu=${MTU};sndwnd=${rcvwnd};rcvwnd=${sndwnd};mode=${mode};datashard=${datashard};parityshard=${parityshard};dscp=${DSCP};nocomp=${nocomp};tcp=${KP_TCP}" >> ${HUMAN_CONFIG}
    fi
    echo >> ${HUMAN_CONFIG}
    echo -e " SS  链接 : ${Green}${ss_link}${suffix}" >> ${HUMAN_CONFIG}
    echo -e " SS二维码 : ./ss-plugins.sh scan < A link at the beginning of ss:// >" >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
    echo -e " ${Tip} SS链接${Red}不支持插件参数${suffix}导入，请手动填写。使用${Red}kcptun${suffix}插件时，该链接仅支持${Red}手机${suffix}导入." >> ${HUMAN_CONFIG}
    echo -e "        插件程序下载：https://github.com/xtaci/kcptun/releases 下载 windows-amd64 版本." >> ${HUMAN_CONFIG}
    echo -e "        请解压将带client字样的文件重命名为 ${plugin_client_name}.exe 并移至 SS-Windows 客户端-安装目录的${Red}根目录${suffix}." >> ${HUMAN_CONFIG}
    echo >> ${HUMAN_CONFIG}
}

ss_kcptun_visible(){
    ${KCPTUN_INIT} start  > /dev/null 2>&1
    ss_kcptun_show
}