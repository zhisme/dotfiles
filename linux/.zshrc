export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_emerchantpay_aliases ]; then
  . ~/.bash_emerchantpay_aliases
fi

export PATH="$HOME/.rbenv/bin:$PATH"

eval "$(rbenv init -)"

plugins=(
  git
  nvm
  common-aliases
  z
  zsh-syntax-highlighting
)

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"

source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="$HOME/.cargo/bin:$PATH"

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

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

autoload -U promptinit; promptinit
prompt pure > /dev/null

source $ZSH/oh-my-zsh.sh

source /home/zh/.evm/scripts/evm

if [ -f ~/.local/autostart/ssh_agent.sh ]; then
    . ~/.local/autostart/ssh_agent.sh
fi

export EMAIL="evdev34@gmail.com"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.local/bin:$PATH"
export HISTTIMEFORMAT="%F %T "
export NODE_ENV="development"

# The next line updates PATH for Yandex Cloud CLI.
if [ -f '/home/zh/yandex-cloud/path.bash.inc' ]; then source '/home/zh/yandex-cloud/path.bash.inc'; fi

# The next line enables shell command completion for yc.
if [ -f '/home/zh/yandex-cloud/completion.zsh.inc' ]; then source '/home/zh/yandex-cloud/completion.zsh.inc'; fi
