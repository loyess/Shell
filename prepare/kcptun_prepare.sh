# kcptun crypt
KCPTUN_CRYPT=(
aes
aes-128
aes-192
salsa20
blowfish
twofish
cast5
3des
tea
xtea
xor
sm4
none
)

# kcptun mode(no manual)
KCPTUN_MODE=(
fast3
fast2
fast
normal
)


get_input_port(){
    # 设置 Kcptun 服务器监听端口 listen_port
    while true
    do
        gen_random_prot
        _read "请输入监听端口[1-65535] (默认: ${ran_prot}):"
        listen_port="${inputInfo}"
        [ -z "${listen_port}" ] && listen_port="${ran_prot}"
        if ! judge_is_num "${listen_port}"; then
            _echo -e "请输入一个有效数字."
            continue
        fi
        if judge_is_zero_begin_num "${listen_port}"; then
            _echo -e "请输入一个非0开头的数字."
            continue
        fi
        if ! judge_num_in_range "${listen_port}" "65535"; then
            _echo -e "请输入一个在1-65535之间的数字."
            continue
        fi
        if judge_is_equal_num "${listen_port}" "${shadowsocksport}"; then
            _echo -e "请输入一个与SS端口不同的数字."
            continue
        fi
        kill_process_if_port_occupy "${listen_port}"
        _echo -r "  port = ${listen_port}"
        break
    done
}

get_input_password(){
    # 设置 Kcptun 密码 key
    gen_random_str
    _read "请输入密码 (默认: ${ran_str12}):"
    key="${inputInfo}"
    [ -z "${key}" ] && key=${ran_str12}
    _echo -r "  key = ${key}"
}

get_input_crypt(){
    # 设置 Kcptun 加密方式 crypt
    generate_menu_logic "${KCPTUN_CRYPT[*]}" "加密方式" "13"
    crypt="${optionValue}"
}

get_input_accelerate_mode(){
    # 设置 Kcptun 加速模式 mode
    generate_menu_logic "${KCPTUN_MODE[*]}" "加速模式" "2"
    mode="${optionValue}"
    _echo -t "加速模式和发送窗口大小共同决定了流量的损耗大小(manual未支持)."
}

get_input_mtu(){
   # 设置 UDP 数据包的 MTU (最大传输单元)值
    while true
    do
        _read "请设置 UDP 数据包的 MTU (最大传输单元)值 (默认: 1350):"
        MTU="${inputInfo}"
        [ -z "${MTU}" ] && MTU=1350
        if ! judge_is_num "${MTU}"; then
            _echo -e "请输入一个有效数字."
            continue
        fi
        if judge_is_zero_begin_num "${MTU}"; then
            _echo -e "请输入一个非0开头的数字."
            continue
        fi
        if [ ${MTU} -lt 1 ]; then
            _echo -e "请输入一个大于0的数."
            continue
        fi
        _echo -r "  MTU = ${MTU}"
        break
    done
}

get_input_sndwnd(){
    # 设置发送窗口大小 sndwnd
    while true
    do
        _read "请设置发送窗口(sndwnd)大小 (默认: 1024):"
        sndwnd="${inputInfo}"
        [ -z "${sndwnd}" ] && sndwnd=1024
        if ! judge_is_num "${sndwnd}"; then
            _echo -e "请输入一个有效数字."
            continue
        fi
        if judge_is_zero_begin_num "${sndwnd}"; then
            _echo -e "请输入一个非0开头的数字."
            continue
        fi
        if [ ${sndwnd} -lt 1 ]; then
            _echo -e "请输入一个大于0的数."
            continue
        fi
        _echo -r "  sndwnd = ${sndwnd}"
        _echo -t "发送窗口过大会浪费过多流量."
        break
    done
}

get_input_rcvwnd(){
    # 设置接收窗口大小 rcvwnd
    while true
    do
        _read "请设置接收窗口(rcvwnd)大小 (默认: 1024):"
        rcvwnd="${inputInfo}"
        [ -z "${rcvwnd}" ] && rcvwnd=1024
        if ! judge_is_num "${rcvwnd}"; then
            _echo -e "请输入一个有效数字."
            continue
        fi
        if judge_is_zero_begin_num "${rcvwnd}"; then
            _echo -e "请输入一个非0开头的数字."
            continue
        fi
        if [ ${rcvwnd} -lt 1 ]; then
            _echo -e "请输入一个大于0的数."
            continue
        fi
        _echo -r "  rcvwnd = ${rcvwnd}"
        break
    done
}

