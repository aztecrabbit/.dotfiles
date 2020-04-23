# Check is in termux
IsInTermux="$(command -v termux-setup-storage)"

source /usr/share/zsh/share/antigen.zsh

antigen use oh-my-zsh

antigen bundle colorize
antigen bundle colored-man-pages
antigen bundle command-not-found
antigen bundle git

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
ZSH_HIGHLIGHT_STYLES[precommand]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=red"

PATH="${PATH}:${HOME}/.scripts"
PATH="${PATH}:${HOME}/go/src/github.com/aztecrabbit/brainfuck-tunnel-go"
PATH="${PATH}:${HOME}/go/src/github.com/aztecrabbit/brainfuck-tunnel-openvpn"
PATH="${PATH}:${HOME}/go/src/github.com/aztecrabbit/brainfuck-tunnel-shadowsocks"
PATH="${PATH}:${HOME}/go/src/github.com/aztecrabbit/brainfuck-psiphon-pro-go"

alias ls='LC_ALL="C" ls --color=auto --group-directories-first'
alias ll='ls -l'
alias lla='ll -a'

alias vim="nvim"
alias yay="/usr/bin/yay --pacman powerpill"

alias stow="stow --verbose --no-folding"
alias aria2c="aria2c --conf-path=/etc/aria2.conf --dir=${HOME}/Downloads/Aria2 --file-allocation=falloc"
alias services="systemctl list-units --type=service --state=running"
alias instagram-scraper="instagram-scraper --retry-forever"

alias dotfiles="cd ~/.dotfiles && git status"
alias dotfiles-private="cd ~/.dotfiles-private && git status"
