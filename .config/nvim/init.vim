:call mkdir(stdpath('config'), 'p')
:exe 'edit '.stdpath('config').'/init.vim'

set runtimepath^=~/.vim runtimepath+=~/.vim/after
set clipboard+=unnamedplus
let &packpath = &runtimepath
source ~/.vimrc
