install_prepare_libev_kcptun(){ 
    # 设置 Kcptun 服务器监听端口 listen_port
    while true
    do
        echo -e "请输入 Kcptun 服务端运行端口 [1-65535]\n${Tip} 这个端口，就是 Kcptun 客户端要连接的端口."
        read -e -p "(默认: 29900):" listen_port
        [ -z "${listen_port}" ] && listen_port=29900
        expr ${listen_port} + 1 &>/dev/null
        if [ $? -eq 0 ]; then
            if [ ${listen_port} -ge 1 ] && [ ${listen_port} -le 65535 ] && [ ${listen_port:0:1} != 0 ]; then
                echo
                echo -e "${Red}  port = ${listen_port}${suffix}"
                echo
                break
            fi
        fi
        echo
        echo -e "${Error} 请输入一个正确的数 [1-65535]"
        echo
        continue
    done
    
    # 设置需要 Kcptun 加速的目标服务器地址 target_addr
    while true
    do
        echo -e "请输入需要加速的地址\n${Tip} 可以输入IPv4 地址或者 IPv6 地址."
        read -e -p "(默认: 127.0.0.1):" target_addr
        [ -z "${target_addr}" ] && target_addr=127.0.0.1
        if is_ipv4_or_ipv6 ${target_addr}; then
            echo
            echo -e "${Red}  ip(target) = ${target_addr}${suffix}"
            echo
            break
        else
            echo
            echo -e "${Error} 请输入正确合法的IP地址."
            echo
            continue
        fi
    done
    
    # 设置需要 Kcptun 加速的目标服务器端口 target_port
    while true
    do
        echo -e "请输入需要加速的端口 [1-65535]\n${Tip} 这里用来加速SS，那就输入前面填写过的SS的端口: ${Red}${shadowsocksport}${suffix}"
        read -e -p "(默认: ${shadowsocksport}):" target_port
        [ -z "${target_port}" ] && target_port=${shadowsocksport}
        expr ${target_port} + 1 &>/dev/null
        if [ $? -eq 0 ]; then
            if [ ${target_port} -ge 1 ] && [ ${target_port} -le 65535 ] && [ ${target_port:0:1} != 0 ]; then
                echo
                echo -e "${Red}  port(target) = ${target_port}${suffix}"
                echo
                break
            fi
        fi
        echo
        echo -e "${Error} 请输入一个正确的数 [1-65535]"
        echo
        continue
    done
    
    # 设置 Kcptun 密码 key
    gen_random_str
    echo -e "请设置 Kcptun 密码(key)\n${Tip} 该参数必须两端一致，另外这里的密码是kcptun的密码，与Shadowsocks半毛钱关系都没有，别弄混淆了."
    read -e -p "(默认: ${ran_str8}):" key
    [ -z "${key}" ] && key=${ran_str8}
    echo
    echo -e "${Red}  key = ${key}${suffix}"
    echo
    
    # 设置 Kcptun 加密方式 crypt
    while true
    do
        echo -e "请选择加密方式(crypt)\n${Tip} 强加密对 CPU 要求较高，如果是在路由器上配置客户端，请尽量选择弱加密或者不加密。该参数必须两端一致"

        for ((i=1;i<=${#KCPTUN_CRYPT[@]};i++ )); do
            hint="${KCPTUN_CRYPT[$i-1]}"
            if [[ ${i} -le 9 ]]; then
                echo -e "${Green}  ${i}.${suffix} ${hint}"
            else
                echo -e "${Green} ${i}.${suffix} ${hint}"
            fi
        done
        
        echo
        read -e -p "(默认: ${KCPTUN_CRYPT[0]}):" crypt
        [ -z "$crypt" ] && crypt=1
        expr ${crypt} + 1 &>/dev/null
        if [ $? -ne 0 ]; then
            echo
            echo -e "${Error} 请输入一个数字."
            echo
            continue
        fi
        if [[ "$crypt" -lt 1 || "$crypt" -gt ${#KCPTUN_CRYPT[@]} ]]; then
            echo
            echo -e "${Error} 请输入一个数字在 [1-${#KCPTUN_CRYPT[@]}] 之间."
            echo
            continue
        fi
        crypt=${KCPTUN_CRYPT[$crypt-1]}

        echo
        echo -e "${Red}  crypt = ${crypt}${suffix}"
        echo
        break
    done
    
    # 设置 Kcptun 加速模式 mode
    while true
    do
        echo -e "请选择加速模式(mode)\n${Tip} 加速模式和发送窗口大小共同决定了流量的损耗大小. ${Red}未支持(手动模式 manual)${suffix}”"

        for ((i=1;i<=${#KCPTUN_MODE[@]};i++ )); do
            hint="${KCPTUN_MODE[$i-1]}"
            if [[ ${i} -le 9 ]]; then
                echo -e "${Green}  ${i}.${suffix} ${hint}"
            else
                echo -e "${Green} ${i}.${suffix} ${hint}"
            fi
        done
        
        echo
        read -e -p "(默认: ${KCPTUN_MODE[1]}):" mode
        [ -z "$mode" ] && mode=2
        expr ${mode} + 1 &>/dev/null
        if [ $? -ne 0 ]; then
            echo
            echo -e "${Error} 请输入一个数字."
            echo
            continue
        fi
        if [[ "$mode" -lt 1 || "$mode" -gt ${#KCPTUN_MODE[@]} ]]; then
            echo
            echo -e "${Error} 请输入一个数字在 [1-${#KCPTUN_MODE[@]}] 之间."
            echo
            continue
        fi
        mode=${KCPTUN_MODE[$mode-1]}

        echo
        echo -e "${Red}  mode = ${mode}${suffix}"
        echo
        break
    done
    
    # 设置 UDP 数据包的 MTU (最大传输单元)值
    while true
    do
        echo -e "请设置 UDP 数据包的 MTU (最大传输单元)值"
        read -e -p "(默认: 1350):" MTU
        [ -z "${MTU}" ] && MTU=1350
        expr ${MTU} + 1 &>/dev/null
        if [ $? -eq 0 ]; then
            if [ ${MTU} -ge 1 ] && [ ${MTU:0:1} != 0 ]; then
                echo
                echo -e "${Red}  MTU = ${MTU}${suffix}"
                echo
                break
            fi
        fi
        echo
        echo -e "${Error} 请输入一个大于0的数."
        echo
        continue
    done
    
    # 设置发送窗口大小 sndwnd
    while true
    do
        echo -e "请设置发送窗口大小(sndwnd)\n${Tip} 发送窗口过大会浪费过多流量"
        read -e -p "(默认: 1024):" sndwnd
        [ -z "${sndwnd}" ] && sndwnd=1024
        expr ${sndwnd} + 1 &>/dev/null
        if [ $? -eq 0 ]; then
            if [ ${sndwnd} -ge 1 ] && [ ${sndwnd:0:1} != 0 ]; then
                echo
                echo -e "${Red}  sndwnd = ${sndwnd}${suffix}"
                echo
                break
            fi
        fi
        echo
        echo -e "${Error} 请输入一个大于0的数."
        echo
        continue
    done
    
    # 设置接收窗口大小 rcvwnd
    while true
    do
        echo -e "请设置接收窗口大小(rcvwnd)"
        read -e -p "(默认: 1024):" rcvwnd
        [ -z "${rcvwnd}" ] && rcvwnd=1024
        expr ${rcvwnd} + 1 &>/dev/null
        if [ $? -eq 0 ]; then
            if [ ${rcvwnd} -ge 1 ] && [ ${rcvwnd:0:1} != 0 ]; then
                echo
                echo -e "${Red}  rcvwnd = ${rcvwnd}${suffix}"
                echo
                break
            fi
        fi
        echo
        echo -e "${Error} 请输入一个大于0的数."
        echo
        continue
    done

    # 设置前向纠错 datashard
    while true
    do
        echo -e "请设置前向纠错(datashard) \n${Tip} 该参数必须两端一致"
        read -e -p "(默认: 10):" datashard
        [ -z "${datashard}" ] && datashard=10
        expr ${datashard} + 1 &>/dev/null
        if [ $? -eq 0 ]; then
            if [ ${datashard} -ge 1 ] && [ ${datashard:0:1} != 0 ]; then
                echo
                echo -e "${Red}  datashard = ${datashard}${suffix}"
                echo
                break
            fi
        fi
        echo
        echo -e "${Error} 请输入一个大于0的数."
        echo
        continue
    done
    
    # 设置前向纠错 parityshard
    while true
    do
        echo -e "请设置前向纠错(parityshard) \n${Tip} 该参数必须两端一致"
        read -e -p "(默认: 3):" parityshard
        [ -z "${parityshard}" ] && parityshard=3
        expr ${parityshard} + 1 &>/dev/null
        if [ $? -eq 0 ]; then
            if [ ${parityshard} -ge 1 ] && [ ${parityshard:0:1} != 0 ]; then
                echo
                echo -e "${Red}  parityshard = ${parityshard}${suffix}"
                echo
                break
            fi
        fi
        echo
        echo -e "${Error} 请输入一个大于0的数."
        echo
        continue
    done
    
    # 设置差分服务代码点 DSCP
    while true
    do
        echo -e "设置差分服务代码点(DSCP)"
        read -e -p "(默认: 46):" DSCP
        [ -z "${DSCP}" ] && DSCP=46
        expr ${DSCP} + 1 &>/dev/null
        if [ $? -eq 0 ]; then
            if [ ${DSCP} -ge 1 ] && [ ${DSCP:0:1} != 0 ]; then
                echo
                echo -e "${Red}  DSCP = ${DSCP}${suffix}"
                echo
                break
            fi
        fi
        echo
        echo -e "${Error} 请输入一个大于0的数."
        echo
        continue
    done 
}