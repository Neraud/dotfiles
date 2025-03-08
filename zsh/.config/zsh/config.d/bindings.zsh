# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

##################################################
#                  Key bindings                  #
##################################################
# Mostly copied from https://wiki.archlinux.org/title/Zsh#Key_bindings

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

# See key mapping: 
# https://man.archlinux.org/man/user_caps.5
# https://github.com/mirror/ncurses/blob/master/include/Caps-ncurses
#(or https://github.com/charmbracelet/bubbletea/blob/master/terminfo.go for a complete mapping example)
key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Up]="${terminfo[kUP5]}"
key[Control-Down]="${terminfo[kDN5]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

# Standard widgets:
# https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi


##################################################
#      Shift, Alt, Ctrl and Meta modifiers       #
##################################################
# See https://wiki.archlinux.org/title/Zsh#Shift,_Alt,_Ctrl_and_Meta_modifiers

# bind control + arrows to prev/next words
[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word


##################################################
#                Custom bindings                 #
##################################################

# Control-Up/Down to navigate history, even for multiline commands
[[ -n "${key[Control-Up]}"   ]] && bindkey -- "${key[Control-Up]}"   up-history
[[ -n "${key[Control-Down]}" ]] && bindkey -- "${key[Control-Down]}" down-history

##################################################
#                      sesh                      #
##################################################
function sesh-sessions() {
    exec </dev/tty
    exec <&1
    local session
    #session=$(sesh list | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
	session=$(sesh list --icons | fzf --height 40% --reverse \
		--ansi --border-label ' sesh ' --border --prompt '⚡  ' \
		--header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^y yazi' \
		--bind 'tab:down,btab:up' \
		--bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
		--bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
		--bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
		--bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
		--bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
		--bind 'ctrl-y:become(yazi --chooser-file=/dev/stdout {2..})' \
		--preview-window 'right:45%' \
		--preview 'sesh preview {}' \
	)
	zle reset-prompt > /dev/null 2>&1 || true
    [[ -z "$session" ]] && return
    sesh connect $session
}

zle     -N    sesh-sessions
bindkey '\es' sesh-sessions
