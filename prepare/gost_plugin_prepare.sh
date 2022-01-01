improt_package "utils" "gen_certificates.sh"


GOST_PLUGIN_TRANSPORT_MODE=(
ws
wss
tls
xtls
quic
http2
grpc
)


ws_mode_logic(){
    get_input_ws_path
    is_disable_mux_logic
    if [ "${isDisableMux}" == "enable" ]; then
        mode=mws
    else
        mode=ws
    fi
    improt_package "webServer" "prepare.sh"
    is_enable_web_server
    if [ "${isEnableWeb}" = "disable" ]; then
        domain="cloudfront.com"
        firewallNeedOpenPort="${shadowsocksport}"
    elif [ "${isEnableWeb}" = "enable" ]; then
        reset_if_ss_port_is_443
        firewallNeedOpenPort=443
        kill_process_if_port_occupy "${firewallNeedOpenPort}"
        get_cdn_or_dnsonly_type_domain
        web_server_menu
    fi
    if [ "${web_flag}" = "1" ]; then
        choose_caddy_version_menu
    elif [ "${web_flag}" = "2" ]; then
        choose_nginx_version_menu
    fi
    if [ "${domainType}" = "DNS-Only" ] && [ "${isEnableWeb}" = "enable" ]; then
        get_input_mirror_site
        acme_get_certificate_by_force "${domain}"
    elif [ "${domainType}" = "CDN" ] && [ "${isEnableWeb}" = "enable" ]; then
        get_input_mirror_site
        acme_get_certificate_by_api_or_manual "${domain}"
    fi
}

wss_mode_logic(){
    firewallNeedOpenPort=443
    shadowsocksport="${firewallNeedOpenPort}"
    kill_process_if_port_occupy "${firewallNeedOpenPort}"
    get_cdn_or_dnsonly_type_domain
    get_input_ws_path
    is_disable_mux_logic
    if [ "${isDisableMux}" == "enable" ]; then
        mode=mwss
    else
        mode=wss
    fi
    if [ "${domainType}" = "DNS-Only" ]; then
        acme_get_certificate_by_force "${domain}"
    elif [ "${domainType}" = "CDN" ]; then
        acme_get_certificate_by_api_or_manual "${domain}"
    fi
}

tls_mode_logic(){
    firewallNeedOpenPort=443
    shadowsocksport="${firewallNeedOpenPort}"
    kill_process_if_port_occupy "${firewallNeedOpenPort}"
    get_specified_type_domain "DNS-Only"
    is_disable_mux_logic
    if [ "${isDisableMux}" == "enable" ]; then
        mode=mtls
    else
        mode=tls
    fi
    acme_get_certificate_by_force "${domain}"
}

xtls_mode_logic(){
    if [ "${SS_VERSION}" != "ss-rust" ]; then
        SS_VERSION="ss-rust"
        shadowsockscipher="none"
        _echo -u "${Tip} 仅当shadowsocks密码设置为NONE时，XTLS模式才有效。"
        _echo -d "       Shadowsocks版本和加密方式已被更改为${Green}${SS_VERSION}${suffix} 和 ${Green}${shadowsockscipher}${suffix}"
    fi
    mode=xtls
    firewallNeedOpenPort=443
    shadowsocksport="${firewallNeedOpenPort}"
    kill_process_if_port_occupy "${firewallNeedOpenPort}"
    get_specified_type_domain "DNS-Only"
    acme_get_certificate_by_force "${domain}"
}

quic_mode_logic(){
    mode=quic
    firewallNeedOpenPort=443
    shadowsocksport="${firewallNeedOpenPort}"
    kill_process_if_port_occupy "${firewallNeedOpenPort}"
    get_specified_type_domain "DNS-Only"
    acme_get_certificate_by_force "${domain}"
}

http2_mode_logic(){
    mode=h2
    firewallNeedOpenPort=443
    shadowsocksport="${firewallNeedOpenPort}"
    kill_process_if_port_occupy "${firewallNeedOpenPort}"
    get_specified_type_domain "DNS-Only"
    acme_get_certificate_by_force "${domain}"
}

grpc_mode_logic(){
    mode=grpc
    firewallNeedOpenPort=443
    shadowsocksport="${firewallNeedOpenPort}"
    kill_process_if_port_occupy "${firewallNeedOpenPort}"
    get_cdn_or_dnsonly_type_domain
    if [ "${domainType}" = "DNS-Only" ]; then
        acme_get_certificate_by_force "${domain}"
    elif [ "${domainType}" = "CDN" ]; then
        acme_get_certificate_by_api_or_manual "${domain}"
    fi
}

install_prepare_libev_gost_plugin(){
    generate_menu_logic "${GOST_PLUGIN_TRANSPORT_MODE[*]}" "传输模式" "1"
    libev_gost_plugin="${inputInfo}"
    improt_package "utils" "common_prepare.sh"
    if [ "${libev_gost_plugin}" = "1" ]; then
        ws_mode_logic
    elif [ "${libev_gost_plugin}" = "2" ]; then
        wss_mode_logic
    elif [ "${libev_gost_plugin}" = "3" ]; then
        tls_mode_logic
    elif [ "${libev_gost_plugin}" = "4" ]; then
        xtls_mode_logic
    elif [ "${libev_gost_plugin}" = "5" ]; then
        quic_mode_logic
    elif [ "${libev_gost_plugin}" = "6" ]; then
        http2_mode_logic
    elif [ "${libev_gost_plugin}" = "7" ]; then
        grpc_mode_logic
    fi
}