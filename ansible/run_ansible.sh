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

if [ ! -d "${ANSIBLE_VENV_PATH}" ] ; then
    echo "Ansible virtual env has not been installed yet. Please run install_requirements.sh first." >&2
    exit
fi
source ${ANSIBLE_VENV_PATH}/bin/activate

ansible-playbook ${PROJECT_DIR}/site.yml -i ${PROJECT_DIR}/inventory.ini --ask-become-pass
