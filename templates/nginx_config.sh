nginx_config(){
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
	        listen 443 ssl;
	        listen [::]:443 ssl;
	        server_name ${domain};
	        ssl_certificate ${cerPath};
	        ssl_certificate_key ${keyPath};
	        ssl_ciphers HIGH:!aNULL:!MD5;
	        ssl_protocols TLSv1.2 TLSv1.3;
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