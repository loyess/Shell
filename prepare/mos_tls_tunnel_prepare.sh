improt_package "utils" "gen_certificates.sh"

# mos-tls-tunnel Transport mode
MTT_TRANSPORT_MODE=(
tls
wss
)


tls_mode_logic(){
    do_you_have_domain
    if [ "${doYouHaveDomian}" = "No" ]; then
        firewallNeedOpenPort="${shadowsocksport}"
        get_all_type_domain
    elif [ "${doYouHaveDomian}" = "Yes" ]; then
        firewallNeedOpenPort=443
        shadowsocksport="${firewallNeedOpenPort}"
        kill_process_if_port_occupy "${firewallNeedOpenPort}"
        get_specified_type_domain "DNS-Only"
    fi
    is_disable_mux_logic
    if [ "${domainType}" = "DNS-Only" ]; then
        acme_get_certificate_by_force "${domain}"
    fi
}

wss_mode_logic(){
    do_you_have_domain
    if [ "${doYouHaveDomian}" = "No" ]; then
        firewallNeedOpenPort="${shadowsocksport}"
        get_all_type_domain
    elif [ "${doYouHaveDomian}" = "Yes" ]; then
        firewallNeedOpenPort=443
        shadowsocksport="${firewallNeedOpenPort}"
        kill_process_if_port_occupy "${firewallNeedOpenPort}"
        get_specified_type_domain "DNS-Only"
    fi
    get_input_ws_path
    is_disable_mux_logic
    if [ "${domainType}" = "DNS-Only" ]; then
        acme_get_certificate_by_force "${domain}"
    fi
}

install_prepare_libev_mos_tls_tunnel(){
    generate_menu_logic "${MTT_TRANSPORT_MODE[*]}" "传输模式" "1"
    libev_mtt="${inputInfo}"
    improt_package "utils" "common_prepare.sh"
    if [ "${libev_mtt}" = "1" ]; then
        tls_mode_logic
    elif [ "${libev_mtt}" = "2" ]; then
        wss_mode_logic
    fi
}