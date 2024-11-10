# On Ubuntu, plugins are cloned under ~/.zsh/plugins 
ZSH_PLUGINS_DIR=~/.zsh/plugins
mkdir -p ${ZSH_PLUGINS_DIR}

# Clone and compile to wordcode missing plugins.
if [[ ! -e ${ZSH_PLUGINS_DIR}/zsh-syntax-highlighting ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_PLUGINS_DIR}/zsh-syntax-highlighting
fi

if [[ ! -e ${ZSH_PLUGINS_DIR}/zsh-autosuggestions ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_PLUGINS_DIR}/zsh-autosuggestions
fi

if [[ ! -e ${ZSH_PLUGINS_DIR}/zsh-completions ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-completions.git ${ZSH_PLUGINS_DIR}/zsh-completions
fi

if [[ ! -e ${ZSH_PLUGINS_DIR}/powerlevel10k ]]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_PLUGINS_DIR}/powerlevel10k
fi