get_input_datashard(){
    # 设置前向纠错 datashard
    while true
    do
        _read "请设置前向纠错(datashard) (默认: 10):"
        datashard="${inputInfo}"
        [ -z "${datashard}" ] && datashard=10
        if ! judge_is_num "${datashard}"; then
            _echo -e "请输入一个有效数字."
            continue
        fi
        if judge_is_zero_begin_num "${datashard}"; then
            _echo -e "请输入一个非0开头的数字."
            continue
        fi
        if [ ${datashard} -lt 1 ]; then
            _echo -e "请输入一个大于0的数."
            continue
        fi
        _echo -r "  datashard = ${datashard}"
        _echo -t "该参数必须两端一致."
        break
    done
}

get_input_parityshard(){
    # 设置前向纠错 parityshard
    while true
    do
        _read "请设置前向纠错(parityshard) (默认: 3):"
        parityshard="${inputInfo}"
        [ -z "${parityshard}" ] && parityshard=3
        if ! judge_is_num "${parityshard}"; then
            _echo -e "请输入一个有效数字."
            continue
        fi
        if judge_is_zero_begin_num "${parityshard}"; then
            _echo -e "请输入一个非0开头的数字."
            continue
        fi
        if [ ${parityshard} -lt 1 ]; then
            _echo -e "请输入一个大于0的数."
            continue
        fi
        _echo -r "  parityshard = ${parityshard}"
        _echo -t "该参数必须两端一致."
        break
    done
}

get_input_dscp(){
    # 设置差分服务代码点 DSCP
    while true
    do
        _read "请设置差分服务代码点(DSCP) (默认: 46):"
        DSCP="${inputInfo}"
        [ -z "${DSCP}" ] && DSCP=46
        if ! judge_is_num "${DSCP}"; then
            _echo -e "请输入一个有效数字."
            continue
        fi
        if judge_is_zero_begin_num "${DSCP}"; then
            _echo -e "请输入一个非0开头的数字."
            continue
        fi
        if [ ${DSCP} -lt 1 ]; then
            _echo -e "请输入一个大于0的数."
            continue
        fi
        _echo -r "  DSCP = ${DSCP}"
        break
    done 
}

is_disable_nocomp(){
    # 是否关闭数据压缩 nocomp
    while true
    do
		_read "是否禁用数据压缩(nocomp) (默认: n) [y/n]:"
        local yn="${inputInfo}"
        [ -z "${yn}" ] && yn="N"
        case "${yn:0:1}" in
            y|Y)
                nocomp='true'
                ;;
            n|N)
                nocomp='false'
                ;;
            *)
                _echo -e "输入有误，请重新输入!"
                continue
                ;;
        esac
        _echo -r "  nocomp = ${nocomp}"
		break
	done
}

is_enable_simulate_tcp_connection(){
    if [[ ${nocomp} = true ]]; then
        # 是否开启模拟TCP连接 TCP
        while true
        do
            _read "是否开启模拟TCP连接(tcp) (默认: n) [y/n]:"
            local yn="${inputInfo}"
            [ -z "${yn}" ] && yn="N"
            case "${yn:0:1}" in
                y|Y)
                    KP_TCP='true'
                    ;;
                n|N)
                    KP_TCP='false'
                    ;;
                *)
                    _echo -e "输入有误，请重新输入!"
                    continue
                    ;;
            esac
            _echo -r "  tcp = ${KP_TCP}"
            break
        done
    else
        KP_TCP='false'
    fi
}

install_prepare_libev_kcptun(){
    get_input_port
    firewallNeedOpenPort="${listen_port}"
    get_input_password
    get_input_crypt
    get_input_accelerate_mode
    get_input_mtu
    get_input_sndwnd
    get_input_rcvwnd
    get_input_datashard
    get_input_parityshard
    get_input_dscp
    is_disable_nocomp
    is_enable_simulate_tcp_connection
}