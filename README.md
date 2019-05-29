## ss-plugins.sh

#### 下载安装:
``` bash
wget -N --no-check-certificate -c -t3 -T60 -O ss-plugins.sh https://git.io/fjlbl
chmod +x ss-plugins.sh
./ss-plugins.sh
```

&nbsp;

```shell
Usage: 
./ss-plugins.sh [install|uninstall|start|stop|restart|show|help]
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

2. ### 可选插件

~~~shell

请选择要安装的SS-Plugin

  1. v2ray
  2. kcptun
  3. simple-obfs
  4. goquiet (unofficial)
  5. cloak (based goquiet)


(默认: 不安装)：
~~~

&nbsp;

3. ### 安装完毕，终端配置展示如下，以 ss + kcptun 为例：

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

这里只对 linux-amd64 处理器架构做了支持，其它的就不要尝试了，推荐Ubuntu 18.04 LTS。

v2ray-plugin 所要用到的域名，可以从 [freenom.com](https://www.freenom.com) 获取免费域名， 申请需要挂代理，代理是哪国ip 就填写哪国的资料，不然会导致无法申请。 

另外，生成的 ss:// 链接，只能导入部分配置，剩下少部分需要手动复制粘贴。

&nbsp;

**相关下载：**

- [shadowsocks-windows](<https://github.com/shadowsocks/shadowsocks-windows/releases>) 
- [shadowsocks-android](<https://github.com/shadowsocks/shadowsocks-android/releases>)
- [v2ray-plugin](<https://github.com/shadowsocks/v2ray-plugin/releases>)
- [v2ray-plugin-android](<https://github.com/shadowsocks/v2ray-plugin-android/releases>)
- [kcptun](https://github.com/xtaci/kcptun/releases)
- [kcptun-android](https://github.com/shadowsocks/kcptun-android/releases)
- [simple-obfs(Deprecated)](https://github.com/shadowsocks/simple-obfs/releases)
- [simple-obfs-android](https://github.com/shadowsocks/simple-obfs-android/releases)
- [GoQuiet (unofficial)](https://github.com/cbeuw/GoQuiet/releases)
- [GoQuiet-android](https://github.com/cbeuw/GoQuiet-android/releases)
- [Cloak (based goquiet)](https://github.com/cbeuw/Cloak/releases)
- [Cloak-android](https://github.com/cbeuw/Cloak-android/releases)
