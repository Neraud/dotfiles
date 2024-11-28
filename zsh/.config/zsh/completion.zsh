# Enable the "new" completion system (compsys).
autoload -Uz compinit && compinit -d ${ZSH_CACHE_DIR}/zcompdump

# Load completions
for f (${ZSH_CONFIG_DIR}/completion.d/*.zsh(N)) source $f
