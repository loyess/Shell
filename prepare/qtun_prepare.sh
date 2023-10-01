improt_package "utils" "gen_certificates.sh"


install_prepare_libev_qtun(){
    improt_package "utils" "common_prepare.sh"
    get_input_inbound_port 443
    firewallNeedOpenPort="${INBOUND_PORT}"
    shadowsocksport="${firewallNeedOpenPort}"
    kill_process_if_port_occupy "${firewallNeedOpenPort}"
    get_specified_type_domain "DNS-Only"
    acme_get_certificate_by_force "${domain}" "RSA"
}