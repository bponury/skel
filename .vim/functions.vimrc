function! CloseTabOrVim()
	if tabpagenr('$') > 1
		exec 'tabclose'
	else
		exec 'qa'
	endif
endfunction

