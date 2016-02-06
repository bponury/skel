function! ToggleHighlight()
        if exists("g:column_color")
                exec 'hi HiColorColumn ctermbg=none ctermfg=none'
                unlet g:column_color
        else
                exec 'hi HiColorColumn ctermbg=1 ctermfg=9'
                let g:column_color = 1
        endif
endfunction

map <silent> <C-H> :call ToggleHighlight()<CR>
hi HiColorColumn ctermbg=1 ctermfg=9

augroup vimrc_autocmds
  autocmd VimEnter * let g:column_color = 1
  autocmd VimEnter * hi HiColorColumn ctermbg=1 ctermfg=9
  autocmd BufEnter * match HiColorColumn /\%81v.\|\s\+$\| \+\ze\t|^ \+/
augroup END
