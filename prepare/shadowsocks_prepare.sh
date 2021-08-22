# ss development language version
SS_DLV=(
ss-libev
ss-rust
go-ss2
)

# shadowsocks-libev Ciphers
SHADOWSOCKS_LIBEV_CIPHERS=(
rc4-md5
salsa20
chacha20
chacha20-ietf
aes-256-cfb
aes-192-cfb
aes-128-cfb
aes-256-ctr
aes-192-ctr
aes-128-ctr
bf-cfb
camellia-128-cfb
camellia-192-cfb
camellia-256-cfb
aes-256-gcm
aes-192-gcm
aes-128-gcm
xchacha20-ietf-poly1305
chacha20-ietf-poly1305
)

SHADOWSOCKS_RUST_CIPHERS=(
none
aes-256-gcm
aes-128-gcm
chacha20-ietf-poly1305
)

GO_SHADOWSOCKS2_CIPHERS=(
AEAD_AES_128_GCM
AEAD_AES_256_GCM
AEAD_CHACHA20_POLY1305
)


select_ss_version_auto(){
    local totalRam=`free | awk '/Mem/ {print $2}'`
    local numLogicalCpu=`cat /proc/cpuinfo | grep "processor" | wc -l`

    if [ $totalRam -lt 1048576 ] && [ $numLogicalCpu -le 1 ]; then
        versionDefault=$(shuf -i 2-3 -n 1)
    else
        versionDefault=1
    fi
}

choose_ss_install_version(){
    select_ss_version_auto

    while true
    do
        echo
        echo -e "\n请选择Shadowsocks安装版本"
        echo
        for ((i=1;i<=${#SS_DLV[@]};i++ )); do
            hint="${SS_DLV[$i-1]}"
            echo -e "${Green}  ${i}.${suffix} ${hint}"
        done
        
        echo
        read -e -p "(默认: ${versionDefault}):" pick
        [ -z "$pick" ] && pick=${versionDefault}
        expr ${pick} + 1 &>/dev/null
        if [ $? -ne 0 ]; then
            echo
            echo -e "${Error} 请输入一个数字."
            echo
            continue
        fi
        if [[ "$pick" -lt 1 || "$pick" -gt ${#SS_DLV[@]} ]]; then
            echo
            echo -e "${Error} 请输入一个数字在 [1-${#SS_DLV[@]}] 之间."
            echo
            continue
        fi
        SS_VERSION=${SS_DLV[$pick-1]}

        echo
        echo -e "${Red}  ss = ${SS_VERSION}${suffix}"
        echo
        break
    done
}

install_prepare_port() {
    while true
    do
        gen_random_prot
        echo -e "\n请输入Shadowsocks端口 [1-65535]"
        read -e -p "(默认: ${ran_prot}):" shadowsocksport
        [ -z "${shadowsocksport}" ] && shadowsocksport=${ran_prot}
        expr ${shadowsocksport} + 1 &>/dev/null
        if [ $? -ne 0 ]; then
            echo
            echo -e "${Error} 请输入一个有效数字."
            echo
            continue
        fi
        if [ ${shadowsocksport:0:1} = 0 ]; then
            echo
            echo -e "${Error} 请输入一个非0开头的数字."
            echo
            continue
        fi
        if [ ${shadowsocksport} -lt 1 ] && [ ${shadowsocksport} -gt 65535 ]; then
            echo
            echo -e "${Error} 请输入一个在1-65535之间的数字."
            echo
            continue
        fi
        if check_port_occupy ${shadowsocksport}; then
            echo
            echo -e "${Error} 该端口已经被占用，请重新输入一个数字."
            echo
            continue
        fi
        echo
        echo -e "${Red}  port = ${shadowsocksport}${suffix}"
        echo 
        break
    done
}

install_prepare_password(){
    gen_random_str
    echo -e "\n请输入Shadowsocks密码"
    read -e -p "(默认: ${ran_str8}):" shadowsockspwd
    [ -z "${shadowsockspwd}" ] && shadowsockspwd=${ran_str8}
    echo
    echo -e "${Red}  password = ${shadowsockspwd}${suffix}"
    echo
}

install_prepare_cipher(){
    while true
    do
        echo -e "\n请选择Shadowsocks加密方式"

        if [[ ${SS_VERSION} = "ss-libev" ]]; then
            local tempNum=14
            local SHADOWSOCKS_CIPHERS=( ${SHADOWSOCKS_LIBEV_CIPHERS[@]} )
        elif [[ ${SS_VERSION} = "ss-rust" ]]; then
            local tempNum=2
            local SHADOWSOCKS_CIPHERS=( ${SHADOWSOCKS_RUST_CIPHERS[@]} )
        elif [[ ${SS_VERSION} = "go-ss2" ]]; then
            local tempNum=2
            local SHADOWSOCKS_CIPHERS=( ${GO_SHADOWSOCKS2_CIPHERS[@]} )
        fi

        for ((i=1;i<=${#SHADOWSOCKS_CIPHERS[@]};i++ )); do
            hint="${SHADOWSOCKS_CIPHERS[$i-1]}"
            if [[ ${i} -le 9 ]]; then
                echo -e "${Green}  ${i}.${suffix} ${hint}"
            else
                echo -e "${Green} ${i}.${suffix} ${hint}"
            fi
        done

        echo
        read -e -p "(默认: ${SHADOWSOCKS_CIPHERS[${tempNum}]}):" pick
        [ -z "$pick" ] && pick=$(expr ${tempNum} + 1)
        expr ${pick} + 1 &>/dev/null
        if [ $? -ne 0 ]; then
            echo
            echo -e "${Error} 请输入一个数字."
            echo
            continue
        fi
        if [[ "$pick" -lt 1 || "$pick" -gt ${#SHADOWSOCKS_CIPHERS[@]} ]]; then
            echo
            echo -e "${Error} 请输入一个数字在 [1-${#SHADOWSOCKS_CIPHERS[@]}] 之间."
            echo
            continue
        fi
        shadowsockscipher=${SHADOWSOCKS_CIPHERS[$pick-1]}

        echo
        echo -e "${Red}  cipher = ${shadowsockscipher}${suffix}"
        echo

        if [[ ${shadowsockscipher} == "AEAD_AES_128_GCM" ]]; then
            shadowsockscipher="aes-128-gcm"
        elif [[ ${shadowsockscipher} == "AEAD_AES_256_GCM" ]]; then
            shadowsockscipher="aes-256-gcm"
        elif [[ ${shadowsockscipher} == "AEAD_CHACHA20_POLY1305" ]]; then
            shadowsockscipher="chacha20-ietf-poly1305"
        fi
        break
    done
}