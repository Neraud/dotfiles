# Neraud's dotfiles

## Shell

`configure_shell.sh` installs and configures tools to have a working `bash` or `zsh` shell.
It has been developed for Ubuntu (22 or 24 LTS) and Arch.

### Common tools

In both cases, it deploys:

* JetBrainsMono NerdFont
* [fzf](https://github.com/junegunn/fzf)
* [stow](https://www.gnu.org/software/stow/) to link files from this repo under home
* [zoxide](https://github.com/ajeetdsouza/zoxide)
* tmux

### Bash

For bash, it adds:

* Bash, with a configured `.bashrc`
* [Ble.sh](https://github.com/akinomyoga/ble.sh)
* [Starship](https://starship.rs/) prompt

### Zsh

For bash, it adds:

* Zsh, with a configured `.zshrc` and plugins:
  * [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting.git)
  * [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions.git)
  * [zsh-completions](https://github.com/zsh-users/zsh-completions.git)
* [Powerlevel10k](https://github.com/romkatv/powerlevel10k.git) prompt
