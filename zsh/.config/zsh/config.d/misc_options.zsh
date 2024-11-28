# Doc for ZSH options: https://linux.die.net/man/1/zshoptions

# Do not run the global startup files /etc/zprofile, /etc/zshrc, /etc/zlogin and /etc/zlogout
setopt NO_GLOBAL_RCS
# Treat the '#', '~' and '^' characters as part of patterns for filename generation, etc. (An initial unquoted '~' always produces named directory expansion.)
setopt EXTENDED_GLOB
