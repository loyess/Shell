caddy_v1_config(){
	cat > ${CADDY_CONF_FILE}<<-EOF
	${domain}:443 {
	    gzip
	    log /var/log/caddy-access.log
	    errors /var/log/caddy-error.log
	    tls ${cerPath} ${keyPath} {
	        protocols tls1.3
	    }
	    proxy ${path} localhost:${shadowsocksport} {
	        websocket
	        header_upstream -Origin
	    }
	    proxy / ${mirror_site} {
	        transparent
	        except ${path}
	    }
	}
	EOF
}

caddy_v2_config(){
	cat > ${CADDY_CONF_FILE}<<-EOF
	${domain}:443 {
	    encode gzip
	    log {
	        output file /var/log/caddy-access.log
	        format json
	    }
	    tls ${cerPath} ${keyPath} {
	        protocols tls1.3
	    }
	    reverse_proxy ${path} localhost:${shadowsocksport}
	    reverse_proxy ${mirror_site} {
	        header_up Host {http.reverse_proxy.upstream.hostport}
	        header_up X-Real-IP {http.request.remote}
	        header_up X-Forwarded-For {http.request.remote}
	        header_up X-Forwarded-Port {http.request.port}
	        header_up X-Forwarded-Proto {http.request.scheme}
	    }
	}
	EOF
}

caddy_config(){
    if [[ ${caddyVerFlag} = "1" ]]; then
        caddy_v1_config
    elif [[ ${caddyVerFlag} = "2" ]]; then
        caddy_v2_config
    fi
}