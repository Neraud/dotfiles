# Doc for ZSH options: https://linux.die.net/man/1/zshoptions

# Do not run the global startup files /etc/zprofile, /etc/zshrc, /etc/zlogin and /etc/zlogout
setopt NO_GLOBAL_RCS
# Treat the '#', '~' and '^' characters as part of patterns for filename generation, etc. (An initial unquoted '~' always produces named directory expansion.)
setopt EXTENDED_GLOB

# Hide the prompt after a partial line
# Can be tested with: print -n "this is a test"
# By default, it will print "this is a test%", and setting this to an empty string removes the trailing %
export PROMPT_EOL_MARK=""
