#!/bin/bash

# Stop on the first sign of trouble
set -e

if [ $UID != 0 ]; then
    echo "ERROR: Operation not permitted. Forgot sudo?"
    exit 1
fi

#$1=create_img

SCRIPT_COMMON_FILE=$(pwd)/rak/rak/shell_script/rak_common.sh
source $SCRIPT_COMMON_FILE

print_help()
{
    echo "--help                Print help info."
    echo ""
    echo "--only-qmi=[false/true]"
    echo "                      only install qmi, default value is false"
    echo ""
    exit
}

rpi_model=`do_get_rpi_model`

ARGS=`getopt -o "" -l "help,only-qmi:" -- "$@"`

eval set -- "${ARGS}"

INSTALL_ONLY_QMI=0

CREATE_IMG="create_img"

while true; do
    case "${1}" in
        --help)
        shift;
        print_help
        ;;

        --only-qmi)
        shift;
        if [[ -n "${1}" ]]; then
            if [ "false" = "${1}" ]; then
                INSTALL_ONLY_QMI=0
            elif [ "true" = "${1}" ]; then
                INSTALL_ONLY_QMI=1
                CREATE_IMG=""
            else
                echo "invalid value"
                exit
            fi

            shift;
        fi
        ;;

        --)
        shift;
#        echo "Invalid para.1"
        break;
        ;;
#        *) 
#		echo "Invalid para.2"; break ;;
    esac
done

# select gw model
./choose_model.sh $CREATE_IMG

apt update
pushd rak
./install.sh $CREATE_IMG
sleep 1
popd

pushd ap
./install.sh $CREATE_IMG
sleep 1
popd

if [ "$INSTALL_ONLY_QMI" = 1 ]; then
    pushd chirpstack
    ./install.sh $CREATE_IMG
    sleep 1
    popd
fi

pushd qmi
./install.sh $CREATE_IMG
sleep 1
popd
if [ "$CREATE_IMG" = "create_img" ]; then
    pushd /usr/local/rak
    mv bin bin_bak
    popd
fi

pushd sysconf
./install.sh $CREATE_IMG
sleep 1
popd

echo_success "*************************************************"
echo_success "*   The LTE module is successfully installed!   *"
echo_success "*************************************************"
