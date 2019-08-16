add_a_new_uid(){
    if [[ ! -e '/usr/local/bin/ck-client' ]]; then
        cloak_ver="1.1.2"
        # Download cloak client
        local cloak_file="ck-client-linux-amd64-${cloak_ver}"
        local cloak_url="https://github.com/cbeuw/Cloak/releases/download/v${cloak_ver}/ck-client-linux-amd64-${cloak_ver}"
        download "${cloak_file}" "${cloak_url}"
        
        # install ck-client
        cd ${CUR_DIR}
        chmod +x ${cloak_file}
        mv ${cloak_file} /usr/local/bin/ck-client
    fi
    
    # get parameter from ss config.json
    gen_credentials
    local new_uid=${ckauid}
    local ip=$(get_ip)
    local port=443
    local admin_uid=$(cat ${SHADOWSOCKS_LIBEV_CONFIG} | grep -o -P "AdminUID=.*?;" | sed 's/AdminUID=//g;s/;//g')

    # show about info
    echo
    echo -e " ${Green}UID  (新)${suffix}：${Red}${new_uid}${suffix}"
    echo
    echo -e " ${Green}IP (端口)${suffix}：${Red}${ip}:${port}${suffix}"
    echo -e " ${Green}UID(管理)${suffix}：${Red}${admin_uid}${suffix}"
    echo
    echo -e "
 添加新用户：
    1. ck-server -u 生成一个New 的 UID
    2. ck-client -a -c <path-to-ckclient.json> 进入admin 模式。
    3. 输入，服务器ip:port 和 AdminUID ，选择4 ，新建一个用户。
    4. 根据提示输入如下：
        1. Newly generated UID      # 输入上方新生成的 UID
        2. SessionsCap              # 用户可以拥有的最大并发会话数(填写 4)
        3. UpRate                   # 上行速度 (单位：bytes/s)
        4. DownRate                 # 下行速度 (单位：bytes/s)
        5. UpCredit                 # 上行限制 (单位：bytes)
        6. DownCredit               # 下行限制 (单位：bytes)
        7. ExpiryTime               # user账号的有效期，unix时间格式(10位时间戳)
    5. 将你的 公钥 和 新生成的UID 给这个新用户。
    
 ${Tip} 下方输入从第3步开始，根据提示输入，退出请按 Ctrl + C ...
 
 "
        
    # Enter admin mode
    ck-client -a -c ${CK_CLIENT_CONFIG}
}

is_the_api_open(){
    local mark=$1
    local PID=$(ps -ef |grep -v grep | grep ck-client |awk '{print $2}')
    
    if [ "${mark}" == "start" ]; then
        if [ -z ${PID} ]; then
            # open the Api
            /usr/local/bin/ck-client -s 127.0.0.1 -l 8080 -a $(cat ${CK_SERVER_CONFIG} | jq -r .AdminUID) -c ${CK_CLIENT_CONFIG} > /dev/null 2>&1 &
            sleep 0.5
        fi
    elif [ "${mark}" == "stop" ]; then
        # close the Api
        disown ${PID} > /dev/null 2>&1 &
        sleep 0.5
        
        kill -9 ${PID}
    fi
    
}

add_unrestricted_users(){
    local temp_conf=$(jq --arg k "${CK_UID}" '.BypassUID += [$k]' < ${CK_SERVER_CONFIG})
    echo ${temp_conf} | jq . > ${CK_SERVER_CONFIG}
    
    do_restart > /dev/null 2>&1
    
    echo
    echo -e "UID: ${Green}${CK_UID}${suffix} 添加成功..."
    echo
}

add_restricted_users(){
UserInfo=$(cat <<EOF
{
    "UID":"${CK_UID}",
    "SessionsCap":${CK_SessionsCap},
    "UpRate":${CK_UpRate},
    "DownRate":${CK_DownRate},
    "UpCredit":${CK_UpCredit},
    "DownCredit":${CK_DownCredit},
    "ExpiryTime":${CK_ExpiryTime}
}
EOF
)

    curl -X POST -d UserInfo="${UserInfo}" http://127.0.0.1:8080/admin/users/$(echo "${CK_UID}" | tr '+' '-' | tr '/' '_') -sS
    
    sleep 0.5
    
    echo
    echo -e "UID: ${Green}${CK_UID}${suffix} 添加成功..."
    echo
}

