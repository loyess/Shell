## ss-obfs-kcptun-v2ray.sh

#### 下载安装:
``` bash
wget -N --no-check-certificate -c -t3 -T60 -O ss-obfs-kcptun-v2ray.sh https://git.io/fjWs7
chmod +x ss-obfs-kcptun-v2ray.sh
./ss-obfs-kcptun-v2ray.sh
```

&nbsp;

1. ### ss 安装部分，密码、端口随机获取，也可自己指定，端口尽量避开常用端口，以免被占用。

```shell
Shadowsocks-libev一键管理脚本 [v1.0.0]

1. BBR
2. Install
3. Uninstall

 当前状态: 未安装

请输入Shadowsocks-libev端口 [1-65535]

  port = 16893

[注意] 如果选择v2ray-plugin 此参数将会被重置

请输入Shadowsocks-libev密码

  password = 6I0LRJLE

请选择Shadowsocks-libev加密方式

1. rc4-md5
2. salsa20
3. chacha20
4. chacha20-ietf
5. aes-256-cfb
6. aes-192-cfb
7. aes-128-cfb
8. aes-256-ctr
9. aes-192-ctr
10. aes-128-ctr
11. bf-cfb
12. camellia-128-cfb
13. camellia-192-cfb
14. camellia-256-cfb
15. aes-256-gcm
16. aes-192-gcm
17. aes-128-gcm
18. xchacha20-ietf-poly1305
19. chacha20-ietf-poly1305

  cipher = aes-256-gcm
```

&nbsp;

2. ### ss + v2ray-plugin 安装大概，大多参数默认就好， 另外，证书会经由 acme.sh 自动生成。

~~~shell

请选择要安装的SS-Plugin

1. v2ray
2. kcptun
3. simple-obfs

请为v2ray-plugin选择Transport mode

1. http
2. tls
3. quic

  over = tls

[注意] server_port已被重置为：port = 443

请输入你的域名 [ 注意：必须是已成功解析过本机ip地址的域名 ]：yourdomain.me

  host = yourdomain.me

是否自动生成证书相关文件? [Y/n]



[信息] 开始安装 acme.sh

```
·
略
·
```

[信息] acme.sh 安装完成.

[信息] 开始生成域名 yourdomain.me 相关的证书

```
·
略
·
```

[信息] yourdomain.me 证书生成完成.

按任意键开始…或按Ctrl+C取消
~~~

&nbsp;

3. ### ss + kcptun 安装大概，一路回车就好。

```shell
 
请选择要安装的SS-Plugin

1. v2ray
2. kcptun
3. simple-obfs

请输入 Kcptun 服务端运行端口 [1-65535]
[注意] 这个端口，就是 Kcptun 客户端要连接的端口.

  port = 29900

请输入需要加速的地址
[注意] 可以输入IPv4 地址或者 IPv6 地址.

  ip(target) = 127.0.0.1

请输入需要加速的端口 [1-65535]
[注意] 这里用来加速SS，那就输入前面填写过的SS的端口: 18426

  port(target) = 18426

请设置 Kcptun 密码(key)
[注意] 该参数必须两端一致，另外这里的密码是kcptun的密码，与Shadowsocks半毛钱关系都没有，别弄混淆了.

  key = 5HTag0ia

请选择加密方式(crypt)
[注意] 强加密对 CPU 要求较高，如果是在路由器上配置客户端，请尽量选择弱加密或者不加密。该参数必须两端一致

1. aes
2. aes-128
3. aes-192
4. salsa20
5. blowfish
6. twofish
7. cast5
8. 3des
9. tea
10. xtea
11. xor
12. sm4
13. none

  crypt = aes

请选择加速模式(mode)
[注意] 加速模式和发送窗口大小共同决定了流量的损耗大小. 未支持(手动模式 manual)”

1. fast3
2. fast2
3. fast
4. normal

  mode = fast2

请设置 UDP 数据包的 MTU (最大传输单元)值

  MTU = 1350

请设置发送窗口大小(sndwnd)
[注意] 发送窗口过大会浪费过多流量

  sndwnd = 1024

请设置接收窗口大小(rcvwnd)

  rcvwnd = 1024

请设置前向纠错(datashard)
[注意] 该参数必须两端一致

  datashard = 10

请设置前向纠错(parityshard)
[注意] 该参数必须两端一致

  parityshard = 3

设置差分服务代码点(DSCP)

  DSCP = 46

按任意键开始…或按Ctrl+C取消
```

&nbsp;

4. ### ss + simple-obfs 安装大概，参数默认，一路回车就好。

```shell

请选择要安装的SS-Plugin

1. v2ray
2. kcptun
3. simple-obfs

请为simple-obfs选择obfs

1. http
2. tls

  obfs = http

按任意键开始…或按Ctrl+C取消
```

&nbsp;

5. ### 安装完毕，终端配置展示如下，以 ss + kcptun 为例：

~~~shell
Congratulations, Shadowsocks-libev server install completed!
服务器地址            :  30.190.255.13
服务器端口            :  29900
      密码            :  vbS3NgbW
      加密            :  aes-256-gcm
  插件程序            :  kcptun
  插件选项            :
  插件参数            :  -l %SS_LOCAL_HOST%:%SS_LOCAL_PORT% -r %SS_REMOTE_HOST%:%SS_REMOTE_PORT% --crypt aes --key cKsFCxHy --mtu 1350 --sndwnd 1024 --rcvwnd 1024 --mode fast2 --datashard 10 --parityshard 3 --dscp 46

Mobile Terminal Params: crypt=aes;key=cKsFCxHy;mtu=1350;sndwnd=1024;rcvwnd=1024;mode=fast2;datashard=10;parityshard=3;dscp=46

```
       Kcptun配置路径：/etc/kcptun/config.json
```

Shadowsocks-libev配置路径：/etc/shadowsocks-libev/config.json

[注意] 插件程序下载：https://github.com/xtaci/kcptun/releases 下载kcptun-windows-amd64 版本
       请解压将带client字样的文件重命名为 kcptun.exe 并移至 SS-Windows 客户端-安装目录的根目录.

Your QR Code: (For Shadowsocks Windows, OSX, Android and iOS clients)
 ss://YWVzLTI1NinY206dmJ*********8uMTk2LjIyMy44MoOTkwMA==
Your QR Code has been saved as a PNG file path:
 /root/shadowsocks_libev_qr.png

Installed successfully.
Enjoy it!
~~~

&nbsp;

本脚本改自于各路大神，水平马马虎虎，方便自用。

另外，生成的 ss:// 链接，只能导入部分配置，剩下少部分需要手动复制粘贴。

&nbsp;

**相关下载：**

- [shadowsocks-windows](<https://github.com/shadowsocks/shadowsocks-android/releases>) 
- [shadowsocks-android](<https://github.com/shadowsocks/shadowsocks-android/releases>)
- [v2ray-plugin](<https://github.com/shadowsocks/v2ray-plugin/releases>)
- [v2ray-plugin-android](<https://github.com/shadowsocks/v2ray-plugin-android/releases>)
- [kcptun](https://github.com/xtaci/kcptun/releases)
- [kcptun-android](https://github.com/shadowsocks/kcptun-android/releases)
- [simple-obfs(Deprecated)](https://github.com/shadowsocks/simple-obfs/releases)
- [simple-obfs-android](https://github.com/shadowsocks/simple-obfs-android/releases)
