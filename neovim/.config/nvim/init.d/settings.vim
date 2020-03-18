"
filetype on
filetype plugin indent on

"
set number
set splitbelow
set splitright
set termguicolors
set colorcolumn=100
set tabstop=4 shiftwidth=4 softtabstop=0 expandtab smarttab

" nerdtree git plugin
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
let g:NERDTreeShowIgnoredStatus = 1

" coc.vim
set statusline^=%{coc#status()}

" vim-indent-guides
let g:indent_guides_auto_colors = 1
let g:indent_guides_start_level = 2
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
""autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=darkgrey   ctermbg=darkgrey
""autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=lightgrey  ctermbg=lightgrey

" gitgutter
""let g:gitgutter_async=0

" deoplete
let g:deoplete#enable_at_startup = 1

"" jedi-vim
""" disable autocompletion, cause we use deoplete for completion
"let g:jedi#completions_enabled = 0
""" open the go-to function in split, not another buffer
"let g:jedi#use_splits_not_buffers = "right"


" neoformat
" enable alignment
let g:neoformat_basic_format_align = 1
"" enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1
"" enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

" neomake
"" python
let g:neomake_python_enabled_makers = ['pylint']

" onedark.vim
""let g:onedark_termcolors=16

