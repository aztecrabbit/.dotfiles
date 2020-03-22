"
call plug#begin('~/.local/share/nvim/plugged')

" Plugin
Plug 'scrooloose/nerdtree'                              " explorer
""Plug 'jistr/vim-nerdtree-tabs'                          " explorer tab
Plug 'Xuyuanp/nerdtree-git-plugin'                      " explorer git status
Plug 'airblade/vim-gitgutter'                           " git
Plug 'vim-airline/vim-airline'                          " status bar
""Plug 'Yggdroot/indentLine'                              " indent
""Plug 'nathanaelkane/vim-indent-guides'                  " indent
Plug 'jiangmiao/auto-pairs'                             " unknown
Plug 'neoclide/coc.nvim', {'branch': 'release'}         " autocomplete
Plug 'tpope/vim-commentary'                             " comment
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } } " markdown

" Syntax
Plug 'baskerville/vim-sxhkdrc'

" Themes
Plug 'joshdick/onedark.vim'

" Icons
Plug 'ryanoasis/vim-devicons'

call plug#end()

