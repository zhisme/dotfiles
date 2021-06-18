#!/bin/bash

# RUBY/RAILS
alias rs='rails s '
alias rc='rails c '
alias rakedbr="rake db:reset db:migrate "
alias bi="bundle install "
alias b="bundle "
alias bex="bundle exec "
alias skiq='bex sidekiq '


# SSH
alias ssh_root_bulvar='ssh root@185.98.87.220'
alias ssh_bulvar='ssh artbulvar@185.98.87.220'
alias ssh_uga="ssh u0426373@31.31.196.192"
alias ssh_level="ssh deploy@178.128.204.153"
alias ssh_roshal="ssh deploy@104.248.241.143"
alias ssh_zh="ssh zh@142.93.131.30"

#TOOLS
alias copyx="xclip selection-clipboard"
alias pastex="xclip -o -selection clipboard"
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

# GIT
stashgrep() {
  for i in `git stash list | awk -F ':' '{print $1}'`; do
    git stash show -p $i | grep -H --label="$i" "$1"
  done
}
export EDITOR=vim
export VISUAL="$EDITOR"

alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit '
alias gd='git diff '
alias gk='gitk --all&'
alias gx='gitx --all'
alias gcl='git clone '
alias gpl='git pull '
alias gph='git push '
alias gpr='git pull --rebase'
alias ghead="git push origin HEAD "
