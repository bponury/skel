set t_ut=
set term=xterm-256color
silent !stty -ixon > /dev/null 2>/dev/null
set directory=$HOME/.vim/swap//
set mouse=n
set mouse=v

filetype on
filetype plugin on
filetype plugin indent on

source ~/.vim/functions.vimrc
source ~/.vim/mappings.vimrc
source ~/.vim/netrw.vimrc
source ~/.vim/highlight_80c.vimrc

let NERDCustomDelimiters = {
	\ 'c': { 'left': '//', 'leftAlt': '/*','rightAlt': '*/'}
\}
source ~/.vim/NERD_commenter.vim

colorscheme wombat256
set t_Co=256

set nocompatible

autocmd BufEnter * let &titlestring = hostname() . "[vim(" . expand("%:t") . ")]"
set showmode
set number
set laststatus=2
set statusline=#==\ %F%m%r%h%w%=%([%c%V]\ %l/%L\ %P%)\ ==#
set comments=sl:/*,mb:\ *,elx:\ */
set formatoptions+=r

syntax on
set backspace=2
"set autoindent
set smarttab
set smartindent

" STYLE SETTINGS
set tabstop=4
set softtabstop=8
set shiftwidth=4
set noexpandtab

set showmatch

" SEARCH
set ignorecase
set smartcase
set incsearch
set hlsearch

" alternative comment color
"hi Comment cterm=none ctermfg=88

" FILE BASED INDENTATION
au FileType python set softtabstop=8 tabstop=4 shiftwidth=4 noexpandtab

if filereadable(glob("~/.vim/local.vimrc"))
	source ~/.vim/local.vimrc
endif
