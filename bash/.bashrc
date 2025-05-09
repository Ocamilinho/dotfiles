# Alias
## Arquivos de configuração
alias bashrc='lvim ~/.bashrc'
alias cscript='lvim ~/dotfiles/scripts/config.sh'
alias kittyrc='lvim ~/.config/kitty/kitty.conf'

## Navegação
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias cat='batcat'
alias sizet='du -hs'
alias size='du -h'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
mkcd() {
    mkdir -p "$1"
    cd "$1"
}

## Github
alias gs='git status'
alias ga='git add .'
alias gcm='git commit -m'

## Atalhos
alias spt='ncspot'

## Sistema
alias u='sudo apt upgrade'
alias uall='sudo apt update && sudo apt upgrade'
alias i='sudo apt install'
alias r='sudo apt remove'
alias s='sudo apt search'

## Quarto

alias 4p='quarto preview'
alias 4r='quarto render'

## Flatpak
alias fpi='sudo flatpak install'
alias fpr='sudo flatpak remove'
alias fps='sudo flatpak search'
alias fpl='flatpak list'
alias fprn='sudo flatpak run'

export HISTSIZE=5000
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Prompt bonito (se quiser básico)
PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ '

# Git branch no prompt (um pouco mais avançado, se quiser)
parse_git_branch() {
    git branch 2>/dev/null | grep '^*' | colrm 1 2
}

[ -f "/home/ocamilo/.ghcup/env" ] && . "/home/ocamilo/.ghcup/env" # ghcup-env

# PATH
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
