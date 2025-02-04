export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# SSH
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Aliases

alias ls='eza'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias kittyrc='nvim ~/.config/kitty/kitty.conf'
alias bashrc='nvim ~/.bashrc'
alias tmuxrc='nvim ~/.tmux.conf'
alias nvimrc='nvim ~/.config/nvim/init.lua'
alias zshrc='nvim ~/.zshrc'

# STARTSHIP
eval "$(starship init zsh)"
