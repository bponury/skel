let g:netrw_liststyle = 3
let g:netrw_list_hide = ".git$,.sass-cache,.jpg$,.png$,.svg$,.o$,.swp$,.swo$,.o.cmd$,.gitignore"

" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
	if exists("t:expl_buf_num")
		let expl_win_num = bufwinnr(t:expl_buf_num)
		if expl_win_num != -1
			let cur_win_nr = winnr()
			exec expl_win_num . 'wincmd w'
			close
			exec cur_win_nr . 'wincmd w'
			unlet t:expl_buf_num
		else
			unlet t:expl_buf_num
		endif
	else
		exec '1wincmd w'
		Vexplore
		exec 'vertical resize 32'
		let t:expl_buf_num = bufnr("%")
	endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>

" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split = 3
let g:netrw_altv = 1


" Change directory to the current buffer when opening files.
"set autochdir

function OpenExplorer()
	if exists("t:expl_buf_num")
	else
		exec '1wincmd w'
		Vexplore
		exec 'vertical resize 32'
		let t:expl_buf_num = bufnr("%")
		exec '2wincmd w'
	endif
endfunction

"autocmd VimEnter * exec OpenExplorer()
autocmd TabEnter * call OpenExplorer()
autocmd TabLeave * exec '2wincmd w'
