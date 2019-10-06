#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH



dos2unix ./ss-plugins.sh

dos2unix ./utils/ck_sslink.sh
dos2unix ./utils/ck_user_manager.sh
dos2unix ./utils/qr_code.sh
dos2unix ./utils/view_config.sh


dos2unix ./prepare/shadowsocks_libev_prepare.sh
dos2unix ./prepare/v2ray_plugin_prepare.sh
dos2unix ./prepare/kcptun_prepare.sh
dos2unix ./prepare/simple_obfs_prepare.sh
dos2unix ./prepare/goquiet_prepare.sh
dos2unix ./prepare/cloak_prepare.sh


dos2unix ./tools/shadowsocks_libev_install.sh
dos2unix ./tools/caddy_install.sh



dos2unix ./plugins/v2ray_plugin_install.sh
dos2unix ./plugins/kcptun_install.sh
dos2unix ./plugins/simple_obfs_install.sh
dos2unix ./plugins/goquiet_install.sh
dos2unix ./plugins/cloak_install.sh


dos2unix ./templates/config_file_templates.sh
dos2unix ./templates/sip002_url_templates.sh
dos2unix ./templates/terminal_config_templates.sh


dos2unix ./service/caddy_centos.sh
dos2unix ./service/caddy_debian.sh
dos2unix ./service/cloak_centos.sh
dos2unix ./service/cloak_debian.sh
dos2unix ./service/kcptun_centos.sh
dos2unix ./service/kcptun_debian.sh
dos2unix ./service/shadowsocks-libev_centos.sh
dos2unix ./service/shadowsocks-libev_debian.sh
