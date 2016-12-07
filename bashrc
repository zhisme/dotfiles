# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

export NVM_DIR="/home/zh/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

#switch network
alias swnet="nmcli nm enable "
#remote 
alias eshop='ssh ez@188.166.46.9 -p 1042'
#ruby things
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

#Ruby fast test command
alias ruby_test='bundle exec rake test'

#some github features
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit '
alias gd='git diff '
alias go='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'
alias gcl='git clone '
alias gpl='git pull '
alias gph='git push '
alias swhous='cd /var/www/sweethouse.loc/ '

#psql annoying command
alias postgre='sudo -u postgres psql'

#alias cd to rubyboost
alias rubyboost='cd ~/ruby_projects/rubyboost_zhdanov '

#alias for postgresql to start
alias postgre_start='sudo /etc/init.d/postgresql start '

#alias for clear the screen
alias cr='clear '

#alias for ember tutorial directory
alias ember_q='cd ~/ember_projects/super-rentals '

#tron game for cli 
alias tron='ssh sshtron.zachlatta.com '

#fl.ru sweethouse_project production server
alias sweethouse_production='ssh stroi66@5.135.111.135'

export NVM_DIR="/home/zh/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

#bundle exec is too long
alias bex="bundle exec "

#start ember server and proxy it to rails
alias embrai="ember s --proxy http://localhost:3000 "

#alias push to head instantly
alias ghead="git push origin HEAD "

#magtuner api rails
alias mtapi="cd ~/dev/prod/magtuner/magtuner-api "

#maguner ember front
alias mtfr="cd ~/dev/prod/magtuner/magtuner-frontend "

#magtuner ember admin
alias mtad="cd ~/dev/prod/magtuner/magtuner-admin "

#executable old versions rails
alias rbin="./bin/rake"

#start ember server
alias stember="mtfr && ember s"

#start ember server admin
alias stemberad="mtad && ember s --port 4300"

#start rails server
alias strails="mtapi && rails s"

#start vpn
alias stvpn="sudo openvpn --config ~/dev/vpn/vpnbook-euro1-udp53.ovpn"

#start cooltext
alias stcool="cd ~/dev/prod/magtuner/cooltext && webpack-dev-server --hot"

#ctrl-c ctrl-v I love stackoverflow!
alias copyx="xclip selection-clipboard"
alias pastex="xclip -o -selection clipboard"

#start api && cooltext && front
alias startprod='~/dev/bash/start_servers.sh'

#setup UI environment for dev
alias start_mt='~/dev/bash/switch_workspaces.sh'

#smartfield front
alias smfr='cd ~/dev/prod/smartfield/smartfield-frontend/'

#smartfield api
alias smapi='cd ~/dev/prod/smartfield/smartfield-api/'


eval "$BASH_POST_RC"
