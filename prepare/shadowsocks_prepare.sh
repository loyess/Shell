# ss development language version
SS_DLV=(
ss-libev
ss-rust
go-ss2
)

SHADOWSOCKS_LIBEV_CIPHERS=(
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

SHADOWSOCKS_RUST_CIPHERS=(
none
aes-256-gcm
aes-128-gcm
chacha20-ietf-poly1305
2022-blake3-aes-128-gcm
2022-blake3-aes-256-gcm
2022-blake3-chacha20-poly1305
)

GO_SHADOWSOCKS2_CIPHERS=(
AEAD_AES_128_GCM
AEAD_AES_256_GCM
AEAD_CHACHA20_POLY1305
)


choose_ss_install_version(){
    generate_menu_logic "${SS_DLV[*]}" "Shadowsocks版本" "2"
    SS_VERSION="${optionValue}"
}

install_prepare_port() {
    while true
    do
        gen_random_prot
        _read "请输入监听端口[1-65535] (默认: ${ran_prot}):"
        shadowsocksport="${inputInfo}"
        [ -z "${shadowsocksport}" ] && shadowsocksport="${ran_prot}"
        if ! judge_is_num "${shadowsocksport}"; then
            _echo -e "请输入一个有效数字."
            continue
        fi
        if judge_is_zero_begin_num "${shadowsocksport}"; then
            _echo -e "请输入一个非0开头的数字."
            continue
        fi
        if ! judge_num_in_range "${shadowsocksport}" "65535"; then
            _echo -e "请输入一个在1-65535之间的数字."
            continue
        fi
        kill_process_if_port_occupy "${shadowsocksport}"
        _echo -r "  port = ${shadowsocksport}"
        break
    done
}

install_prepare_password(){
    gen_random_str
    _read "请输入密码 (默认: ${ran_str12}):"
    shadowsockspwd="${inputInfo}"
    [ -z "${shadowsockspwd}" ] && shadowsockspwd="${ran_str12}"
    _echo -r "  password = ${shadowsockspwd}"
}

gen_random_psk(){
    shadowsockspwd=$(openssl rand -base64 "$1")
    _echo -i "你选择了AEAD-2022加密方式, SS-Rust密码变更为自动生成的PSK, 如下："
    _echo -r "  password = ${shadowsockspwd}"
}

install_prepare_cipher(){
    while true
    do
        if [ "${SS_VERSION}" = "ss-libev" ]; then
            local tempNum=17
            local SHADOWSOCKS_CIPHERS=( "${SHADOWSOCKS_LIBEV_CIPHERS[@]}" )
        elif [ "${SS_VERSION}" = "ss-rust" ]; then
            local tempNum=3
            local SHADOWSOCKS_CIPHERS=( "${SHADOWSOCKS_RUST_CIPHERS[@]}" )
        elif [ "${SS_VERSION}" = "go-ss2" ]; then
            local tempNum=1
            local SHADOWSOCKS_CIPHERS=( "${GO_SHADOWSOCKS2_CIPHERS[@]}" )
        fi
        generate_menu_logic "${SHADOWSOCKS_CIPHERS[*]}" "Shadowsocks加密方式" "${tempNum}"
        shadowsockscipher="${optionValue}"
        if [ "${shadowsockscipher}" == "AEAD_AES_128_GCM" ]; then
            shadowsockscipher="aes-128-gcm"
        elif [ "${shadowsockscipher}" == "AEAD_AES_256_GCM" ]; then
            shadowsockscipher="aes-256-gcm"
        elif [ "${shadowsockscipher}" == "AEAD_CHACHA20_POLY1305" ]; then
            shadowsockscipher="chacha20-ietf-poly1305"
        fi
        if [ "${shadowsockscipher}" = "2022-blake3-aes-128-gcm" ]; then
            gen_random_psk 16
        elif [ "${shadowsockscipher}" = "2022-blake3-aes-256-gcm" ]; then
            gen_random_psk 32
        elif [ "${shadowsockscipher}" = "2022-blake3-chacha20-poly1305" ]; then
            gen_random_psk 32
        else
            CipherMark="Non-AEAD-2022"
        fi
        break
    done
}