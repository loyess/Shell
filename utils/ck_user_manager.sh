is_the_api_open(){
    local mark=$1
    local PID=$(ps -ef |grep -v grep | grep ck-client |awk '{print $2}')
    
    if [ "${mark}" == "start" ]; then
        if [ -z ${PID} ]; then
            # open the Api
            ${CLOAK_CLIENT_BIN_PATH} -s 127.0.0.1 -l 8080 -a $(cat ${CK_SERVER_CONFIG} | jq -r .AdminUID) -c ${CK_CLIENT_CONFIG} > /dev/null 2>&1 &
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
    echo -e "UID: ${Green}${CK_UID}${suffix} 添加成功."
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

    curl -H "Content-type: application/json" -X POST -d "${UserInfo}" http://127.0.0.1:8080/admin/users/$(echo "${CK_UID}" | tr '+' '-' | tr '/' '_') -sS
    
    sleep 0.5
    
    echo
    echo -e "UID: ${Green}${CK_UID}${suffix} 添加成功."
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
    echo -e "UID: ${Green}${DEL_UNRESTRICTED_UID}${suffix} 删除成功."
    echo
}

del_restricted_users(){
    curl -X DELETE http://127.0.0.1:8080/admin/users/$(echo "${DEL_RESTRICTED_UID}" | tr '+' '-' | tr '/' '_') -sS
    
    sleep 0.5
    
    echo
    echo -e "UID: ${Green}${DEL_RESTRICTED_UID}${suffix} 删除成功."
    echo
}

add_restricted_users_logic_code(){
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
}

add_unrestricted_users_logic_code(){
    while true
    do
        # generation CK_UID
        gen_credentials
        CK_UID=${ckauid}

        add_unrestricted_users
        
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
}

del_restricted_users_logic_code(){
    while true
    do
        list_restricted_users
        
        if [ ${userslist} = "null" ]; then
            echo
            echo -e "${Point} 当前没有受限用户可以删除."
            echo
            break
        fi
        
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
    done
}

del_unrestricted_users_logic_cade(){
    while true
    do
        list_unrestricted_users
        
        if [[ ${#UIDS[*]} = 0 ]]; then
            echo
            echo -e "${Point} 当前没有不受限用户可以删除."
            echo
            break
        fi
        
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
    done
}

download_ck_clinet(){
    local CK_CLIENT_V=$1
    
    # Download cloak client
    local cloak_file="ck-client-linux-${ARCH}-v${CK_CLIENT_V}"
    local cloak_url="https://github.com/cbeuw/Cloak/releases/download/v${CK_CLIENT_V}/ck-client-linux-${ARCH}-v${CK_CLIENT_V}"
    improt_package "utils" "downloads.sh"
    download "${cloak_file}" "${cloak_url}"
    
    # install ck-client
    cd ${CUR_DIR}
    chmod +x ${cloak_file}
    mv ${cloak_file} ${CLOAK_CLIENT_BIN_PATH}
    [ -f ${CLOAK_CLIENT_BIN_PATH} ] && ln -fs ${CLOAK_CLIENT_BIN_PATH} /usr/bin
}

ck2_users_manager(){
    if [[ ! -e ${CLOAK_CLIENT_BIN_PATH} ]]; then
        # Download cloak client
        cloak_ver=$(ck-server -v | grep ck-server | cut -d\  -f2 | sed 's/v//g')
        download_ck_clinet ${cloak_ver}
    fi
    
    ck_server_v=$(ck-server -v | grep ck-server | cut -d\  -f2 | sed 's/v//g')
    ck_client_v=$(ck-client -v | grep ck-client | cut -d\  -f2 | sed 's/v//g')
    if version_gt ${ck_server_v} ${ck_client_v}; then
        # Download cloak client
        cloak_ver=${ck_server_v}
        download_ck_clinet ${cloak_ver}
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
                    add_restricted_users_logic_code
                    ;;
                2)
                    add_unrestricted_users_logic_code
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
                    del_restricted_users_logic_code
                    ;;
                2)  
                    del_unrestricted_users_logic_cade
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

user_manager_by_uid(){
    if [ ! "$(command -v ck-server)" ]; then
        echo -e "\n${Error} 仅支持 ss + cloak 组合下使用，请确认是否是以该组合形式运行.\n"
        exit 1
    fi

    ck2_users_manager
    sleep 0.5
    is_the_api_open "stop"
}