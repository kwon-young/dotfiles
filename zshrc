# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 3 numeric
zstyle ':completion:*' substitute 1
zstyle :compinstall filename '/home/kwon-young/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install

# Personal config

export TERM=xterm-256color
# set screen-256color if tmux is running
[ -n "$TMUX" ] && export TERM=screen-256color

# fzf config
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tmux attach or new
tmux_attachornew() {
  if [ -n "$1" ]
  then
    tmux attach -t $1 || tmux new -s $1
  else
    tmux attach || tmux new
  fi
}
alias tm=tmux_attachornew

# End of personal config

source /usr/share/zsh-antigen/antigen.zsh

# Load the oh-my-zsh's library
antigen use oh-my-zsh

antigen bundle <<EOBUNDLES
    # Bundles from the default repo (robbyrussell's oh-my-zsh)
    git

    # Fish-like auto suggestions
    zsh-users/zsh-autosuggestions

    # Extra zsh completions
    zsh-users/zsh-completions

EOBUNDLES

# Load the theme
antigen theme robbyrussell

# Tell antigen that you're done
antigen apply

antigen bundle zsh-users/zsh-syntax-highlighting
