# Configure brew, if it exists
if (( $+commands[brew] )) ; then
    eval "$(brew shellenv)"
fi
