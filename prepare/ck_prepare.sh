install_prepare_libev_cloak(){
    echo -e "请为Cloak输入重定向ip:port [留空以将其设置为bing.com的204.79.197.200:443]"
    echo
    read -e -p "(默认: 204.79.197.200:443):" ckwebaddr
    [ -z "$ckwebaddr" ] && ckwebaddr="204.79.197.200:443"
    echo
    echo -e "${Red}  RedirAddr = ${ckwebaddr}${suffix}"
    echo 
    
    echo
    echo -e "请为Cloak输入重定向ip:port相对应的域名"
    echo
    read -e -p "(默认: www.bing.com):" domain
    [ -z "$domain" ] && domain="www.bing.com"
    echo
    echo -e "${Red}  ServerName = ${domain}${suffix}"
    echo
    
    echo
    echo -e "请为Cloak设置一个userinfo.db存放路径"
    read -e -p "(默认: $CK_DB_PATH)" ckdbp
    [ -z "$ckdbp" ] && ckdbp=$CK_DB_PATH
    if [ ! -e "${ckdbp}" ]; then
        mkdir -p "${ckdbp}"
    fi
    echo
    echo -e "${Red}  DatabasePath = ${ckdbp}${suffix}"
    echo
}