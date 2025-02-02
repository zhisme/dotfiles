# ruby/rails
alias rs='rails s '
alias rc='rails c '
alias rakedbr="rake db:reset db:migrate "
alias bi="bundle install "
alias b="bundle "
alias bex="bundle exec "
alias skiq='bex sidekiq '

# SSH servers
alias ssh_zh="ssh zh@165.22.80.158"

# git
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

# kubectl
krest () {
  k rollout restart deployments/$1
}

ksh () {
  k exec -ti $1 -- '/bin/sh'
}

krc () {
  k exec -ti $1 -- bundle exec rails c
}

kedit () {
  rm -f "raw.json"
  rm -f "res.json"
  rm -f "decoded.yml"
  kubectl get secrets $1-credentials -o json > raw.json
  cat raw.json | jq -r ".data[\"$2.yml\"]" | base64 -d > decoded.yml
  vim decoded.yml
  test $? -eq 0 || (echo "aborting..." && exit)

  cat raw.json | jq -r ".data[\"$2.yml\"] |= \$a" --arg a `base64 -b 0 -i decoded.yml` > res.json
  kubectl apply -f res.json
  rm -f "raw.json"
  rm -f "res.json"
  rm -f "decoded.yml"
}
alias ycs3_kstg='aws s3 --endpoint-url=https://storage.yandexcloud.net --profile kadry-stg'
alias ycs3_kprod='aws s3 --endpoint-url=https://storage.yandexcloud.net --profile kadry-prod'

# neovim
alias vim="nvim" # im used to run vim filename

