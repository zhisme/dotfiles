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
set spell
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
Plugin 'ngmy/vim-rubocop'
Plugin 'vim-test/vim-test'
Plugin 'tpope/vim-dispatch'
Plugin 'embear/vim-localvimrc'

Plugin 'elixir-editors/vim-elixir'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
Plugin 'pangloss/vim-javascript'
Plugin 'elzr/vim-json'
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'HerringtonDarkholme/yats.vim'
Plugin 'dense-analysis/ale'

call vundle#end()

filetype plugin indent on
syntax enable
set background=dark
colorscheme open-color

" elixir linter
let g:ale_elixir_elixir_ls_release=expand("~/dev/elixir/elixir-ls/rel")

" ale
let g:ale_linter_aliases = {'jsx': ['css', 'javascript']}
let g:ale_linters = {}
let g:ale_linters.elixir = ['elixir-ls']
let g:ale_fixers = {
 \ 'javascript': ['eslint'],
 \ 'elixir': ['mix_format']
 \ }
let g:ale_set_highlights = 0
" let g:ale_linters_explicit = 1
nmap <Leader>p :ALEFix<CR>
augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
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
" vnoremap p "0p

if has("mac") || has("gui_macvim") || has("gui_mac")
  " copy relative path
  nnoremap <leader>cf :let @*=expand("%")<CR>
  " copy absolute path
  nnoremap <leader>cF :let @*=expand("%:p")<CR>
  " copy filename
  nnoremap <leader>ct :let @*=expand("%:t")<CR>
  " copy directory name
  nnoremap <leader>ch :let @*=expand("%:p:h")<CR>
endif

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
