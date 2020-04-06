"
filetype on
filetype plugin indent on

"
set number
set splitbelow
set splitright
set termguicolors
set colorcolumn=100
set tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab smarttab

set list
set listchars=tab:\|\ ,trail:■

set nowrap

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
""set updatetime=300
set statusline^=%{coc#status()}

" emmet
let g:user_emmet_leader_key=','









" " indent
" let g:indentLine_char = '█'
" let g:indentLine_faster = 1
" let g:indentLine_setConceal = 0
" let g:indentLine_conceallevel = 1

" " vim-indent-guides
" let g:indent_guides_auto_colors = 1
" let g:indent_guides_start_level = 2
" let g:indent_guides_enable_on_vim_startup = 1
" let g:indent_guides_guide_size = 1

" " deoplete
" let g:deoplete#enable_at_startup = 1

" " onedark.vim
" let g:onedark_termcolors=16

