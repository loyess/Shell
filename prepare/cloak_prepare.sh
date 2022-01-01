# cloak encryption method
CLOAK_ENCRYPTION_METHOD=(
plain
aes-128-gcm
aes-256-gcm
chacha20-poly1305
)


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

get_input_rediraddr(){
    local tempArray=("${domain}" "${domain_ip}")

    generate_menu_logic "${tempArray[*]}" "重定向地址(RedirAddr):" "1"
    ckwebaddr="${optionValue}"
}

get_cloak_encryption_method(){
    generate_menu_logic "${CLOAK_ENCRYPTION_METHOD[*]}" "加密方式(EncryptionMethod):" "1"
    encryptionMethod="${optionValue}"
}

judge_str_only_contains_comma(){
    local domainStr=$1

    domainStr="$(echo $altNames | tr ',' ' ')"
    if judge_is_nul_str "${domainStr}"; then
        return 0
    else
        return 1
    fi
}

judge_is_separated_by_comma_domain(){
    local domainStr=$1
    local domainRe="(www\.)?[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+(:\d+)*(\/\w+\.\w+)*"

    domainStr="$(echo $altNames | sed -E 's/\ /,/g;s/,+/,/g;s/^,+//g;s/,+$//g' | tr ',' ' ')"
    domainStr="$(echo $domainStr | sed -E "s/${domainRe}//g")"
    if judge_is_nul_str "${domainStr}"; then
        return 0
    else
        return 1
    fi
}

get_input_alternativenames(){
    while true
    do
        _read "请输入AlternativeNames参数(例：cloudflare.com,github.com) (默认：跳过)："
        altNames="${inputInfo}"
        if judge_is_nul_str "${altNames}"; then
            NumConn=4
            AlternativeNames=""
            _echo -r "  AlternativeNames = 跳过"
            _echo -t "可自行在客户端设置，如自行设置请注意将NumConn设置为0."
            break
        fi
        if judge_str_only_contains_comma "${altNames}"; then
            _echo -e "检测到输入的字符${Red}仅存在逗号${suffix}，请重新输入."
            continue
        fi
        if judge_is_separated_by_comma_domain "${altNames}"; then
            _echo -e "检测到输入的字符中存在${Red}无效字符${suffix}，请重新输入."
            continue
        fi

        local domain
        local mark=0
        altNamesArray=(`echo $altNames | sed -E 's/\ /,/g;s/,+/,/g;s/^,+//g;s/,+$//g' | tr ',' ' '`)
        for domain in "${altNamesArray[@]}"; do
            if ! judge_is_valid_domain "${domain}"; then
                mark=$(("${mark}" + 1))
                if [ "$mark" -eq 1 ]; then
                    _echo -g "输入的无效字符如下："
                fi
                echo -e "  ${domain}"
            fi
        done
        if [ "$mark" -ne 0 ]; then
            _echo -e "检测到输入的字符中存在${Red}无法获取到ip的域名${suffix}，请重新输入."
            continue
        fi
        NumConn=0
        AlternativeNames=";AlternativeNames=$(echo $altNames | sed -E 's/\ /,/g;s/,+/,/g;s/^,+//g;s/,+$//g' | sed -E 's/,+/%2C/g')"
        _echo -r "  AlternativeNames = $(echo $altNames | sed -E 's/\ /,/g;s/,+/,/g;s/^,+//g;s/,+$//g')"
        break
    done
}

install_prepare_libev_cloak(){
    reset_if_ss_port_is_443
    firewallNeedOpenPort=443
    kill_process_if_port_occupy "${firewallNeedOpenPort}"
    get_input_domain
    get_input_rediraddr
    get_cloak_encryption_method
    get_input_alternativenames
}