list_unrestricted_users(){
    mapfile -t UIDS < <(jq -r '.BypassUID[]' ${CK_SERVER_CONFIG})
    
    if [[ ${#UIDS[*]} != 0 ]]; then
        local i=1
        for uid in ${UIDS[@]}
        do
            if [[ ${i} == 1 ]]; then
                echo -e "Unrestricted User List --BypassUID [${Green}${#UIDS[*]}${suffix}]"
            fi
            echo -e " ${i}. UID: ${Green}${uid}${suffix}"
            
            i=$((${i} + 1))
        done
        
        echo
    else
        echo -e "Unrestricted User List --BypassUID [${Green}0${suffix}]"
        echo -e " UID: ${Green}Null${suffix}"
        echo
    fi
}

list_restricted_users(){
    userslist=$(curl http://127.0.0.1:8080/admin/users -sS)
    sleep 0.5
    
    if [ ${userslist} != "null" ]; then
        mapfile -t UsersArray < <(echo ${userslist} | jq -r '.[] | @base64')
        
        local i=1
        for user in ${UsersArray[@]}
        do  
            CK_UID=$(echo ${user} | base64 --decode | jq -r .UID)
            CK_SessionsCap=$(echo ${user} | base64 --decode | jq -r .SessionsCap)
            CK_UpRate=$((($(echo ${user} | base64 --decode | jq -r .UpRate)) / 1048576))
            CK_DownRate=$((($(echo ${user} | base64 --decode | jq -r .DownRate)) / 1048576))
            CK_UpCredit=$((($(echo ${user} | base64 --decode | jq -r .UpCredit)) / 1073741824))
            CK_DownCredit=$((($(echo ${user} | base64 --decode | jq -r .DownCredit)) / 1073741824))
            CK_ExpiryTime=$(((($(echo ${user} | base64 --decode | jq -r .ExpiryTime)) - ($(date +%s))) / 86400))
            if [[ ${i} == 1 ]]; then
                echo -e "Restricted User List --API [${Green}${#UsersArray[*]}${suffix}]"
            fi
            echo -e " ${i}. UID: ${Green}${CK_UID}${suffix} SessionsCap: ${Green}${CK_SessionsCap}${suffix} UpRate: ${Green}${CK_UpRate}M/s${suffix} DownRate: ${Green}${CK_DownRate}M/s${suffix} UpCredit: ${Green}${CK_UpCredit}G${suffix} DownCredit: ${Green}${CK_DownCredit}G${suffix} ExpiryTime: ${Green}${CK_ExpiryTime} day${suffix}"
            
            i=$((${i} + 1))
        done
        
        echo
    else
        echo -e "Restricted User List --API [${Green}0${suffix}]"
        echo -e " UID: ${Green}Null${suffix}"
        echo
    fi
}

del_unrestricted_users(){
    local temp_conf=$(jq --arg k "${DEL_UNRESTRICTED_UID}" '.BypassUID -= [$k]' < ${CK_SERVER_CONFIG})
    echo ${temp_conf} | jq . > ${CK_SERVER_CONFIG}
    
    do_restart > /dev/null 2>&1
    
    echo
    echo -e "UID: ${Green}${DEL_UNRESTRICTED_UID}${suffix} 删除成功..."
    echo
}

del_restricted_users(){
    curl -X DELETE http://127.0.0.1:8080/admin/users/$(echo "${DEL_RESTRICTED_UID}" | tr '+' '-' | tr '/' '_') -sS
    
    sleep 0.5
    
    echo
    echo -e "UID: ${Green}${DEL_RESTRICTED_UID}${suffix} 删除成功..."
    echo
}

ck2_users_manager(){
    if [[ ! -e '/usr/local/bin/ck-client' ]]; then
        get_ver
        # Download cloak client
        local cloak_file="ck-client-linux-amd64-${cloak_ver}"
        local cloak_url="https://github.com/cbeuw/Cloak/releases/download/v${cloak_ver}/ck-client-linux-amd64-${cloak_ver}"
        download "${cloak_file}" "${cloak_url}"
        
        # install ck-client
        cd ${CUR_DIR}
        chmod +x ${cloak_file}
        mv ${cloak_file} /usr/local/bin/ck-client
    fi
    
    is_the_api_open "start"
    
    clear -x
    echo -e "Cloak2.0 User Management："
    echo
    echo -e "${Green} 1.${suffix} 添加用户"
    echo -e "${Green} 2.${suffix} 查看用户"
    echo -e "${Green} 3.${suffix} 删除用户"
    echo
    read -e -p "请输入数字 [1-3]：" ck_user_opts
    [[ -z "${ck_user_opts}" ]] && ck_user_opts=1
    echo
    case "${ck_user_opts}" in
        1)
            echo -e "${Green}1.${suffix} 添加受限用户"
            echo -e "${Green}2.${suffix} 添加不受限用户"
            echo
            read -e -p "请输入数字 [1-2]：" add_opts
            [[ -z "${add_opts}" ]] && add_opts=1
            echo
            case "${add_opts}" in
                1)
                    while true
                    do
                        read -e -p "设置该UID最大用户连接数(默认: 2):" CK_SessionsCap
                        [[ -z "${CK_SessionsCap}" ]] && CK_SessionsCap=2
                        echo
                        echo -e "${Red}  SessionsCap = ${CK_SessionsCap}${suffix}"
                        echo
                        read -e -p "设置该UID最大上行速率(默认: 5M/s 单位：M/s):" CK_UpRate
                        [[ -z "${CK_UpRate}" ]] && CK_UpRate=5
                        echo
                        echo -e "${Red}  UpRate = ${CK_UpRate}${suffix}M/s"
                        echo
                        read -e -p "设置该UID最大下行速率(默认: 5M/s 单位：M/s):" CK_DownRate
                        [[ -z "${CK_DownRate}" ]] && CK_DownRate=5
                        echo
                        echo -e "${Red}  DownRate = ${CK_DownRate}${suffix}M/s"
                        echo
                        read -e -p "设置该UID最大上行流量(默认: 10G 单位：G):" CK_UpCredit
                        [[ -z "${CK_UpCredit}" ]] && CK_UpCredit=10
                        echo
                        echo -e "${Red}  UpCredit = ${CK_UpCredit}${suffix}G"
                        echo
                        read -e -p "设置该UID最大下行流量(默认: 10G 单位：G):" CK_DownCredit
                        [[ -z "${CK_DownCredit}" ]] && CK_DownCredit=10
                        echo
                        echo -e "${Red}  DownCredit = ${CK_DownCredit}${suffix}G"
                        echo
                        read -e -p "设置该UID凭证的有效期(默认: 30day 单位：Day):" Days
                        [[ -z "${Days}" ]] && Days=30
                        echo
                        echo -e "${Red}  ExpiryTime = ${Days}${suffix} day"
                        echo
                        
                        # generation CK_UID
                        gen_credentials
                        
                        # Parameters required for POST request
                        CK_UID=${ckauid}
                        CK_SessionsCap=${CK_SessionsCap}
                        CK_UpRate=$((${CK_UpRate} * 1048576))
                        CK_DownRate=$((${CK_DownRate} * 1048576))
                        CK_UpCredit=$((${CK_UpCredit} * 1073741824))
                        CK_DownCredit=$((${CK_DownCredit} * 1073741824))
                        CK_ExpiryTime=$((${Days} * 86400 + ($(date +%s))))
                        
                        # Initiate a POST request to add a new restricted user
                        add_restricted_users
                        
                        
                        # Determine whether to continue, do not continue to interrupt the loop
                        echo
                        read -e -p "是否继续(默认: 是)[y/n]：" yn
                        echo
                        [ -z "${yn}" ] && yn="Y"
                        case "${yn:0:1}" in
                            y|Y)
                                :
                                ;;
                            n|N)
                                break
                                ;;
                            *)
                                echo
                                echo -e "${Error} 输入有误，请重新输入!"
                                echo
                                
                                continue
                                ;;
                        esac
                    done
                    ;;
                2)
                    # generation CK_UID
                    gen_credentials
                    CK_UID=${ckauid}
                    
                    add_unrestricted_users
                    ;;
                *)
                    echo
                    echo -e "${Error} 请输入正确的数字 [1-2]"
                    echo
                    ;;
            esac
            ;;
        2)
            echo -e "${Green}1.${suffix} 查看受限用户"
            echo -e "${Green}2.${suffix} 查看不受限用户"
            echo
            read -e -p "请输入数字 [1-2]：" view_opts
            [[ -z "${view_opts}" ]] && view_opts=1
            echo
            case "${view_opts}" in
                1)
                    list_restricted_users                    
                    ;;
                2)
                    list_unrestricted_users
                    ;;
                *)
                    echo
                    echo -e "${Error} 请输入正确的数字 [1-2]"
                    echo
                    ;;
            esac
            ;;
        3)
            echo -e "${Green}1.${suffix} 删除受限用户"
            echo -e "${Green}2.${suffix} 删除不受限用户"
            echo
            read -e -p "请输入数字 [1-2]：" del_opts
            [[ -z "${del_opts}" ]] && del_opts=1
            echo
            case "${del_opts}" in
                1)  
                    while true
                    do
                        list_restricted_users
                        
                        if [ ${userslist} != "null" ]; then
                            read -e -p "请输入UID序号：" del_uid_num
                            [ -z ${del_uid_num} ] && del_uid_num=1
                            expr ${del_uid_num} + 1 &>/dev/null
                            if [ $? -eq 0 ] && [ ${del_uid_num} -ge 1 ] && [ ${del_uid_num} -le ${#UsersArray[*]} ] && [ ${del_uid_num:0:1} != 0 ]; then
                                # Get the UID pointed to by the selected sequence number
                                DEL_RESTRICTED_UID=$(echo ${userslist} | jq -r .[$((${del_uid_num} - 1))].UID)
                                
                                # Del the user by UID
                                del_restricted_users
                            else
                                echo
                                echo -e "${Error} 请输入一个正确的数 [1-${#UsersArray[*]}]"
                                echo
                                continue
                            fi
                            
                            # Determine whether to continue, do not continue to interrupt the loop
                            echo
                            read -e -p "是否继续(默认: 是)[y/n]：" yn
                            echo
                            [ -z "${yn}" ] && yn="Y"
                            case "${yn:0:1}" in
                                y|Y)
                                    :
                                    ;;
                                n|N)
                                    break
                                    ;;
                                *)
                                    echo
                                    echo -e "${Error} 输入有误，请重新输入!"
                                    echo
                                    
                                    continue
                                    ;;
                            esac
                        else
                            echo
                            echo -e "${Point} 当前没有受限用户可以删除..."
                            echo
                            
                            break
                        fi
                    done
                    ;;
                2)  
                    while true
                    do
                        list_unrestricted_users
                        
                        if [[ ${#UIDS[*]} != 0 ]]; then
                            read -e -p "请输入UID序号：" del_uid_num
                            [ -z ${del_uid_num} ] && del_uid_num=1
                            expr ${del_uid_num} + 1 &>/dev/null
                            if [ $? -eq 0 ] && [ ${del_uid_num} -ge 1 ] && [ ${del_uid_num} -le ${#UIDS[*]} ] && [ ${del_uid_num:0:1} != 0 ]; then
                                # Get the UID pointed to by the selected sequence number
                                DEL_UNRESTRICTED_UID=${UIDS[$((del_uid_num -1))]}
                                
                                # Del the user by UID
                                del_unrestricted_users
                            else
                                echo
                                echo -e "${Error} 请输入一个正确的数 [1-${#UIDS[*]}]"
                                echo
                                continue
                            fi
                            
                            # Determine whether to continue, do not continue to interrupt the loop
                            echo
                            read -e -p "是否继续(默认: 是)[y/n]：" yn
                            echo
                            [ -z "${yn}" ] && yn="Y"
                            case "${yn:0:1}" in
                                y|Y)
                                    :
                                    ;;
                                n|N)
                                    break
                                    ;;
                                *)
                                    echo
                                    echo -e "${Error} 输入有误，请重新输入!"
                                    echo
                                    
                                    continue
                                    ;;
                            esac
                        else
                            echo
                            echo -e "${Point} 当前没有不受限用户可以删除..."
                            echo
                            
                            break
                        fi
                    done
                    ;;
                *)
                    echo
                    echo -e "${Error} 请输入正确的数字 [1-2]"
                    echo
                    ;;
            esac
            ;;
        *)
            echo
            echo -e "${Error} 请输入正确的数字 [1-3]"
            echo
            ;;
    esac
}