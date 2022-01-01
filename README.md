## ss-plugins.sh (注意：如果运行脚本出现意外报错，请执行 ./ss-plugins.sh script 升级脚本。)

#### 下载安装:
``` bash
wget -N --no-check-certificate -c -t3 -T60 -O ss-plugins.sh https://git.io/fjlbl
chmod +x ss-plugins.sh
./ss-plugins.sh
```

&nbsp;

```shell
Usage:
  ./ss-plugins.sh [options...] [args...]
    
Available Options:
  install          安装
  uninstall        卸载
  update           升级
  start            启动
  stop             关闭
  restart          重启
  status           查看状态
  script           升级脚本
  show             可视化配置
  log              查看日志文件
  catcfg           查看原始配置文件
  uid              添加一个新的uid用户(Cloak)
  cert             为.cf .ga .gq .ml .tk申请证书(90天)
  link             用新添加的uid生成一个新的SS://链接(Cloak)
  scan             用ss://链接在当前终端上生成一个可供扫描的二维码
  help             打印帮助信息并退出
```

&nbsp;

```shell
相关目录：

  SS-libev安装目录：/usr/local/bin
  SS-libev启动文件：/etc/init.d/shadowsocks-libev
  SS-libev配置文件：/etc/shadowsocks/config.json
    
  SS-rust安装目录：/usr/local/bin
  SS-rust启动文件：/etc/init.d/shadowsocks-rust
  SS-rust配置文件：/etc/shadowsocks/config.json
    
  Go-ss2安装目录：/usr/local/bin
  Go-ss2启动文件：/etc/init.d/go-shadowsocks2
  Go-ss2配置文件：/etc/shadowsocks/config.json

  kcptun安装目录：/usr/local/kcptun
  kcptun启动文件：/etc/init.d/kcptun
  kcptun配置文件：/etc/kcptun/config.json
    
  cloak安装目录：/usr/local/bin
  cloak启动文件：/etc/init.d/cloak
  cloak配置文件：/etc/cloak/ckserver.json

  rabbit-tcp安装目录：/usr/local/bin
  rabbit-tcp启动文件：/etc/init.d/rabbit-tcp
  rabbit-tcp配置文件：/etc/rabbit-tcp/config.json

  caddy安装目录：/usr/local/caddy
  caddy配置文件: /usr/local/caddy/Caddyfile

  nginx二进制文件：/usr/sbin/nginx
  nginx配置文件：/etc/nginx/nginx.conf

  SS-libev日志文件：/var/log/shadowsocks-libev.log
  SS-rust日志文件：/var/log/shadowsocks-rust.log
  Go-ss2日志文件：/var/log/go-shadowsocks2.log
  kcptun日志文件：/var/log/kcptun.log
  cloak日志文件：/var/log/cloak.log
  rabbit-tcp日志文件：/var/log/rabbit-tcp.log
  caddy错误日志文件：/var/log/caddy-error.log
  caddy访问日志文件：/var/log/caddy-access.log
  nginx错误日志文件：/var/log/nginx-error.log
  nginx访问日志文件：/var/log/nginx-access.log

  acme.sh安装目录：~/.acme.sh
  acme.sh生成证书目录：~/.acme.sh/xxx.xxx(域名)/

  cloudflare API存储路径：/root/.cloudflare/apiInfo
  其它插件可执行二进制文件目录：/usr/local/bin
```

&nbsp;

1. ### 主菜单

```shell
 Shadowsocks-libev一键管理脚本 [v1.0.0]

  1. BBR
  2. Install
  3. Uninstall

 当前状态: 已安装 并 已启动

请输入数字 [1-3]：
```

&nbsp;

2. ### 可选插件与插件可选项

~~~shell
  1. v2ray-plugin
      1. ws
      2. wss
      3. quic
      4. grpc
  2. kcptun
  3. simple-obfs
      1. http
      2. tls
  4. goquiet
  5. cloak
  6. mos-tls-tunnel
      1. tls
      2. wss
  7. rabbit-tcp
  8. simple-tls
      1. v0.3.4
      2. v0.4.7
      3. latest
  9. gost-plugin
      1. ws
      2. wss
      3. tls
      4. xtls
      5. quic
      6. http2
      7. grpc
 10. xray-plugin
      1. ws
      2. wss
      3. quic
      4. grpc
 11. qtun
 12. gun
      1. grpc-with-tls
      2. grpc-without-tls

注意：
    使用CDN时，请将 CloudFlare “SSL/TLS”-“概述”选项卡中，改为 “完全” 或 “完全 (严格)” 模式（前者不验证服务器证书，后者则会），否则，在浏览器打开你的域名会提示 ”重定向的次数过多“ 的错误。另外，使用CDN + gRPC时，请在 CloudFlare “网络”选项卡中，打开 gRPC。
~~~

&nbsp;

3. ### 简略安装步骤-动图预览，以 ss + v2ray-plugin 为例：

