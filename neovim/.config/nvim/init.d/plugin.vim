call plug#begin('~/.local/share/nvim/plugged')

"
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'vim-airline/vim-airline'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Code Jump (Autocomplete (disabled))
""Plug 'davidhalter/jedi-vim'

" Comment
Plug 'tpope/vim-commentary'

" Auto Format (pip install yapf (optional for python))
Plug 'sbdchd/neoformat'

" Code Checker
"" python (pip install pylint or flake8)
Plug 'neomake/neomake'

" Themes
Plug 'joshdick/onedark.vim'
""Plug 'mhartington/oceanic-next'
""Plug 'arcticicestudio/nord-vim'

" Icons
Plug 'ryanoasis/vim-devicons'

call plug#end()

call neomake#configure#automake('nrwi', 500)

