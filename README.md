# Neraud's dotfiles

## Shell

The ansible playbook under the `ansible` folder installs and configures a working `zsh` shell.
It has been developed for Ubuntu 24 LTS and Arch.

Configurations in this repo are linked to their path (usually under `$HOME/.config`) using GNU stow.

### Installation

```bash
# Install ansible requirements
./ansible/install_requirements.sh

# Run the playbook
./ansible/run_ansible.sh
```

### Zsh shell

* Zsh, with a configured `.zshrc` and plugins:
  * [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting.git)
    * with [Catppuccin theme](https://github.com/catppuccin/zsh-syntax-highlighting.git)
  * [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions.git)
  * [zsh-completions](https://github.com/zsh-users/zsh-completions.git)
* [Powerlevel10k](https://github.com/romkatv/powerlevel10k.git) prompt

zsh default configurations are deployed under `$HOME/.config/zsh` (see `zsh/.config/zsh`).
Host specific configurations are supported, and are optionally loaded from `$HOME/.config/zsh.local`.

### Common tools

It also deploys:

* JetBrainsMono NerdFont
* [stow](https://www.gnu.org/software/stow/) to link files from this repo under home
* [bat](https://github.com/sharkdp/bat)
* btop
* [eza](https://github.com/eza-community/eza)
* [fastfetch](https://github.com/fastfetch-cli/fastfetch)
* [fzf](https://github.com/junegunn/fzf)
* [k9s](https://github.com/derailed/k9s)
* [lazygit](https://github.com/jesseduffield/lazygit)
* [lazydocker](https://github.com/jesseduffield/lazydocker)
* tmux and tmuxp
* [topgrade](https://github.com/topgrade-rs/topgrade)
* [yazi](https://github.com/sxyazi/yazi)
* [zoxide](https://github.com/ajeetdsouza/zoxide)
