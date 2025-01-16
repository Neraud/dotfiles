if [[ -o interactive ]]; then
    if (( $+commands[fastfetch] )) ; then
        fastfetch --pipe false
    fi
fi
