gen_ss_goquiet_link(){
    clientIpOrDomain="$(get_ip)"
    clientPluginOpts="ServerName=${domain};Key=${gqkey};TicketTimeHint=3600;Browser=chrome"
    ss_plugins_client_links
}