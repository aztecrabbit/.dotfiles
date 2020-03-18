"
function! Start()
    NERDTree
    wincmd p
endfunction

autocmd VimEnter * call Start()

" Go
""autocmd FileType go setlocal noexpandtab tabstop=2 shiftwidth=2 softtabstop=2

