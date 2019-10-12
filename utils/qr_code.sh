gen_qr_code(){
    local ss_url=$1
    
    if [[ $(echo "${ss_url}" | grep "^ss://") ]]; then
        if [ "$(command -v qrencode)" ]; then
            echo
            echo -e "生成二维码如下："
            echo
            qrencode -m 2 -l L -t ANSIUTF8 -k "${ss_url}"
            echo
            echo -e " ${Tip} 扫码后请仔细检查配置是否正确，如若存在差异请自行手动调整."
            echo
        else
            echo
            echo -e " ${Error} 手动生成二维码失败，请确认qrencode是否正常安装."
            echo
        fi
    else
        echo -e "
 Usage:
    ./ss-plugins.sh scan <a ss link>"
        echo
        echo -e " ${Error} 仅支持生成ss:// 开头的链接，请确认使用方式和要生成的链接是否正确."
        echo
        exit 1
    fi
}