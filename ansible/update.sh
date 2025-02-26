#!/usr/bin/env bash

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
DOTFILES_ROOT="${PROJECT_DIR}/.."

function get_github_last_release {
    repo="$1"
    curl -s https://api.github.com/repos/$repo/releases \
        | jq -r 'first(.[] | select(.prerelease == false and .draft == false) | .tag_name)'
}

function update_ansible_variable {
    role=$1
    variable=$2
    new_value=$3

    var_file="${PROJECT_DIR}/roles/${role}/vars/main.yml"

    if [ ! -f "${var_file}" ] ; then
        echo "Variable file '${var_file}' doesn't exist" >&2
        return 1
    fi

    current_value=$(yq .${variable} ${var_file})

    if [ "${current_value}" == "null" ] ; then
        echo "Variable '${role}' : '${variable}' doesn't exist" >&2
        return 1
    fi

    if [ "${new_value}" == "${current_value}" ] ; then
        echo "${role} : ${variable} = ${current_value} : already up to date"
    else
        echo "${role} : ${variable} = ${current_value} => ${new_value}"
        yq -i ".${variable} = \"${new_value}\"" ${var_file}
    fi
}

echo "Updating ansible variables"
eza_version=$(get_github_last_release eza-community/eza)
update_ansible_variable eza eza_version ${eza_version}

fastfetch_version=$(get_github_last_release fastfetch-cli/fastfetch)
update_ansible_variable fastfetch fastfetch_version ${fastfetch_version}

fzf_version=$(get_github_last_release junegunn/fzf)
update_ansible_variable fzf fzf_version ${fzf_version}

k9s_version=$(get_github_last_release derailed/k9s)
update_ansible_variable k9s k9s_version ${k9s_version}

lazygit_version=$(get_github_last_release jesseduffield/lazygit)
update_ansible_variable lazygit lazygit_version ${lazygit_version}

lazydocker_version=$(get_github_last_release jesseduffield/lazydocker)
update_ansible_variable lazydocker lazydocker_version ${lazydocker_version}

nerd_fonts_version=$(get_github_last_release ryanoasis/nerd-fonts)
update_ansible_variable requirements nerd_fonts_version ${nerd_fonts_version}

topgrade_version=$(get_github_last_release topgrade-rs/topgrade)
update_ansible_variable topgrade topgrade_version ${topgrade_version}

yazi_version=$(get_github_last_release sxyazi/yazi)
update_ansible_variable yazi yazi_version ${yazi_version}

zoxide_version=$(get_github_last_release ajeetdsouza/zoxide)
update_ansible_variable zoxide zoxide_version ${zoxide_version}

echo ""
echo "Updating files in dotfiles"
echo "- bat (catppuccin theme)"
curl -sL -o "${DOTFILES_ROOT}/bat/.config/bat/themes/catppuccin-mocha.tmTheme" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme

echo "- btop (catppuccin theme)"
curl -sL -o "${DOTFILES_ROOT}/btop/.config/btop/themes/catppuccin_mocha.theme" https://github.com/catppuccin/btop/raw/main/themes/catppuccin_mocha.theme

echo "- k9s (catppuccin theme)"
curl -sL https://github.com/catppuccin/k9s/archive/main.tar.gz | tar xz -C "${DOTFILES_ROOT}/k9s/.config/k9s/skins" --strip-components=2 k9s-main/dist

echo "- kitty (catppuccin theme)"
curl -sL -o "${DOTFILES_ROOT}/kitty/.config/kitty/current-theme.conf" https://raw.githubusercontent.com/catppuccin/kitty/refs/heads/main/themes/mocha.conf

echo "- lazygit (catppuccin theme)"
curl -sL -o "${DOTFILES_ROOT}/lazygit/.config/lazygit/theme.yml" https://raw.githubusercontent.com/catppuccin/lazygit/refs/heads/main/themes-mergable/mocha/lavender.yml

echo "- yazi (catppuccin theme)"
curl -sL -o "${DOTFILES_ROOT}/yazi/.config/yazi/theme.toml" https://raw.githubusercontent.com/catppuccin/yazi/refs/heads/main/themes/mocha/catppuccin-mocha-lavender.toml
sed -i -E 's|^syntect_theme +=.*|syntect_theme = "~/.config/bat/themes/catppuccin-mocha.tmTheme"|' ${DOTFILES_ROOT}/yazi/.config/yazi/theme.toml

echo "- tmux (catppuccin theme)"
tmux_catppuccin_version=$(get_github_last_release catppuccin/tmux)
sed -i -E "s|^set -g @plugin 'catppuccin/tmux#v.*'$|set -g @plugin 'catppuccin/tmux#${tmux_catppuccin_version}'|" ${DOTFILES_ROOT}/tmux/.config/tmux/theme.conf
