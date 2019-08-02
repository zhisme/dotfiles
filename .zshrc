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
export PATH="/opt/local/bin:$PATH" # override system vim

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

eval "$(rbenv init -)"
test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"

