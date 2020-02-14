set nocompatible
set nobackup
set nowritebackup
set noswapfile
set showcmd
set number
set incsearch
set laststatus=2
set splitbelow
set splitright
set smartcase
set scrolloff=10
set foldmethod=indent
set foldlevelstart=99
set clipboard=unnamed
set statusline=%f\ %m
set autoindent expandtab tabstop=2 shiftwidth=2
set showtabline=2
set pastetoggle=<F8>
set backspace=indent,eol,start
set maxmempattern=20000 " for big ones
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'ascenator/L9', {'name': 'newL9'}
Plugin 'scrooloose/nerdtree'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-surround'
Plugin 'yous/vim-open-color'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-scripts/vim-auto-save'
Plugin 'tpope/vim-commentary'
Plugin 'vim-scripts/ruby-matchit'
Plugin 'vim-airline/vim-airline'
Plugin 'slim-template/vim-slim'
Plugin 'prettier/vim-prettier'
Plugin 'ngmy/vim-rubocop'
Plugin 'thoughtbot/vim-rspec'
Plugin 'embear/vim-localvimrc'

Plugin 'elixir-editors/vim-elixir'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
Plugin 'pangloss/vim-javascript'
Plugin 'elzr/vim-json'
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'HerringtonDarkholme/yats.vim'

call vundle#end()

filetype plugin indent on
syntax enable
set background=dark
colorscheme open-color

" vim-slim
autocmd BufNewFile,BufRead *.slim setlocal filetype=slim

" Ctrl-p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_show_hidden = 1
let g:ctrlp_tabpage_position = 'l'
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Prettier
let g:prettier#exec_cmd_path = "/Users/zh/.nvm/versions/node/v10.17.0/bin/prettier"

" localvimrc
let g:localvimrc_persistent = 2

" vim-rspec
let g:rspec_command = "!bundle exec rspec {spec}"
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" custom functions
function! StripTrailingWhite()
  let l:winview = winsaveview()
  silent! %s/\s\+$//
  call winrestview(l:winview)
endfunction

augroup custom
  au!
  au BufWritePre * call StripTrailingWhite()
augroup END

" KEYMAP
map <F2>      :NERDTreeToggle<cr>
map <S-Right> :tabn<CR>
map <S-Left>  :tabp<CR>
map <C-a> <esc>ggVG<CR>
nmap <Leader>ra :RuboCop -a<CR>
nmap <Leader>ntf :NERDTreeFind<CR>
nmap <Leader>hl :set hlsearch! hlsearch?<CR>

" Map alt-x keys to jump to a tab (mac-only)
nnoremap ¡ 1gt <CR>
nnoremap ™ 2gt <CR>
nnoremap £ 3gt <CR>
nnoremap ¢ 4gt <CR>
nnoremap ∞ 5gt <CR>
nnoremap § 6gt <CR>
nnoremap ¶ 7gt <CR>
nnoremap • 8gt <CR>
nnoremap ª :tablast <CR>
" alt-9 ta last tab