![01-v2ray-plugin](./example.gif)

&nbsp;

4. ### 安装完毕，终端配置展示如下，以 ss + kcptun 为例：

~~~shell
 Shadowsocks的配置信息：

 地址     : 66.66.66.66
 端口     : 6666
 密码     : bc1xQkj3
 加密     : aes-256-gcm
 插件程序 : kcptun
 插件选项 :
 插件参数 : -l %SS_LOCAL_HOST%:%SS_LOCAL_PORT% -r %SS_REMOTE_HOST%:%SS_REMOTE_PORT% --crypt aes --key 0EP4edcP --mtu 1350 --sndwnd 1024 --rcvwnd 1024 --mode fast2 --datashard 10 --parityshard 3 --dscp 46 --nocomp true

 手机参数 : crypt=aes;key=0EP4edcP;mtu=1350;sndwnd=1024;rcvwnd=1024;mode=fast2;datashard=10;parityshard=3;dscp=46;nocomp=true

 SS二维码 : ./ss-plugins.sh scan < ss://links >
 SS  链接 : ss://YWVzLTI1Ni1nY206YmMxeFFrajM=@66.66.66.66:6666/?plugin=kcptun%3bcrypt%3daes%3bkey%3d0EP4edcP%3bmtu%3d1350%3bsndwnd%3d1024%3brcvwnd%3d1024%3bmode%3dfast2%3bdatashard%3d10%3bparityshard%3d3%3bdscp%3d46%3bnocomp%3dtrue
~~~

&nbsp;

![Stargazers over time](https://starchart.cc/loyess/Shell.svg)

&nbsp;

本脚本改自于各路大神，水平马马虎虎，方便自用。

支持 linux-amd64，部分支持 linux-arm64 (aarch64)，其它的就不要尝试了，支持 CentOS6+ | Ubuntu16.04+ | Debian9+ ，其它更低版本是否支持，请自行尝试。推荐使用最新版。

~~v2ray-plugin 所要用到的域名，可以从 [freenom.com](https://www.freenom.com) 获取免费域名， 申请需要挂代理，代理是哪国ip 就填写哪国的资料，不然会导致无法申请。~~ (似乎失效了，有账号的仍能注册)

另外，生成的 ss:// 链接，不支持插件参数导入，需要手动复制粘贴，使用 kcptun 插件时，该链接仅支持在手机上导入。

&nbsp;

**相关下载：**

- [shadowsocks-libev](https://github.com/shadowsocks/shadowsocks-libev)
- [shadowsocks-rust](https://github.com/shadowsocks/shadowsocks-rust)
- [go-shadowsocks2](https://github.com/shadowsocks/go-shadowsocks2)
- [shadowsocks-windows](<https://github.com/shadowsocks/shadowsocks-windows>)
- [shadowsocks-android](<https://github.com/shadowsocks/shadowsocks-android>)
- [v2ray-plugin](<https://github.com/shadowsocks/v2ray-plugin>)
- [v2ray-plugin (teddysun)](<https://github.com/teddysun/v2ray-plugin>)
- [v2ray-plugin-android](<https://github.com/shadowsocks/v2ray-plugin-android>)
- [v2ray-plugin-android (teddysun)](<https://github.com/teddysun/v2ray-plugin-android>)
- [kcptun](https://github.com/xtaci/kcptun)
- [kcptun-android](https://github.com/shadowsocks/kcptun-android)
- [simple-obfs](https://github.com/shadowsocks/simple-obfs)
- [simple-obfs-android](https://github.com/shadowsocks/simple-obfs-android)
- [GoQuiet](https://github.com/cbeuw/GoQuiet)
- [GoQuiet-android](https://github.com/cbeuw/GoQuiet-android)
- [GoQuiet-android (Support Android10)](https://github.com/notsure2/GoQuiet-android)
- [Cloak](https://github.com/cbeuw/Cloak)
- [Cloak-android](https://github.com/cbeuw/Cloak-android)
- [mos-tls-tunnel](https://github.com/IrineSistiana/mos-tls-tunnel)
- [mostunnel-android](https://github.com/IrineSistiana/mostunnel-android)
- [rabbit-tcp](https://github.com/ihciah/rabbit-tcp)
- [rabbit-plugin](https://github.com/ihciah/rabbit-plugin)
- [simple-tls](https://github.com/IrineSistiana/simple-tls)
- [simple-tls-android](https://github.com/IrineSistiana/simple-tls-android)
- [gost-plugin](https://github.com/maskedeken/gost-plugin)
- [gost-plugin-android](https://github.com/maskedeken/gost-plugin-android)
- [xray-plugin](https://github.com/teddysun/xray-plugin)
- [xray-plugin-android](https://github.com/teddysun/xray-plugin-android)
- [qtun](https://github.com/shadowsocks/qtun)
- [gun](https://github.com/Qv2ray/gun)
