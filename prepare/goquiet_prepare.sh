install_prepare_libev_goquiet(){
    gen_random_str
    shadowsocksport=443
    echo
    echo -e "请为GoQuiet输入重定向ip:port [留空以将其设置为bing.com的204.79.197.200:443]"
    read -e -p "(默认: 204.79.197.200:443):" gqwebaddr
    [ -z "$gqwebaddr" ] && gqwebaddr="204.79.197.200:443"
    echo
    echo -e "${Red}  WebServerAddr = ${gqwebaddr}${suffix}"
    echo
    echo -e "${Tip} server_port已被重置为：port = ${shadowsocksport}"
    echo 
    echo
    echo -e "请为GoQuiet输入重定向ip:port相对应的域名"
    echo
    read -e -p "(默认: www.bing.com):" domain
    [ -z "$domain" ] && domain="www.bing.com"
    echo
    echo -e "${Red}  ServerName = ${domain}${suffix}"
    echo
    echo
    echo -e "请为GoQuiet输入密钥 [留空以将其设置为16位随机字符串]"
    echo
    read -e -p "(默认: ${ran_str16}):" gqkey
    [ -z "$gqkey" ] && gqkey=${ran_str16}
    echo
    echo -e "${Red}  Key = ${gqkey}${suffix}"
    echo
}