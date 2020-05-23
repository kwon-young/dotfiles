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

alias mosh-duz='mosh --server="LD_LIBRARY_PATH=/udd/kchoi/igrida/anaconda2/envs/mosh/lib /udd/kchoi/.local/bin/mosh-server" -- '

# adding .local/bin to path
export PATH="/home/kwon-young/.local/bin:$PATH"

# adding cuda to path
export PATH="/usr/local/cuda/bin:$PATH"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib/"
export CUDA_HOME=/usr/local/cuda
export CUDA_ROOT=$CUDA_HOME

# adding ruby gem to path
export PATH="/home/kwon-young/.gem/ruby/2.6.0/bin:$PATH"

# export LanguageTool path
export PATH="/home/kwon-young/prog/LanguageTool:$PATH"

# cargo binaries (ripgrep)
export PATH="$HOME/.cargo/bin:$PATH"

# cabal binaries (pandoc)
export PATH="$HOME/.cabal/bin:$PATH"

# taskwarrior
if command -v task >/dev/null; then
  alias in='task add +in'
  export PS1='$(task +in +PENDING count) '$PS1
fi

check-ssh-add() {
  if [[ -v DISPLAY ]] && [[ -v SSH_ASKPASS ]]; then
    ssh-add -l &> /dev/null || ssh-add -q < /dev/null
  else
    ssh-add -l &> /dev/null || ssh-add
  fi
}

ssh() {
  check-ssh-add
  /usr/bin/ssh $@
}

alias oarstat='ssh -X kchoi@igrida-oar-frontend oarstat'
alias oarsub='ssh -X kchoi@igrida-oar-frontend oarsub'
alias oardel='ssh -X kchoi@igrida-oar-frontend oardel'

# End of personal config

source $HOME/prog/antigen/antigen.zsh

# Load the oh-my-zsh's library
antigen use oh-my-zsh

antigen bundle git
antigen bundle taskwarrior
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle srijanshetty/zsh-pandoc-completion

# Load the theme
antigen theme robbyrussell

antigen bundle zsh-users/zsh-syntax-highlighting

# Tell antigen that you're done
antigen apply


# fzf config
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)

if command -v rg >/dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!build/*" --glob "!__pycache__/*" --glob "!.mypy_cache/*" --glob "!.cache/*"'
fi
ret_status="%(?:%{$fg[green]%}%{%G⳩%}:%{$fg[red]%}%{%G⳩%})"
PROMPT='${ret_status}%{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}%{%Gγ%}%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}%{$fg[yellow]%}%{%Gᵪ%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}"
