add_a_new_uid(){
    if [[ -e '/usr/local/bin/ck-server' ]]; then
    
        if [[ ! -e '/usr/local/bin/ck-client' ]]; then
            get_ver
            # Download cloak client
            local cloak_file="ck-client-linux-amd64-${cloak_ver}"
            local cloak_url="https://github.com/cbeuw/Cloak/releases/download/v${cloak_ver}/ck-client-linux-amd64-${cloak_ver}"
            download "${cloak_file}" "${cloak_url}"
            
            # install ck-client
            cd ${CUR_DIR}
            chmod +x ${cloak_file}
            mv ${cloak_file} /usr/local/bin/ck-client
        fi
        
        # get parameter from ss config.json
        gen_credentials
        local new_uid=${ckauid}
        local ip=$(get_ip)
        local port=443
        local admin_uid=$(cat ${SHADOWSOCKS_LIBEV_CONFIG} | grep -o -P "AdminUID=.*?;" | sed 's/AdminUID=//g;s/;//g')

        # show about info
        echo
        echo -e " ${Green}UID  (新)${suffix}：${Red}${new_uid}${suffix}"
        echo
        echo -e " ${Green}IP (端口)${suffix}：${Red}${ip}:${port}${suffix}"
        echo -e " ${Green}UID(管理)${suffix}：${Red}${admin_uid}${suffix}"
        echo
        echo -e "
 添加新用户：
    1. ck-server -u 生成一个New 的 UID
    2. ck-client -a -c <path-to-ckclient.json> 进入admin 模式。
    3. 输入，服务器ip:port 和 AdminUID ，选择4 ，新建一个用户。
    4. 根据提示输入如下：
        1. Newly generated UID      # 输入上方新生成的 UID
        2. SessionsCap              # 用户可以拥有的最大并发会话数(填写 4)
        3. UpRate                   # 上行速度 (单位：bytes/s)
        4. DownRate                 # 下行速度 (单位：bytes/s)
        5. UpCredit                 # 上行限制 (单位：bytes)
        6. DownCredit               # 下行限制 (单位：bytes)
        7. ExpiryTime               # user账号的有效期，unix时间格式(10位时间戳)
    5. 将你的 公钥 和 新生成的UID 给这个新用户。
    
 ${Tip} 下方输入从第3步开始，根据提示输入，退出请按 Ctrl + C ...
 
 "
        
        # Enter admin mode
        ck-client -a -c ${CK_CLIENT_CONFIG}
    else
        echo
        echo -e " ${Error} 仅支持 ss + cloak 下使用，请确认是否是以该组合形式运行..."
        echo
        exit 1
    fi
}