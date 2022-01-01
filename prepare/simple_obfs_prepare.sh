# Simple-obfs Obfuscation wrapper
OBFUSCATION_WRAPPER=(
http
tls
)


get_input_obfs_mode(){
    generate_menu_logic "${OBFUSCATION_WRAPPER[*]}" "混淆模式" "1"
    shadowsocklibev_obfs="${optionValue}"
}

get_input_obfs_domain(){
    while true
        do
        _read "请为simple-obfs输入用于混淆的域名 (默认: cloudfront.com):"
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
        _echo -r "  obfs-host = ${domain}"
        break
    done
}

install_prepare_libev_obfs(){
    get_input_obfs_mode
    get_input_obfs_domain
    firewallNeedOpenPort="${shadowsocksport}"
}

