install_prepare_libev_cloak(){
    read -e -p "是否安装cloak最新版本？(默认: 否 安装v1.1.2版本)[y/n]:" ck_install_ver
    [ -z "${ck_install_ver}" ] && ck_install_ver="N"
    case "${ck_install_ver:0:1}" in
        y|Y)
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
            ;;
        n|N)
            # reset port for ss
            shadowsocksport=443
            
            echo -e "请为Cloak输入重定向ip:port [留空以将其设置为bing.com的204.79.197.200:443]"
            echo
            read -e -p "(默认: 204.79.197.200:443):" ckwebaddr
            [ -z "$ckwebaddr" ] && ckwebaddr="204.79.197.200:443"
            echo
            echo -e "${Red}  WebServerAddr = ${ckwebaddr}${suffix}"
            echo
            echo -e "${Tip} server_port已被重置为：port = ${shadowsocksport}"
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
                mkdir -p "${ckdbp}/db-backup"
            fi
            echo
            echo -e "${Red}  DatabasePath = ${ckdbp}${suffix}"
            echo
            ;;
        *)
            echo
            echo -e "${Error} 输入有误，请重新输入!"
            echo
            continue
            ;;
    esac
    
}