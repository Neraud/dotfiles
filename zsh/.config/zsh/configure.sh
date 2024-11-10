# Doc for ZSH options: https://linux.die.net/man/1/zshoptions

ZSH_AUTOSUGGEST_MANUAL_REBIND=1
POWERLEVEL9K_CONFIG_FILE=${ZSH_CONFIG_DIR}/p10k.zsh

##################################################
#                    General                     #
##################################################
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Ignore command lines when the first character on the line is a space
setopt HIST_IGNORE_SPACE

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# bind control + arrows to prev/next words
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word


##################################################
#                   Completion                   #
##################################################
# Automatically use menu completion after the second consecutive request for completion
setopt AUTO_MENU

# Do menu-driven completion.
zstyle ':completion:*' menu select

# [Shift-Tab] - move through the completion menu backwards
bindkey '^[[Z' reverse-menu-complete

# Color completion for some things.
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

