# Automatically use menu completion after the second consecutive request for completion
setopt AUTO_MENU

# Do menu-driven completion.
zstyle ':completion:*' menu select

# Color completion for some things.
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
