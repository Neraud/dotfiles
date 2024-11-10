#!/usr/bin/env bash

function usage() {
    echo "This script installs and configures a shell."
    echo "It can run on Ubuntu or Arch systems."
    echo ""
    echo "Usage : "
    echo "$0 (-s [bash])"
    echo " -s shell : select which shell to install, bash (default)"
}

while getopts "hs:" arg; do
    case $arg in
    h)
        usage
        exit 0
        ;;
    s) shell_to_install=$OPTARG ;;
    esac
done


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

yay_installed=0
if [ "${os_id}" == "arch" ] ; then
    which yay 2>&1 > /dev/null
    if [ $? -eq 0 ] ; then
        yay_installed=1
    fi
fi

if [ -z "${shell_to_install}" ] ; then
    shell_to_install="bash"
    echo "Using default shell: ${shell_to_install}"
else
    echo "bash" | grep -w -q ${shell_to_install}
    if [ $? -ne 0 ] ; then
        echo "Shell ${shell_to_install} is not supported" >&2
        exit
    fi
    echo "Using shell: ${shell_to_install}"
fi


echo ""
echo "===================================================================================================="
echo "Install requirements"
if [ "${os_id}" == "ubuntu" ] ; then
    sudo apt-get -y install curl unzip jq
elif [ "${os_id}" == "arch" ] ; then
    sudo pacman -S --noconfirm curl unzip jq
fi
echo "===================================================================================================="


echo ""
echo "===================================================================================================="
echo "Installing stow"
if [ "${os_id}" == "ubuntu" ] ; then
    sudo apt-get -y install stow
elif [ "${os_id}" == "arch" ] ; then
    sudo pacman -S --noconfirm stow
fi

if [ "${shell_to_install}" == "bash" ] ; then
    if [ -f $HOME/.bashrc ] && [ ! -L $HOME/.bashrc ] ; then
        echo "Existing .bashrc found, backuping"
        # Stow refuses to overwrite a regular file, and .bashrc is created by default.
        mv $HOME/.bashrc $HOME/.bashrc.$(date '+%Y-%m-%d')
    fi

    if [ ! -f $HOME/.bash_profile ] ; then
        echo "No .bash_profile found, creating a default one"
        cat <<EOF > $HOME/.bash_profile
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

EOF
    fi
fi


# Make sure .config exists to avoid stowing it to the first package that uses it
mkdir -p $HOME/.config

if [ "${shell_to_install}" == "bash" ] ; then
    echo "Stowing bash dotfiles"
    for name in bash ble starship; do
        echo " - $name"
        stow --target=$HOME --verbose --stow $name
    done
fi
echo "===================================================================================================="


echo ""
echo "===================================================================================================="
echo "Installing NerdFont JetBrainsMono"
if [ "${os_id}" == "ubuntu" ] ; then
    sudo mkdir -p /usr/local/share/fonts
    # From https://www.nerdfonts.com/font-downloads
    curl -Lo /tmp/JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
    sudo unzip -o /tmp/JetBrainsMono.zip -d /usr/local/share/fonts/
    rm /tmp/JetBrainsMono.zip
    fc-cache -fv
elif [ "${os_id}" == "arch" ] ; then
    sudo pacman -S --noconfirm ttf-jetbrains-mono-nerd
fi
echo "===================================================================================================="


if [ "${shell_to_install}" == "bash" ] ; then
    echo ""
    echo "===================================================================================================="
    echo "Installing Starship"
    if [ "${os_id}" == "ubuntu" ] ; then
        curl -Lo /tmp/starship.tar.gz https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-gnu.tar.gz
        sudo tar zxf /tmp/starship.tar.gz -C /usr/local/bin/
        rm /tmp/starship.tar.gz
    elif [ "${os_id}" == "arch" ] ; then
        sudo pacman -S --noconfirm starship
    fi
    echo "===================================================================================================="


    echo ""
    echo "===================================================================================================="
    echo "Installing Ble.sh"
    if [ "${os_id}" == "arch" -a ${yay_installed} -eq 1 ] ; then
        yay -S --noconfirm blesh-git
    else
        if [ -d ~/ble-nightly ] ; then
            rm -Rf ~/ble-nightly
        fi
        curl -L https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz | tar xJf - -C $HOME
    fi
    echo "===================================================================================================="
fi

echo ""
echo "===================================================================================================="
echo "Installing fzf"
if [ "${os_id}" == "ubuntu" ] ; then
    # fzf version in Ubuntu repo is very old, use github releases instead
    fzf_release=$(curl https://api.github.com/repos/junegunn/fzf/releases | jq -r '.[0].name')
    curl -Lo /tmp/fzf.tar.gz https://github.com/junegunn/fzf/releases/download/v${fzf_release}/fzf-${fzf_release}-linux_amd64.tar.gz
    sudo tar zxf /tmp/fzf.tar.gz -C /usr/local/bin/
    rm /tmp/fzf.tar.gz

    
    if [ "${shell_to_install}" == "bash" ] ; then
        echo "Installing fzf for Ble.sh integration"
        sudo mkdir -p /usr/local/share/fzf
        # Ble.sh integration requires scripts that are not bundled in the binary archive
        # We fetch them from the source code and save them at the expected paths
        curl -Lo /tmp/fzf-src.tar.gz https://github.com/junegunn/fzf/archive/refs/tags/v${fzf_release}.tar.gz
        sudo tar zxf /tmp/fzf-src.tar.gz --strip-components=1 -C /usr/local/share/fzf/ fzf-${fzf_release}/shell
        rm /tmp/fzf-src.tar.gz
    fi
elif [ "${os_id}" == "arch" ] ; then
    sudo pacman -S --noconfirm fzf
fi
echo "===================================================================================================="


echo ""
echo "===================================================================================================="
echo "Installing zoxide"
if [ "${os_id}" == "ubuntu" ] ; then
    zoxide_release=$(curl https://api.github.com/repos/ajeetdsouza/zoxide/releases | jq -r '.[0].name')
    curl -Lo /tmp/zoxide.deb https://github.com/ajeetdsouza/zoxide/releases/download/v${zoxide_release}/zoxide_${zoxide_release}-1_amd64.deb
    sudo dpkg -i /tmp/zoxide.deb
    rm /tmp/zoxide.deb
elif [ "${os_id}" == "arch" ] ; then
    sudo pacman -S --noconfirm zoxide
fi
echo "===================================================================================================="


#echo ""
#echo "===================================================================================================="
#echo "Installing Yazi"
#if [ "${os_id}" == "ubuntu" ] ; then
#    echo "Install Yazi requirements"
#    sudo apt-get -y install ffmpegthumbnailer p7zip jq poppler-utils fd-find ripgrep imagemagick
#    curl -Lo /tmp/yazi.zip https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-gnu.zip
#    sudo unzip -o -j /tmp/yazi.zip yazi-x86_64-unknown-linux-gnu/ya yazi-x86_64-unknown-linux-gnu/yazi -d /usr/local/bin
#    if [ -d /etc/bash_completion.d ] ; then
#        sudo unzip -o -j /tmp/yazi.zip yazi-x86_64-unknown-linux-gnu/completions/ya.bash yazi-x86_64-unknown-linux-gnu/completions/yazi.bash -d /etc/bash_completion.d/
#    fi
#    # TODO zsh completion ?
#    rm /tmp/yazi.zip
#elif [ "${os_id}" == "arch" ] ; then
#    sudo pacman -S --noconfirm yazi ffmpegthumbnailer p7zip jq poppler fd ripgrep imagemagick
#fi
#echo "===================================================================================================="
