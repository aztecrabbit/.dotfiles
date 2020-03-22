"
function! Start()
	if !executable("termux-setup-storage")
		NERDTree
		wincmd p
	endif
endfunction

autocmd VimEnter * call Start()

autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType json setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

