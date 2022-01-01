other_status(){
    status_init
    
    if [[ -e ${ssPath} ]] && [[ -e ${pluginPath} ]] && [[ -e ${webPath} ]]; then
        if [[ -n ${ssPid} ]] && [[ -n ${pluginPid} ]] && [[ -n ${webPid} ]]; then
            echo -e "\n${Info} ${ssName} (pid ${ssPid}) is already running."
            echo -e "${Info} ${pluginName} (pid ${pluginPid}) is already running."
            echo -e "${Info} ${webName} (pid ${webPid}) is already running.\n"
        else
            echo -e "\n${Point} ${ssName} is already installed but not running."
            echo -e "${Point} ${pluginName} is already installed but not running."
            echo -e "${Point} ${webName} is already installed but not running.\n"
        fi
    elif [[ -e ${ssPath} ]] && [[ -e ${pluginPath} ]]; then
        if [[ -n ${ssPid} ]] && [[ -n ${pluginPid} ]]; then
            echo -e "\n${Info} ${ssName} (pid ${ssPid}) is already running."
            echo -e "${Info} ${pluginName} (pid ${pluginPid}) is already running.\n"
        else
            echo -e "\n${Point} ${ssName} is already installed but not running."
            echo -e "${Point} ${pluginName} is already installed but not running.\n"
        fi
    elif [[ -e ${ssPath} ]]; then
        if [[ -n ${ssPid} ]]; then
            echo -e "\n${Info} ${ssName} (pid ${ssPid}) is already running.\n"
        else
            echo -e "\n${Point} ${ssName} is already installed but not running.\n"
        fi
    else
        echo -e "\n${Error} Shadowsocks and related plugins are not installed.\n"
        exit 1
    fi
}