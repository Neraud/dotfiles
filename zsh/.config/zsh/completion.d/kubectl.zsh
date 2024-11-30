if (( $+commands[kubectl] )) ; then
  # Arch kubectl package deploys /usr/share/zsh/site-functions/_kubectl by default
  # Ubuntu doesn't

  # We check if the _kubectl is already defined to avoid wasting time
  if ! type _kubectl > /dev/null ; then
    source <(kubectl completion zsh)
  fi
fi
