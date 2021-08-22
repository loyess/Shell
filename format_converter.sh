#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH



dos2unix ./ss-plugins.sh

dos2unix ./utils/*
dos2unix ./tools/*
dos2unix ./plugins/*
dos2unix ./service/*
dos2unix ./prepare/*
dos2unix ./templates/config/*
dos2unix ./templates/links/*
dos2unix ./templates/visible/*
dos2unix ./templates/caddy_config.sh
dos2unix ./templates/nginx_config.sh
