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

" Enable folding
set foldmethod=indent
set foldlevel=99

" coc.vim
""set updatetime=300
set statusline^=%{coc#status()}

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


" emmet
let g:user_emmet_leader_key=','
