silent !stty -ixon > /dev/null 2>/dev/null
set directory=$HOME/.vim/swap//

filetype on
filetype plugin on
filetype plugin indent on

source ~/.vim/functions.vimrc
source ~/.vim/mappings.vimrc
source ~/.vim/netrw.vimrc

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
set autoindent
set smarttab
set smartindent

" STYLE SETTINGS
set tabstop=8
set softtabstop=8
set shiftwidth=8
set noexpandtab

set showmatch

" SEARCH
set ignorecase
set smartcase
set incsearch
set hlsearch

"hi StatusLine cterm=bold ctermbg=8 ctermfg=2
"hi Comment cterm=none ctermfg=darkred

augroup vimrc_autocmds
	autocmd BufEnter * highlight HighLight ctermbg=235
	autocmd BufEnter * match HighLight /\%80v.*\|\s\+$\| \+\ze\t\|^ \+/
augroup END

if filereadable(glob("~/.vim/local.vimrc"))
	source ~/.vim/local.vimrc
endif
