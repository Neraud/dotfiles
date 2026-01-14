#!/usr/bin/env bash

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
ANSIBLE_VENV_PATH=${PROJECT_DIR}/.venv

if [ "$EUID" -eq 0 ] ;   then 
    echo "Don't run as root, use a regular user." >&2
    exit
fi

os_type=$(uname)
echo "Linux Darwin" | grep -w -q ${os_type}
if [ $? -ne 0 ] ; then
    echo "OS type ${os_type} is not supported" >&2
    exit
fi

if [ "${os_type}" == "Linux" ] ; then
    os_id=$(grep -E "^ID=" /etc/os-release | cut -d= -f2)
    echo "arch ubuntu" | grep -w -q ${os_id}
    if [ $? -ne 0 ] ; then
        os_pretty_name=$(grep -E "^PRETTY_NAME=" /etc/os-release | cut -d= -f2)
        echo "OS $os_pretty_name (${os_id}) is not supported" >&2
        exit
    fi
fi

if ! (command -v pyenv) 2>&1 >/dev/null ; then
    echo "pyenv not found, please install it before running this script." >&2
    exit
fi

echo "Install required python version"
(cd ${PROJECT_DIR} && pyenv install)

echo ""
echo "Create and activate ansible virtual env"
(cd ${PROJECT_DIR} && python3 -m venv ${ANSIBLE_VENV_PATH})
source ${ANSIBLE_VENV_PATH}/bin/activate

echo ""
echo "Install python ansible requirements"
pip3 install -r ${PROJECT_DIR}/requirements.txt
