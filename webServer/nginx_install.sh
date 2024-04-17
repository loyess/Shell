check_sys_and_add_source(){
    local PKG_FLAG=$1
    local version="$(get_version)"
    
    if check_sys sysRelease centos; then
        # 安装依赖
        yum install -y yum-utils
        
        # 添加 Nginx 源
        touch /etc/yum.repos.d/nginx.repo
		cat > /etc/yum.repos.d/nginx.repo<<-EOF
		[nginx-stable]
		name=nginx stable repo
		baseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/
		gpgcheck=1
		enabled=1
		gpgkey=https://nginx.org/keys/nginx_signing.key
		module_hotfixes=true

		[nginx-mainline]
		name=nginx mainline repo
		baseurl=http://nginx.org/packages/mainline/centos/\$releasever/\$basearch/
		gpgcheck=1
		enabled=0
		gpgkey=https://nginx.org/keys/nginx_signing.key
		module_hotfixes=true
		EOF
        
        if [[ ${PKG_FLAG} = "1" ]]; then
            # 安装nginx 稳定版
            yum-config-manager --disable nginx-mainline
            yum install -y nginx
        elif [[ ${PKG_FLAG} = "2" ]]; then
            # 安装nginx 主线版
            yum-config-manager --enable nginx-mainline
            yum install -y nginx
        fi
        
        if [ $? -eq 0 ]; then
            _echo -i "nginx安装成功."
        fi
       
    elif check_sys sysRelease debian && version_ge ${version} 11; then
        # 安装依赖
        apt install curl gnupg2 ca-certificates lsb-release debian-archive-keyring

        local SIGNING_KEY="/etc/apt/trusted.gpg"; if [[ -e "${SIGNING_KEY}" ]]; then rm -f "${SIGNING_KEY}"; fi
        local NGINX_LIST="/etc/apt/sources.list.d/nginx.list"; if [[ -e "${NGINX_LIST}" ]]; then rm -f "${NGINX_LIST}"; fi
        
        if [[ ${PKG_FLAG} = "1" ]]; then
            # 添加 Nginx稳定版 源 
            echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
            http://nginx.org/packages/debian `lsb_release -cs` nginx" \
                | tee /etc/apt/sources.list.d/nginx.list
        elif [[ ${PKG_FLAG} = "2" ]]; then
            # 添加 Nginx主线版 源 
            echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
            http://nginx.org/packages/mainline/debian `lsb_release -cs` nginx" \
                | tee /etc/apt/sources.list.d/nginx.list
        fi
        
        # 导入官方的nginx签名密钥
        curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
            | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
        
        # 验证key是否正确
        # 打印如下：
        # pub   rsa2048 2011-08-19 [SC] [expires: 2024-06-14]
        #       573B FD6B 3D8F BC64 1079  A6AB ABF5 BD82 7BD9 BF62
        # uid   [ unknown] nginx signing key <signing-key@nginx.com>
        gpg --dry-run --quiet --no-keyring --import --import-options import-show /usr/share/keyrings/nginx-archive-keyring.gpg

        # 设置存储库固定以优先选择我们的包而不是发行版提供的包：
        if [[ ! -e "/etc/apt/preferences.d/99nginx" ]]; then
            echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" \
                | tee /etc/apt/preferences.d/99nginx
        fi
        
        # 安装nginx
        apt update
        apt install -y nginx
        
        if [ $? -eq 0 ]; then
            _echo -i "nginx安装成功."
        fi
        
    elif check_sys sysRelease ubuntu && version_ge ${version} 20.04; then
        # 安装依赖
        apt install curl gnupg2 ca-certificates lsb-release ubuntu-keyring

        local SIGNING_KEY="/etc/apt/trusted.gpg"; if [[ -e "${SIGNING_KEY}" ]]; then rm -f "${SIGNING_KEY}"; fi
        local NGINX_LIST="/etc/apt/sources.list.d/nginx.list"; if [[ -e "${NGINX_LIST}" ]]; then rm -f "${NGINX_LIST}"; fi
        
        if [[ ${PKG_FLAG} = "1" ]]; then
            # 添加 Nginx稳定版 源 
            echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
            http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" \
                | tee /etc/apt/sources.list.d/nginx.list
        elif [[ ${PKG_FLAG} = "2" ]]; then
            # 添加 Nginx主线版 源 
            echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
            http://nginx.org/packages/mainline/ubuntu `lsb_release -cs` nginx" \
                | tee /etc/apt/sources.list.d/nginx.list
        fi
        
        # 导入官方的nginx签名密钥
        curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
            | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
        
        # 验证key是否正确
        # 打印如下：
        # pub   rsa2048 2011-08-19 [SC] [expires: 2024-06-14]
        #       573B FD6B 3D8F BC64 1079  A6AB ABF5 BD82 7BD9 BF62
        # uid   [ unknown] nginx signing key <signing-key@nginx.com>
        gpg --dry-run --quiet --no-keyring --import --import-options import-show /usr/share/keyrings/nginx-archive-keyring.gpg

        # 设置存储库固定以优先选择我们的包而不是发行版提供的包：
        if [[ ! -e "/etc/apt/preferences.d/99nginx" ]]; then
            echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" \
                | tee /etc/apt/preferences.d/99nginx
        fi
        
        # 安装nginx
        apt update
        apt install -y nginx
        
        if [ $? -eq 0 ]; then
            _echo -i "nginx安装成功."
        fi
    fi
}

install_nginx(){
    check_sys_and_add_source ${pkg_flag}
}