"
function! Start()
	if !executable("termux-setup-storage")
		NERDTreeTabsOpen
		wincmd p
	endif
endfunction

autocmd VimEnter * call Start()

"autocmd FileType go setlocal tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab
autocmd FileType vim setlocal expandtab
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
autocmd FileType markdown setlocal expandtab

autocmd BufRead,BufNewFile *.go.html set filetype=gohtmltmpl
