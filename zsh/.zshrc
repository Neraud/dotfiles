# Inspired from zsh-bench "diy+" configuration
# See https://github.com/romkatv/zsh-bench/blob/master/configs/diy%2B/skel/.zshrc

ZSH_PLUGINS_DIR=~/.zsh/plugins
mkdir -p ${ZSH_PLUGINS_DIR}
ZSH_CACHE_DIR=${XDG_CACHE_HOME:-$HOME/.cache}/zsh
mkdir -p ${ZSH_CACHE_DIR}
ZSH_CONFIG_DIR=${XDG_CONFIG_HOME:-$HOME/.config}/zsh
mkdir -p ${ZSH_CONFIG_DIR}

source ${ZSH_CONFIG_DIR}/install_plugins.sh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ${ZSH_CONFIG_DIR}/bindings.sh
source ${ZSH_CONFIG_DIR}/configure.sh
source ${ZSH_CONFIG_DIR}/load_plugins.sh
source ${ZSH_CONFIG_DIR}/completion.sh
