# shell version
# ====================
SHELL_VERSION="2.0.0"
# ====================


# current path
CUR_DIR=$( pwd )


# bbr
BBR_SCRIPT_URL="https://git.io/vbUk0"
BBR_SHELL_FILE="$CUR_DIR/bbr.sh"


# Humanization config PATH
HUMAN_CONFIG="/etc/shadowsocks-libev/human-config"


# shadowsocklibev-libev config and init
SHADOWSOCKS_LIBEV_INSTALL_PATH="/usr/local/bin"
SHADOWSOCKS_LIBEV_INIT="/etc/init.d/shadowsocks-libev"
SHADOWSOCKS_LIBEV_CONFIG="/etc/shadowsocks-libev/config.json"
SHADOWSOCKS_LIBEV_CENTOS="https://git.io/fjcLb"
SHADOWSOCKS_LIBEV_DEBIAN="https://git.io/fjcLN"


# shadowsocklibev-libev dependencies
LIBSODIUM_FILE="libsodium-1.0.17"
LIBSODIUM_URL="https://github.com/jedisct1/libsodium/releases/download/1.0.17/libsodium-1.0.17.tar.gz"
MBEDTLS_FILE="mbedtls-2.16.0"
MBEDTLS_URL="https://tls.mbed.org/download/mbedtls-2.16.0-gpl.tgz"



# kcptun
KCPTUN_INSTALL_DIR="/usr/local/kcptun/kcptun-server"
KCPTUN_INIT="/etc/init.d/kcptun"
KCPTUN_CONFIG="/etc/kcptun/config.json"
KCPTUN_LOG_DIR="/var/log/kcptun-server.log"
KCPTUN_CENTOS="https://git.io/fjcLx"
KCPTUN_DEBIAN="https://git.io/fjcLp"


# cloak
CK_DB_PATH="/etc/cloak/db"
CK_CLIENT_CONFIG="/etc/cloak/ckclient.json"


# caddy
CADDY_CONF_FILE="/usr/local/caddy/Caddyfile"
CADDY_INSTALL_SCRIPT_URL="https://git.io/fjuAR"


# shadowsocklibev-libev Ciphers
SHADOWSOCKS_CIPHERS=(
rc4-md5
salsa20
chacha20
chacha20-ietf
aes-256-cfb
aes-192-cfb
aes-128-cfb
aes-256-ctr
aes-192-ctr
aes-128-ctr
bf-cfb
camellia-128-cfb
camellia-192-cfb
camellia-256-cfb
aes-256-gcm
aes-192-gcm
aes-128-gcm
xchacha20-ietf-poly1305
chacha20-ietf-poly1305
)


# kcptun crypt
KCPTUN_CRYPT=(
aes
aes-128
aes-192
salsa20
blowfish
twofish
cast5
3des
tea
xtea
xor
sm4
none
)


# v2ray-plugin Transport mode
V2RAY_PLUGIN_TRANSPORT_MODE=(
ws+http
ws+tls+[cdn]
quic+tls+[cdn]
ws+tls+web
ws+tls+web+cdn
)


# kcptun mode(no manual)
KCPTUN_MODE=(
fast3
fast2
fast
normal
)


# Simple-obfs Obfuscation wrapper
OBFUSCATION_WRAPPER=(
http
tls
)


# ipv4 and ipv6 Re
IPV4_RE="^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])$"
IPV6_RE="^\s*((([0-9A-Fa-f]{1,4}:){7}(([0-9A-Fa-f]{1,4})|:))|(([0-9A-Fa-f]{1,4}:){6}(:|((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})|(:[0-9A-Fa-f]{1,4})))|(([0-9A-Fa-f]{1,4}:){5}((:((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})?)|((:[0-9A-Fa-f]{1,4}){1,2})))|(([0-9A-Fa-f]{1,4}:){4}(:[0-9A-Fa-f]{1,4}){0,1}((:((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})?)|((:[0-9A-Fa-f]{1,4}){1,2})))|(([0-9A-Fa-f]{1,4}:){3}(:[0-9A-Fa-f]{1,4}){0,2}((:((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})?)|((:[0-9A-Fa-f]{1,4}){1,2})))|(([0-9A-Fa-f]{1,4}:){2}(:[0-9A-Fa-f]{1,4}){0,3}((:((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})?)|((:[0-9A-Fa-f]{1,4}){1,2})))|(([0-9A-Fa-f]{1,4}:)(:[0-9A-Fa-f]{1,4}){0,4}((:((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})?)|((:[0-9A-Fa-f]{1,4}){1,2})))|(:(:[0-9A-Fa-f]{1,4}){0,5}((:((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})?)|((:[0-9A-Fa-f]{1,4}){1,2})))|(((25[0-5]|2[0-4]\d|[01]?\d{1,2})(\.(25[0-5]|2[0-4]\d|[01]?\d{1,2})){3})))(%.+)?\s*$"


Green="\033[32m" && Red="\033[31m" && Yellow="\033[0;33m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && suffix="\033[0m"
Info="${Green}[信息]${suffix}"
Error="${Red}[错误]${suffix}"
Point="${Red}[提示]${suffix}"
Tip="${Green}[注意]${suffix}"
Warning="${Yellow}[警告]${suffix}"
Separator_1="——————————————————————————————"