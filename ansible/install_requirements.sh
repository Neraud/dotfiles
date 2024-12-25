#!/usr/bin/env bash

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
ANSIBLE_VENV_PATH=${PROJECT_DIR}/.venv

if [ "$EUID" -eq 0 ] ;   then 
    echo "Don't run as root, use a regular user." >&2
    exit
fi

os_id=$(grep -E "^ID=" /etc/os-release | cut -d= -f2)

echo "arch ubuntu" | grep -w -q ${os_id}
if [ $? -ne 0 ] ; then
    os_pretty_name=$(grep -E "^PRETTY_NAME=" /etc/os-release | cut -d= -f2)
    echo "OS $os_pretty_name (${os_id}) is not supported" >&2
    exit
fi

if ! (command -v python3 && command -v pip3) 2>&1 >/dev/null ; then
    echo "Installing python3 and pip3 requirements"
    if [ "${os_id}" == "ubuntu" ] ; then
        sudo apt-get -y install python3 python3-pip
    elif [ "${os_id}" == "arch" ] ; then
        sudo pacman -S --noconfirm python python-pip
    fi
fi


echo "Create and activate ansible virtual env"
python3 -m venv ${ANSIBLE_VENV_PATH}
source ${ANSIBLE_VENV_PATH}/bin/activate

echo "Install python ansible requirements"
pip3 install -r ${PROJECT_DIR}/requirements.txt
