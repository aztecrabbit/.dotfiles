" nerdtree
""nnoremap <silent> <C-k><C-B> :NERDTreeToggle<CR>
noremap <silent> <F12>	    :NERDTreeTabsToggle<CR>
noremap          <F11>	    :TagbarToggle<CR>
noremap <silent> <C-p>      :call CocActionAsync('showSignatureHelp')<CR>i

imap    <silent> <C-p>      <ESC>:call CocActionAsync('showSignatureHelp')<CR>li

