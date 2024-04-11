caddy_v1_ws_config(){
	cat > ${CADDY_CONF_FILE}<<-EOF
	${domain}:${firewallNeedOpenPort} {
	    gzip
	    log /var/log/caddy-access.log
	    errors /var/log/caddy-error.log
	    tls ${cerPath} ${keyPath} {
	        protocols tls1.3
	    }
	    proxy ${path} localhost:${shadowsocksport} {
	        websocket
	        header_upstream -Origin
	        header_upstream Host {host}
	    }
	    proxy / ${mirror_site} {
	        transparent
	        except ${path}
	    }
	}
	EOF
}

caddy_v1_grpc_config(){
	cat > ${CADDY_CONF_FILE}<<-EOF
	${domain}:${firewallNeedOpenPort} {
	    gzip
	    log /var/log/caddy-access.log
	    errors /var/log/caddy-error.log
	    tls ${cerPath} ${keyPath} {
	        protocols tls1.3
	    }
	    grpc localhost:${shadowsocksport} {
	        backend_is_insecure
	    }
	    proxy / ${mirror_site} {
	        transparent
	        except /${grpcSN}/Tun
	    }
	}
	EOF
}

caddy_v2_ws_config(){
	cat > ${CADDY_CONF_FILE}<<-EOF
	${domain}:${firewallNeedOpenPort} {
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

caddy_v2_grpc_config(){
	cat > ${CADDY_CONF_FILE}<<-EOF
	${domain}:${firewallNeedOpenPort} {
	    encode gzip
	    log {
	        output file /var/log/caddy-access.log
	        format json
	    }
	    tls ${cerPath} ${keyPath} {
	        protocols tls1.3
	    }
	    @grpc {
	        protocol grpc
	        path /${grpcSN}/Tun
	    }
	    reverse_proxy @grpc localhost:${shadowsocksport} {
	        flush_interval -1
	        transport http {
	            versions h2c
	        }
	    }
	    @not-assets {
	        not path /${grpcSN}/Tun
	    }
	    reverse_proxy @not-assets ${mirror_site} {
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
        if [[ -n ${grpcSN} ]]; then
            caddy_v1_grpc_config
            return
        fi
        caddy_v1_ws_config
    elif [[ ${caddyVerFlag} = "2" ]]; then
        if [[ -n ${grpcSN} ]]; then
            caddy_v2_grpc_config
            return
        fi
        caddy_v2_ws_config
    fi
}