# ~/.zshrc: executed by Zsh for interactive shells.

# Se estiver em uma sessão TMUX, fonte o próprio .zshrc (equivalente ao comportamento do bashrc)
if [[ -n $TMUX ]]; then
  source ~/.zshrc
fi

# Verifique se o shell é interativo, caso contrário, saia.
[[ $- != *i* ]] && return

# Configuração do histórico
HISTCONTROL=ignoreboth  # Ignora comandos duplicados ou começando com espaço
HISTSIZE=1000           # Quantidade de comandos no histórico
HISTFILESIZE=2000       # Tamanho do arquivo de histórico

# Atualizar tamanho da janela após cada comando
autoload -Uz zsh/zutil
zmodload zsh/parameter
zmodload zsh/terminfo
zmodload zsh/termcap
zshaddhistory() {
  zle reset-prompt
}

# Alias e comandos personalizados
alias ls='eza'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias kittyrc='nvim ~/.config/kitty/kitty.conf'
alias bashrc='nvim ~/.bashrc'
alias tmuxrc='nvim ~/.tmux.conf'
alias nvimrc='nvim ~/.config/nvim/init.lua'

# Suporte a cores no terminal e atalhos para comandos coloridos
if [[ -x /usr/bin/dircolors ]]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# Configurar prompt colorido
autoload -Uz colors && colors
setopt prompt_subst
PS1='%{$fg_bold[green]%}%n@%m%{$reset_color%}:%{$fg_bold[blue]%}%~%{$reset_color%}%# '

# Adicionar notificação para comandos longos
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history | tail -n1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Ativar plugins e outras funcionalidades
# Oh My Zsh (se você usar)
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

