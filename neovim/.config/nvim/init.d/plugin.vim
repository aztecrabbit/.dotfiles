"
call plug#begin('~/.local/share/nvim/plugged')

" Plugin
Plug 'scrooloose/nerdtree'                              " explorer
Plug 'jistr/vim-nerdtree-tabs'                          " explorer tab
Plug 'Xuyuanp/nerdtree-git-plugin'                      " explorer git status
Plug 'airblade/vim-gitgutter'                           " git
Plug 'vim-airline/vim-airline'                          " status bar
Plug 'jiangmiao/auto-pairs'                             " auto bracket
Plug 'mattn/emmet-vim'
Plug 'majutsushi/tagbar'                                " function tree
Plug 'tpope/vim-commentary'                             " comment
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } } " markdown

Plug 'fatih/vim-go' " , { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}         " autocomplete


" Syntax
Plug 'neomake/neomake' " syntax check
Plug 'baskerville/vim-sxhkdrc'


" Themes
Plug 'joshdick/onedark.vim'
Plug 'ryanoasis/vim-devicons'


call plug#end()
