
nnoremap <S-h> <Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>
nnoremap <S-l> <Cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>

" nmap H ^
" nmap L $

" vmap H ^
" vmap L $

set clipboard=unnamed

set incsearch " Incrementally search while typing
set ignorecase
set smartcase " Use smart case for searching

xnoremap i$ :<C-u> normal! T$vt$<CR>
onoremap i$ :normal vi$<CR>
xnoremap a$ :<C-u> normal!F$vf$<CR>
onoremap a$ :normal va$<CR>

for s:char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '$' ]

  execute 'xnoremap i' . s:char . ' :<C-u>normal! T' . s:char . 'vt' . s:char . '<CR>'
  execute 'onoremap i' . s:char . ' :normal vi' . s:char . '<CR>'
  execute 'xnoremap a' . s:char . ' :<C-u>normal! F' . s:char . 'vf' . s:char . '<CR>'
  execute 'onoremap a' . s:char . ' :normal va' . s:char . '<CR>'
endfor