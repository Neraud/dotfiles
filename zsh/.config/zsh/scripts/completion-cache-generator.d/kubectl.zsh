#!/usr/bin/env zsh

if (( $+commands[kubectl] )) ; then
  if [ -f /usr/share/zsh/site-functions/_kubectl ] ; then
    # Arch kubectl package deploys /usr/share/zsh/site-functions/_kubectl by default
    # We don't need to do anything
    echo "/usr/share/zsh/site-functions/_kubectl already exists, nothing to do"
  else
    # Ubuntu doesn't, generate a cache manually
    echo "Generating ${ZSH_USER_FUNCTIONS_DIR}/_kubectl"
    kubectl completion zsh > ${ZSH_USER_FUNCTIONS_DIR}/_kubectl
  fi
fi
