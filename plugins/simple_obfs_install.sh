install_simple_obfs(){
    cd ${CUR_DIR}
    git clone https://github.com/shadowsocks/simple-obfs.git
    [ -d simple-obfs ] && cd simple-obfs || echo -e "${Error} git clone simple-obfs 失败."
    git submodule update --init --recursive
    
    if centosversion 6; then
        if [ ! "$(command -v autoconf268)" ]; then
            echo -e "${Info} 开始安装 autoconf268."
            yum install -y autoconf268 > /dev/null 2>&1 || echo -e "${Error} autoconf268 安装失败."
        fi
        # replace command autoreconf to autoreconf268
        sed -i 's/autoreconf/autoreconf268/' autogen.sh
        # replace #include <ev.h> to #include <libev/ev.h>
        sed -i 's@^#include <ev.h>@#include <libev/ev.h>@' src/local.h
        sed -i 's@^#include <ev.h>@#include <libev/ev.h>@' src/server.h
    fi
    
    echo -e "${Info} 编译安装 simple-obfs-${simple_obfs_ver}."
    ./autogen.sh
    ./configure --disable-documentation
    make
    make install
    if [ ! "$(command -v obfs-server)" ]; then
        echo -e "${Error} simple-obfs-${simple_obfs_ver} 安装失败."
        install_cleanup
        exit 1
    fi
    [ -f /usr/local/bin/obfs-server ] && ln -fs /usr/local/bin/obfs-server /usr/bin
    echo -e "${Info} simple-obfs-${simple_obfs_ver} 安装成功."
}