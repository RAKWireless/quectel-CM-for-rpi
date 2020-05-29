#!/bin/bash

# Stop on the first sign of trouble
#set -e

if [ $UID != 0 ]; then
    echo "ERROR: Operation not permitted. Forgot sudo?"
    exit 1
fi

SCRIPT_COMMON_FILE=$(pwd)/rak/rak/shell_script/rak_common.sh
source $SCRIPT_COMMON_FILE

rpi_model=`do_get_rpi_model`

function echo_yellow()
{
    echo -e "\033[1;33m$1\033[0m"
}

do_check_variable_type(){
    local a="$1"
    printf "%d" "$a" &>/dev/null && return 0
    printf "%d" "$(echo $a|sed 's/^[+-]\?0\+//')" &>/dev/null && return 0
    printf "%f" "$a" &>/dev/null && return 1
    [ ${#a} -eq 1 ] && return 2
    return 3
}

do_check_variable_type_echo(){
    local a="$1"
    printf "%d" "$a" &>/dev/null && echo "integer, return 0" && return 0
    printf "%d" "$(echo $a|sed 's/^[+-]\?0\+//')" &>/dev/null && echo "integer,return 0" && return 0
    printf "%f" "$a" &>/dev/null && echo "number,return 1" && return 1
    [ ${#a} -eq 1 ] && echo "char, return 2" && return 2
    echo "string, return 3" && return 3
}

function echo_model_info()
{
    echo_yellow "Please select your LTE model:"
    echo_yellow "*\t1.RAK2013"
    echo_yellow "*\t2.RAK8213"
    echo_yellow  "Please enter 1-2 to select the model:\c"
}

function do_set_model_to_json()
{
    set -e
    JSON_FILE=./rak/rak/rak_gw_model.json
    RAK_GW_JSON=./rak/rak/gateway-config-info.json
    INSTALL_LTE=0
    if [ $1 -eq 1 ]; then
        GW_MODEL=RAK2013
    elif [ $1 -eq 2 ]; then
        GW_MODEL=RAK8213
    else
        # Never come here
        echo "error"
        return 1
    fi

    linenum=`sed -n "/gw_model/=" $JSON_FILE`
    sed -i "${linenum}c\\\\t\"gw_model\": \"$GW_MODEL\"," $JSON_FILE
    set +e
}

function do_set_model()
{
    set -e
    echo_model_info
    while [ 1 -eq 1 ]
    do
        read RAK_MODEL
        if [ -z "$RAK_MODEL" ]; then
            echo_yellow "Please enter 1-2 to select the model:\c"
            continue
        fi

        do_check_variable_type $RAK_MODEL
        RET=$?

        if [ $RET -eq 0 ]; then
            if [ $RAK_MODEL -lt 1 ] || [ $RAK_MODEL -gt 2 ]; then
                echo_yellow "Please enter 1-2 to select the model:\c"
                continue
            else
                do_set_model_to_json $RAK_MODEL
                set +e
                return 0
            fi
        else
            echo_yellow "Please enter 1-2 to select the model:\c"
            continue

        fi
    done
}

do_set_model

