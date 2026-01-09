# Load plugins.
source ${ZSH_PLUGINS_DIR}/zsh-syntax-highlighting-catppuccin/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh
source ${ZSH_PLUGINS_DIR}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ${ZSH_PLUGINS_DIR}/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${ZSH_PLUGINS_DIR}/zsh-completions/zsh-completions.plugin.zsh
source ${ZSH_PLUGINS_DIR}/powerlevel10k/powerlevel10k.zsh-theme
source ${POWERLEVEL9K_CONFIG_FILE}

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Set up zoxide, replace the cd command
eval "$(zoxide init zsh --cmd cd)"
