show_config(){
    if [ -e $HUMAN_CONFIG ]; then
        clear -x
        cat $HUMAN_CONFIG
    else
        echo "The visual configuration was not found..."
    fi
}