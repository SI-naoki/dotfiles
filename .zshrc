### zhsrc

## alias
# shell command
alias ls='ls -CF'
alias sl='ls -CF'
alias ll='ls -1'
alias lt='ls -1t'
alias la='ls -CFalh'
alias lls='tree -N -L 2'
alias lla='tree -a -h -N -L 2'
alias mv='mv -i'
alias cp='cp -i'
alias whihc='which'
alias rmf='rm `fzf -m`'
alias mkdir='mkdir -p'
alias grep='grep --color=auto'
alias cgrep='grep --color=always'
alias diff='colordiff -u'
alias less='less -NR'
alias vi='nvim -u NONE'
alias vim='nvim'
alias vimv='nvim'
alias vimdiff='nvim -d'
alias taginit='ctags -R -f .tags'
alias wl='wc -l'
alias fzf='fzf-tmux'
# short alias
alias e='nvim'
alias v='nvim'
alias o='open'
alias d='docker'
alias dc='docker-compose'
alias tf='terraform'
alias k='kubectl'
# git shortcut
alias gs='git status'
alias gd='git diff'
alias gl='git log --stat'
alias glo='git log --oneline'
alias glp='git log -p'
alias glm='git log -m --name-status'
alias gb='git branch'
alias gba='git branch -a'
alias gss='(){ if [ -n "${1}" ];then git stash push -u -m $1; else git stash push -u; fi }'
alias gsx='(){ TARGETSTASH=`git stash list|cut -d':' -f1|fzf`; if [ -z ${TARGETSTASH} ];then echo "DROP not done"; else git stash drop ${TARGETSTASH}; unset TARGETSTASH ;fi }'
alias gsl='git stash list'
alias gsd='git diff `git stash list|cut -d':' -f1|fzf`'
alias gsa='(){ TARGETSTASH=`git stash list|cut -d':' -f1|fzf`; if [ -z ${TARGETSTASH} ];then echo "APPLY not done"; else git stash apply ${TARGETSTASH}; unset TARGETSTASH ;fi }'
alias gsr='(){ TARGETSTASH=`git stash list|cut -d':' -f1|fzf`; if [ -z ${TARGETSTASH} ];then echo "APPLY REVESE not done"; else git stash show ${TARGETSTASH} -p|git apply --reverse; unset TARGETSTASH ;fi }'
alias gco='(){ TARGETBRANCH=`git branch|sed "s/ *//g"|fzf`; if [ -n ${TARGETBRANCH} ]; then git checkout $TARGETBRANCH; unset TARGETBRANCH; fi }'
# execute on filetype
alias -s vim='nvim -S'

# miscellenious
alias wcd='cd $WINHOME'

## additional sources
# => zplug
source $HOME/.zplug/init.zsh
zplug "zsh-users/zsh-completions"
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

## external completion source
if [ ! -d "${XDG_CONFIG_HOME}/zsh/completion" ];then
    mkdir -p "${XDG_CONFIG_HOME}/zsh/completion"
fi
# EXPECT: _docker,_docker-compose, _docker-machine, _kubectl
fpath=($XDG_CONFIG_HOME/zsh/completion $fpath)
# fzf
source $XDG_CONFIG_HOME/zsh/fzf/_fzf
source $XDG_CONFIG_HOME/zsh/fzf/_fzf.bindings
# windows
source $XDG_CONFIG_HOME/zsh/windows/_open

## zsh config general
# prompt
autoload -U promptinit
promptinit
PROMPT='%F{green}naoki@thinkpad:%f%~%F{green}$%f'
# completion
autoload -Uz compinit && compinit -i
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
complete -C '/usr/local/bin/aws_completer' aws
