export ZSH="/Users/zh/.oh-my-zsh"

ZSH_THEME="geoffgarside"

plugins=(
  git
  osx
  nvm
  common-aliases
  z
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User export
export PATH="$HOME/bin:$PATH" # use Users/home/zh/bin to execute user scripts
export PATH="$HOME/.rbenv/bin:$PATH" # rbenv
# export PATH="/opt/local/bin:$PATH" # override system vim

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

eval "$(rbenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

export PATH="/Users/zh/.erlangInstaller/23.0.2/bin:$PATH"
# export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
source /Users/zh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"


# nvm
#
# # place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

autoload -U promptinit; promptinit
prompt pure
