gen_qr_code(){
    local ss_url=$1

    if [[ $(echo "${ss_url}" | grep "^ss://") ]]; then
        if [ "$(command -v qrencode)" ]; then
            _echo "生成二维码如下："
            qrencode -m 2 -l L -t ANSIUTF8 -k "${ss_url}"
            _echo -t "扫码后请仔细检查配置是否正确，如若存在差异请自行手动调整."
        else
            _echo -e "手动生成二维码失败，请确认qrencode是否正常安装."
        fi
    else
        _echo -d "Usage: ./ss-plugins.sh scan <a ss link>"
        _echo -e "仅支持生成ss:// 开头的链接，请确认使用方式和要生成的链接是否正确."
        exit 1
    fi
}