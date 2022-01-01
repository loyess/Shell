check_sys_and_add_source(){
    local PKG_FLAG=$1
    local version="$(get_version)"
    
    if check_sys sysRelease centos; then
        # 安装依赖
        sudo yum install -y yum-utils
        
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
            sudo yum-config-manager --disable nginx-mainline
            sudo yum install -y nginx
        elif [[ ${PKG_FLAG} = "2" ]]; then
            # 安装nginx 主线版
            sudo yum-config-manager --enable nginx-mainline
            sudo yum install -y nginx
        fi
        
        if [ $? -eq 0 ]; then
            echo -e "${Info} nginx安装成功."
        fi
       
    elif check_sys sysRelease debian; then
        # 安装依赖
        sudo apt install -y curl gnupg2 ca-certificates lsb-release
        
        if [[ ${PKG_FLAG} = "1" ]]; then
            # 添加 Nginx稳定版 源 
            echo "deb http://nginx.org/packages/debian `lsb_release -cs` nginx" | sudo tee /etc/apt/sources.list.d/nginx.list
        elif [[ ${PKG_FLAG} = "2" ]]; then
            # 添加 Nginx主线版 源 
            echo "deb http://nginx.org/packages/mainline/debian `lsb_release -cs` nginx" | sudo tee /etc/apt/sources.list.d/nginx.list
        fi
        
        # 导入官方的nginx签名密钥
        curl -fsSL https://nginx.org/keys/nginx_signing.key | sudo apt-key add -
        
        # 验证key是否正确
        # 打印如下：
        # pub   rsa2048 2011-08-19 [SC] [expires: 2024-06-14]
        #       573B FD6B 3D8F BC64 1079  A6AB ABF5 BD82 7BD9 BF62
        # uid   [ unknown] nginx signing key <signing-key@nginx.com>
        sudo apt-key fingerprint ABF5BD827BD9BF62
        
        # 安装nginx
        sudo apt update
        sudo apt install -y nginx
        
        if [ $? -eq 0 ]; then
            echo -e "${Info} nginx安装成功."
        fi
        
    elif check_sys sysRelease ubuntu && version_ge ${version} 16.04; then
        # 安装依赖
        sudo apt install -y curl gnupg2 ca-certificates lsb-release
        
        if [[ ${PKG_FLAG} = "1" ]]; then
            # 添加 Nginx稳定版 源 
            echo "deb http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" | sudo tee /etc/apt/sources.list.d/nginx.list
        elif [[ ${PKG_FLAG} = "2" ]]; then
            # 添加 Nginx主线版 源 
            echo "deb http://nginx.org/packages/mainline/ubuntu `lsb_release -cs` nginx" | sudo tee /etc/apt/sources.list.d/nginx.list
        fi
        
        # 导入官方的nginx签名密钥
        curl -fsSL https://nginx.org/keys/nginx_signing.key | sudo apt-key add -
        
        # 验证key是否正确
        # 打印如下：
        # pub   rsa2048 2011-08-19 [SC] [expires: 2024-06-14]
        #       573B FD6B 3D8F BC64 1079  A6AB ABF5 BD82 7BD9 BF62
        # uid   [ unknown] nginx signing key <signing-key@nginx.com>
        sudo apt-key fingerprint ABF5BD827BD9BF62
        
        # 安装nginx
        sudo apt update
        sudo apt install -y nginx
        
        if [ $? -eq 0 ]; then
            echo -e "${Info} nginx安装成功."
        fi
    fi
}

install_nginx(){
    check_sys_and_add_source ${pkg_flag}
}