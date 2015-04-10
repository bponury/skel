" PASTE TOGGLE
nmap <F2> :set invpaste paste?<CR>
imap <F2> <ESC>:set invpaste paste?<CR>a
set pastetoggle=<F2>

map <C-G> I#<Esc> <Esc>
map <C-D> x<Esc> <Esc>
nmap <F3> :TagbarToggle<CR>

" MAIN STUFF
nmap <silent> <C-c> :call CloseTabOrVim()<CR>
nmap <C-q> :q<CR>
imap <C-q> <ESC>:q<CR>
nmap <C-s> :w<CR>
imap <C-s> <ESC>:w<CR>a

" QUICK-TAB SWITCHING
nnoremap <C-2> 2gt
nnoremap <C-3> 3gt
nmap <C-4> 4gt
nmap <C-5> 5gt
nmap <C-6> 6gt

" TAB HANDLING
nmap <silent> <A-Up> :tabn<CR>
imap <silent> <A-Up> <ESC>:tabn<CR>

nmap <silent> <A-Down> :tabp<CR>
imap <silent> <A-Down> <ESC>:tabp<CR>

nmap <silent> <A-Left> :wincmd h<CR>
imap <silent> <A-Left> <ESC>:wincmd h<CR>

nmap <silent> <A-Right> :wincmd l<CR>
imap <silent> <A-Right> <ESC>:wincmd l<CR>

" TAGS
nmap <silent> <C-S-Right> g]
nmap <silent> <C-S-Left> :pop<CR>

nnoremap F :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR> 

" NERD COMMENTER
" !!! C-_ == C-/ !!!
nmap <silent> <C-_> <plug>NERDCommenterAlignBoth<CR>
imap <silent> <C-_> <ESC><plug>NERDCommenterAlignBoth<CR>i
vmap <silent> <C-_> <plug>NERDCommenterAlignBoth<CR>

nmap <silent> <C-u> <plug>NERDCommenterUncomment<CR>
imap <silent> <C-u> <ESC><plug>NERDCommenterUncomment<CR>i
vmap <silent> <C-u> <plug>NERDCommenterUncomment<CR>

