## Languages
  * Ruby

    - [Rbenv](https://github.com/rbenv/rbenv)

    `rbenv install 2.6.1`
  * Erlang

    [Download link](https://www.erlang-solutions.com/resources/download.html)
   
  * Elixir

    - [Kiex](https://github.com/taylor/kiex)

    `\curl -sSL https://raw.githubusercontent.com/taylor/kiex/master/install | bash -s`

    `kiex install 1.4.5`

## Utilities
  * [Ag](https://github.com/ggreer/the_silver_searcher)

    Best search speed, used both in vim ctrl-p, and simple search via terminal
    **Usage**
    ```
    ls / | ag 'myname'
    ```

  * [Zsh](https://www.zsh.org)

    Make your terminal fun again (Will be default in new macos Catalina)

    **Quick install**
    ```
    brew install zsh
    # make default shell
    sudo -s 'echo /usr/local/bin/zsh >> /etc/shells' && chsh -s /usr/local/bin/zsh
    ```

  * [Oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

    Many useful packages, browse /plugins

  * [Vundle](https://github.com/VundleVim/Vundle.vim)

    Vim package manager like bundler for ruby

  * [Diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)

    Better git diff with syntax highlight

  * [Bat](https://github.com/sharkdp/bat)

    Better cat command with syntax highlight

  * [iTerm](https://iterm2.com/)

    Replacement for default terminal

  * [Homebrew](https://github.com/Homebrew/install)

    `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

  * [Robo3t](https://robomongo.org/)

## Troubleshooting

  * zsh-syntax-highlightning
  
    If occurs `plugin zsh-syntax-highlighting not found` run the following.

    ```
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    ```
