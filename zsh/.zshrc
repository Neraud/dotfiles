# Inspired from zsh-bench "diy+" configuration
# See https://github.com/romkatv/zsh-bench/blob/master/configs/diy%2B/skel/.zshrc

mkdir -p ${ZSH_CACHE_DIR}
mkdir -p ${ZSH_CONFIG_DIR}
POWERLEVEL9K_CONFIG_FILE=${ZSH_CONFIG_DIR}/p10k.zsh

if ! print -rl $fpath | grep -q '/usr/share/zsh/site-functions' ; then
  # Under Debian/Ubuntu, /usr/share/zsh/site-functions isn't included by default in fpath
  # But some APT packages still use it (eg: gh)
  fpath=(/usr/share/zsh/site-functions $fpath)
fi

source ${ZSH_CONFIG_DIR}/install_plugins.zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

for f (${ZSH_CONFIG_DIR}/config.d/*.zsh(N)) source $f
for f (${ZSH_LOCAL_CONFIG_DIR}/config.d/*.zsh(N)) source $f
source ${ZSH_CONFIG_DIR}/load_plugins.zsh
source ${ZSH_CONFIG_DIR}/completion.zsh
