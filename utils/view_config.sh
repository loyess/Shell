show_config(){
    local mark=$1
    if [ -e $HUMAN_CONFIG ]; then
        if [[ ${mark} == "standalone" ]]; then
            clear -x
        fi
        cat $HUMAN_CONFIG
    else
        echo "The visual configuration was not found."
    fi
}