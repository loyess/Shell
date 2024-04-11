nginx_ws_config(){
	cat > /etc/nginx/nginx.conf<<-EOF
	user nginx;
	worker_processes auto;
	error_log /var/log/nginx-error.log info;
	pid /var/run/nginx.pid;

	events {
	    accept_mutex on;
	    multi_accept on;
	    worker_connections 1024;
	}

	http {
	    keepalive_timeout 60;
	    access_log /var/log/nginx-access.log combined;

	    server {
	        listen 80;
	        listen [::]:80;
	        server_name ${domain};
	        return 301 https://\$http_host\$request_uri;
	    }
	    
	    server{
	        listen ${firewallNeedOpenPort} ssl;
	        listen [::]:${firewallNeedOpenPort} ssl;
	        server_name ${domain};
	        ssl_certificate ${cerPath};
	        ssl_certificate_key ${keyPath};
	        ssl_protocols TLSv1.3;
	        ssl_session_cache shared:SSL:10m;
	        ssl_session_timeout  10m;
	        add_header Strict-Transport-Security "max-age=31536000";
	        
	        location ${path} {
	            proxy_redirect off;
	            proxy_http_version 1.1;
	            proxy_pass http://localhost:${shadowsocksport};
	            proxy_set_header Host \$http_host;
	            proxy_set_header Upgrade \$http_upgrade;
	            proxy_set_header Connection "upgrade";
	        }
	        
	        location / {
	            sub_filter ${mirror_domain} ${domain};
	            sub_filter_once off;
	            proxy_set_header X-Real-IP \$remote_addr;
	            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
	            proxy_set_header Referer ${mirror_site};
	            proxy_set_header Host ${mirror_domain};
	            proxy_pass ${mirror_site};
	            proxy_set_header Accept-Encoding "";
	        }
	    }
	}
	EOF
}

nginx_grpc_config(){
	cat > /etc/nginx/nginx.conf<<-EOF
	user nginx;
	worker_processes auto;
	error_log /var/log/nginx-error.log info;
	pid /var/run/nginx.pid;
	
	events {
	    accept_mutex on;
	    multi_accept on;
	    worker_connections 1024;
	}
	
	http {
	    keepalive_timeout 60;
	    access_log /var/log/nginx-access.log combined;
	
	    server {
	        listen 80;
	        listen [::]:80;
	        server_name ${domain};
	        return 301 https://\$http_host\$request_uri;
	    }
	
	    server{
	        listen ${firewallNeedOpenPort} ssl http2;
	        listen [::]:${firewallNeedOpenPort} ssl http2;
	        server_name ${domain};
	        ssl_certificate ${cerPath};
	        ssl_certificate_key ${keyPath};
	        ssl_protocols TLSv1.3;
	        ssl_session_cache shared:SSL:10m;
	        ssl_session_timeout  10m;
	        add_header Strict-Transport-Security "max-age=31536000";
	
	        location /${grpcSN}/Tun {
	            grpc_pass                    localhost:${shadowsocksport};
	            grpc_read_timeout            1h;
	            grpc_send_timeout            1h;
	            grpc_set_header X-Real-IP    \$remote_addr;
	            grpc_socket_keepalive        on;
	
	            client_body_buffer_size      1m;
	            client_body_timeout          1h;
	            client_max_body_size         0;
	        }
	
	        location / {
	            sub_filter ${mirror_domain} ${domain};
	            sub_filter_once off;
	            proxy_set_header X-Real-IP \$remote_addr;
	            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
	            proxy_set_header Referer ${mirror_site};
	            proxy_set_header Host ${mirror_domain};
	            proxy_pass ${mirror_site};
	            proxy_set_header Accept-Encoding "";
	        }
	    }
	}
	EOF
}

nginx_config(){
	if [[ -n ${grpcSN} ]]; then
		nginx_grpc_config
		return
	fi
	nginx_ws_config
}