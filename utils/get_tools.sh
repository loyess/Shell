get_ip(){
    local IP=$( ip addr | egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | egrep -v "^192\.168|^172\.1[6-9]\.|^172\.2[0-9]\.|^172\.3[0-2]\.|^10\.|^127\.|^255\.|^0\." | head -n 1 )
    [ -z ${IP} ] && IP=$( wget -qO- -t1 -T2 ipv4.icanhazip.com )
    [ -z ${IP} ] && IP=$( wget -qO- -t1 -T2 ipinfo.io/ip )
    echo ${IP}
}

get_ipv6(){
    local ipv6=$(wget -qO- -t1 -T2 ipv6.icanhazip.com)
    [ -z ${ipv6} ] && return 1 || return 0
}

get_ver(){
    libev_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/shadowsocks/shadowsocks-libev/releases | grep -o '"tag_name": ".*"' | head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
    [ -z ${libev_ver} ] && echo -e "${Error} 获取 shadowsocks-libev 最新版本失败." && exit 1
    simple_obfs_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/shadowsocks/simple-obfs/releases | grep -o '"tag_name": ".*"' | head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
    [ -z ${simple_obfs_ver} ] && echo -e "${Error} 获取 simple-obfs 最新版本失败." && exit 1
    kcptun_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/xtaci/kcptun/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
    [ -z ${kcptun_ver} ] && echo -e "${Error} 获取 kcptun 最新版本失败." && exit 1
    v2ray_plugin_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/shadowsocks/v2ray-plugin/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
    [ -z ${v2ray_plugin_ver} ] && echo -e "${Error} 获取 v2ray-plugin 最新版本失败." && exit 1
    goquiet_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/cbeuw/GoQuiet/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
    [ -z ${goquiet_ver} ] && echo -e "${Error} 获取 goquiet 最新版本失败." && exit 1
    cloak_ver=$(wget --no-check-certificate -qO- https://api.github.com/repos/cbeuw/Cloak/releases | grep -o '"tag_name": ".*"' |head -n 1| sed 's/"//g;s/v//g' | sed 's/tag_name: //g')
    [ -z ${cloak_ver} ] && echo -e "${Error} 获取 cloak 最新版本失败." && exit 1
}

get_char(){
    SAVEDSTTY=$(stty -g)
    stty -echo
    stty cbreak
    dd if=/dev/tty bs=1 count=1 2> /dev/null
    stty -raw
    stty echo
    stty $SAVEDSTTY
}

get_str_base64_encode(){
    echo -n $1 | base64 -w0
}

get_str_replace(){
    echo -n $1 | sed 's/:/%3a/g;s/;/%3b/g;s/=/%3d/g;s/\//%2f/g'
}

gen_random_prot(){
    ran_prot=$(shuf -i 9000-19999 -n 1)
}

gen_random_str(){
    ran_str8=$(head -c 100 /dev/urandom | tr -dc a-z0-9A-Z |head -c 12)
    ran_str16=$(head -c 100 /dev/urandom | tr -dc a-z0-9A-Z |head -c 16)
}

gen_credentials(){
    while true
    do
        ckauid=$(ck-server -u)
        IFS=, read ckpub ckpv <<< $(ck-server -k)
        
        # filter "+" from ckauid and ckpub
        if [[ $(echo ${ckauid} | grep "+") || $(echo ${ckpub} | grep "+") ]]; then
            continue
        fi
        break
    done
}