# Check is in termux
IsInTermux="$(command -v termux-setup-storage)"

if [ $IsInTermux ]; then
	clear && source $HOME/.antigen.sh
else
	source /usr/share/zsh/share/antigen.zsh
fi

antigen use oh-my-zsh

antigen bundle colored-man-pages
antigen bundle command-not-found
# antigen bundle cp
# antigen bundle encode64
# antigen bundle git
antigen bundle history
# antigen bundle safe-paste
antigen bundle systemd
# antigen bundle z

antigen bundle b4b4r07/enhancd
# antigen bundle supercrabtree/k
antigen bundle Tarrasch/zsh-autoenv
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting

if [ $IsInTermux ]; then
	antigen theme aztecrabbit/zsh-themes themes/aztecrabbit-termux
else
	antigen theme aztecrabbit/zsh-themes themes/aztecrabbit
fi

antigen apply

typeset -g ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]='fg=white'
ZSH_HIGHLIGHT_STYLES[command]='fg=white'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=white'
ZSH_HIGHLIGHT_STYLES[function]='fg=white'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=red"

declare -A colors
colors["fg-white"]="38;5;255"
colors["fg-dark-gray"]="38;5;250"
colors["fg-dark-gray-disabled"]="38;5;245"

export EXA_COLORS=""
# Owners and Groups
EXA_COLORS="${EXA_COLORS}:uu=${colors["fg-white"]}"
EXA_COLORS="${EXA_COLORS}:gu=${colors["fg-white"]}"
EXA_COLORS="${EXA_COLORS}:un=${colors["fg-dark-gray-disabled"]}"
EXA_COLORS="${EXA_COLORS}:gn=${colors["fg-dark-gray-disabled"]}"
# Permissions
EXA_COLORS="${EXA_COLORS}:ur=${colors["fg-white"]}"
EXA_COLORS="${EXA_COLORS}:uw=${colors["fg-white"]}"
EXA_COLORS="${EXA_COLORS}:ux=${colors["fg-white"]}"
EXA_COLORS="${EXA_COLORS}:ue=${colors["fg-white"]}"
EXA_COLORS="${EXA_COLORS}:gr=${colors["fg-white"]}"
EXA_COLORS="${EXA_COLORS}:gw=${colors["fg-white"]}"
EXA_COLORS="${EXA_COLORS}:gx=${colors["fg-white"]}"
EXA_COLORS="${EXA_COLORS}:tr=${colors["fg-white"]}"
EXA_COLORS="${EXA_COLORS}:tw=${colors["fg-white"]}"
EXA_COLORS="${EXA_COLORS}:tx=${colors["fg-white"]}"
# Details and Metadata
EXA_COLORS="${EXA_COLORS}:da=${colors["fg-white"]}"
# Git
EXA_COLORS="${EXA_COLORS}:gm=38;5;84"
# File Size
EXA_COLORS="${EXA_COLORS}:sn=${colors["fg-white"]}"
EXA_COLORS="${EXA_COLORS}:sb=${colors["fg-dark-gray"]}"

PATH="${PATH}:${HOME}/.scripts"
PATH="${PATH}:${HOME}/go/src/github.com/aztecrabbit/brainfuck-tunnel-go"
PATH="${PATH}:${HOME}/go/src/github.com/aztecrabbit/brainfuck-tunnel-openvpn"
PATH="${PATH}:${HOME}/go/src/github.com/aztecrabbit/brainfuck-tunnel-shadowsocks"
PATH="${PATH}:${HOME}/go/src/github.com/aztecrabbit/brainfuck-psiphon-pro-go"

# alias ls='LC_ALL="C" ls --color=auto --group-directories-first'
# alias ll='ls -l'
# alias lla='ll -a'

alias ls='exa --color=auto --group --group-directories-first --git'
alias ll='ls -l'
alias la='ll -a'
alias lt="ll --tree --level=2"

alias vim="nvim"
alias yay="/usr/bin/yay --pacman powerpill"

alias stow="stow --verbose --no-folding"
alias aria2c="aria2c --conf-path=/etc/aria2.conf --dir=${HOME}/Downloads/Aria2 --file-allocation=falloc"
alias instagram-scraper="instagram-scraper --retry-forever"

alias dotfiles="cd ~/.dotfiles && git status"
alias dotfiles-private="cd ~/.dotfiles-private && git status"

function mega-progress() {
	while true; do
		clear && mega-transfers
		sleep 2
	done
}
