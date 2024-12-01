# Enable the "new" completion system (compsys).
autoload -Uz compinit && compinit -d ${ZSH_CACHE_DIR}/zcompdump
# Enable bashcompinit
autoload -U +X bashcompinit && bashcompinit

# Load completions
for f (${ZSH_CONFIG_DIR}/completion.d/*.zsh(N)) source $f
for f (${ZSH_LOCAL_CONFIG_DIR}/completion.d/*.zsh(N)) source $f
