get_input_domain(){
    while true
    do
        _read "请输入重定向域名 (默认: cloudfront.com):"
        domain="${inputInfo}"
        [ -z "$domain" ] && domain="cloudfront.com"
        if ! judge_is_domain "${domain}"; then
            _echo -e "请输入一个格式正确的域名."
            continue
        fi
        if ! judge_is_valid_domain "${domain}"; then
            _echo -e "无法解析到IP，请输入一个正确有效的域名."
            continue
        fi
        _echo -r "  ServerName = ${domain}"
        break
    done
}

get_input_webaddr(){
    while true
    do
        _read "请输入与重定向域名对应的IP (默认: ${domain_ip}:443):"
        gqwebaddr="${inputInfo}"
        [ -z "$gqwebaddr" ] && gqwebaddr="${domain_ip}:443"
        if ! judge_is_ip_colon_port_format "${gqwebaddr}"; then
            _echo -e "请输入正确合法的IP:443组合."
            continue
        fi
        _echo -r "  WebServerAddr = ${gqwebaddr}"
        break
    done
}

get_input_gqkey(){
    gen_random_str
    _read "请输入密钥 (默认: ${ran_str12}):"
    gqkey="${inputInfo}"
    [ -z "$gqkey" ] && gqkey=${ran_str12}
    _echo -r "  Key = ${gqkey}"
}

install_prepare_libev_goquiet(){
    improt_package "utils" "common_prepare.sh"
    get_input_inbound_port 443
    firewallNeedOpenPort="${INBOUND_PORT}"
    shadowsocksport="${firewallNeedOpenPort}"
    kill_process_if_port_occupy "${firewallNeedOpenPort}"
    get_input_domain
    get_input_webaddr
    get_input_gqkey
}

