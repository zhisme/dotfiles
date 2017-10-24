# some github features
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

#ember shortcut
alias em='ember '

#psql annoying command
alias postgre='sudo -u postgres psql'

#alias for postgresql to start
alias postgre_start='sudo /etc/init.d/postgresql start '

#tron game for cli
alias tron='ssh sshtron.zachlatta.com '

#bundle exec is too long
alias bex="bundle exec "

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

#go notifications
alias mtno="cd ~/dev/prod/magtuner/notifications/"

#cd cooltext dir
alias mtco="cd ~/dev/prod/magtuner/cooltext"

#start vpn
alias stvpn="sudo openvpn --config ~/dev/vpn/vpnbook-euro2-udp53.ovpn"

#ctrl-c ctrl-v I love stackoverflow!
alias copyx="xclip selection-clipboard"
alias pastex="xclip -o -selection clipboard"
#update trs keys MT
alias mtkeys='cd ~/dev/prod/magtuner/magtuner-api && bex rake db:trs_update_locales'
#ember local development
alias emloc='cd ~/dev/prod/magtuner/magtuner-frontend && ember server --environment development-loc'

#motion projects
alias ssh_mp="ssh deploy@46.101.16.38"

#smartfield front
alias smfr='cd ~/dev/prod/smartfield/smartfield-frontend/'
#smartfield api
alias smapi='cd ~/dev/prod/smartfield/smartfield-api/'
#start sidekiq
alias skiq='bex sidekiq'
#prod
alias prod='cd ~/dev/prod'

#roomchecking
alias roomc='cd ~/dev/prod/roomchecking/rc_stayplanner_rb/'
