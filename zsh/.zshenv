ZSH_CONFIG_DIR=${XDG_CONFIG_HOME:-$HOME/.config}/zsh
ZSH_LOCAL_CONFIG_DIR=${XDG_CONFIG_HOME:-$HOME/.config}/zsh.local
ZSH_CACHE_DIR=${XDG_CACHE_HOME:-$HOME/.cache}/zsh

for f (${ZSH_CONFIG_DIR}/env.d/*.zsh(N)) source $f
for f (${ZSH_LOCAL_CONFIG_DIR}/env.d/*.zsh(N)) source $f
