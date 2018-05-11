#!/bin/bash

# LOCAL PATHS
alias art='cd ~/dev/prod/motion-projects/art-bulvar/rails-app/'
alias rceapi="cd ~/dev/prod/roomchecking/rc_external_api/"
alias mp="cd ~/dev/prod/motion-projects/"
alias mtapi="cd ~/dev/prod/magtuner/magtuner-api/"
alias mtfr="cd ~/dev/prod/magtuner/magtuner-frontend/"
alias mtad="cd ~/dev/prod/magtuner/magtuner-admin/"
alias mtno="cd ~/dev/prod/magtuner/notifications/"
alias mtco="cd ~/dev/prod/magtuner/cooltext/"
alias orba='cd ~/dev/prod/orbita/orbita-oauth/'
alias smfr='cd ~/dev/prod/smartfield/smartfield-frontend/'
alias smapi='cd ~/dev/prod/smartfield/smartfield-api/'
alias prod='cd ~/dev/prod/'
alias roomc='cd ~/dev/prod/roomchecking/rc_stayplanner_rb/'
alias prem='cd ~/dev/prod/leansquad/goknows.att.premier.api/'
alias port='cd ~/dev/prod/leansquad/goknows.portal/'
alias lean="cd ~/dev/prod/leansquad/"
alias gknche="cd ~/dev/prod/leansquad/goknows.checkout/"
alias gttact="cd ~/dev/prod/leansquad/gtt.activation/"
alias sevleg='cd ~/dev/prod/motion-projects/sevlegprom-sinatra/'
alias mdl='cd ~/dev/prod/sevsu/moodle/'
alias gknapi='cd ~/dev/prod/leansquad/goknows.api/'

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
alias ssh_lean_prod='ssh -i ~/dev/prod/leansquad/private_keys/bluegreenmobile-aws.pem ubuntu@ec2-54-144-25-8.compute-1.amazonaws.com'
alias ssh_premier='ssh ubuntu@52.203.142.140'
alias ssh_mp="ssh deploy@207.154.247.115"
alias uga="ssh u0426373@31.31.196.192"
alias ssh_lean_qa="ssh ubuntu@web01.goknows.com"

# JS
alias emloc='cd ~/dev/prod/magtuner/magtuner-frontend && ember server --environment development-loc'
alias stcool="cd ~/dev/prod/magtuner/cooltext && webpack-dev-server --hot"

#TOOLS
alias copyx="xclip selection-clipboard"
alias pastex="xclip -o -selection clipboard"
alias ptbacksec="cp /Users/zh/dev/prod/leansquad/private_keys/secrets_portal_backup.yml /Users/zh/dev/prod/leansquad/goknows.portal/config/secrets.yml"

# GIT
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
alias ghead="git push origin HEAD "
