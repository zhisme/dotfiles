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
set statusline=%f\ %m
set autoindent expandtab tabstop=2 shiftwidth=2
set showtabline=2
set pastetoggle=<F8>
set backspace=indent,eol,start
set maxmempattern=20000 " for big ones
set clipboard+=unnamedplus
set nohlsearch
set title
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
Plugin 'vim-scripts/matchit.zip'
Plugin 'vim-scripts/ruby-matchit'
Plugin 'vim-airline/vim-airline'
Plugin 'slim-template/vim-slim'
Plugin 'ngmy/vim-rubocop'
Plugin 'vim-test/vim-test'
Plugin 'tpope/vim-dispatch'
Plugin 'embear/vim-localvimrc'
Plugin 'lyokha/vim-xkbswitch'

Plugin 'elixir-editors/vim-elixir'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
Plugin 'pangloss/vim-javascript'
Plugin 'elzr/vim-json'
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'HerringtonDarkholme/yats.vim'
Plugin 'dense-analysis/ale'
Plugin 'posva/vim-vue'
Plugin 'rust-lang/rust.vim'

call vundle#end()

filetype plugin indent on
syntax enable
set background=dark
colorscheme open-color

" elixir linter
let g:ale_elixir_elixir_ls_release=expand("~/dev/projects/elixir/elixir-ls/rel")

" ale
let g:ale_linter_aliases = {'jsx': ['css', 'javascript']}
let g:ale_linters = {
  \ 'ruby': ['brakeman', 'rubocop'],
  \ 'eruby': ['erblint'],
  \ 'rust': ['analyzer'],
  \ 'elixir': ['elixir-ls']
  \ }
let g:ale_fixers = {
 \ 'ruby': ['rubocop'],
 \ 'eruby': ['erblint'],
 \ 'javascript': ['eslint'],
 \ 'elixir': ['mix_format'],
 \ 'typescript': ['prettier'],
 \ 'json': ['prettier'],
 \ 'rust': ['rustfmt']
 \ }
let g:ale_set_highlights = 0
" let g:ale_linters_explicit = 1
nmap <Leader>p :ALEFix<CR>
augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.js.erb set filetype=javascript
augroup END

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

" localvimrc
let g:localvimrc_persistent = 2

" vim-test
let test#strategy = "dispatch"
let g:tmux_session = "tests"

map <Leader>s :TestNearest<CR>
map <Leader>t :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
map <Leader>l :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" vim-xkbswitch
let g:XkbSwitchEnabled = 1

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
nmap <Leader>ntf :NERDTreeFind<CR>
nmap <Leader>hl :set hlsearch! hlsearch?<CR>
" vnoremap p "0p

" copy relative path
nnoremap <Leader>cf :let @+=expand("%")<CR>
" copy absolute path
nnoremap <Leader>cF :let @+=expand("%:p")<CR>
" copy filename
nnoremap <Leader>ct :let @+=expand("%:t")<CR>
" copy directory name
nnoremap <Leader>ch :let @+=expand("%:p:h")<CR>
