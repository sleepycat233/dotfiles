" todo clipboard
set clipboard=unnamed

" Incrementally search while typing
set incsearch
set ignorecase
" Use smart case for searching
set smartcase

let mapleader = ','

" the enviornment variable $MYVIMRC need to be set to be the path to `init.vim` in the OS
map <silent> <leader>r :source $MYVIMRC<cr>
nmap <leader>q :wq<cr>

map <leader>' ysiw'
map <leader>" ysiw"

nnoremap <S-h> <Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>
nnoremap <S-l> <Cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>

" extensions
" download plug.vim using powershell if it is not found from the following directory
if empty(glob('~/AppData/Local/nvim/autoload/plug.vim'))
  silent !powershell -Command "Invoke-WebRequest -UseBasicParsing -Uri 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' -OutFile '~/AppData/Local/nvim/autoload/plug.vim'"
  autocmd VimEnter * PlugInstall
endif

call plug#begin(stdpath('config') . '/plugged')
  " Plug 'unblevable/quick-scope'
  Plug 'ggandor/lightspeed.nvim'
  Plug 'tpope/vim-repeat'
  Plug 'machakann/vim-sandwich'
call plug#end()

" quick-scope
" let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
" highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline

" vim-sandwich
runtime macros/sandwich/keymap/surround.vim

highlight OperatorSandwichBuns guifg='#aa91a0' gui=underline ctermfg=172 cterm=underline
highlight OperatorSandwichChange guifg='#edc41f' gui=underline ctermfg='yellow' cterm=underline
highlight OperatorSandwichAdd guibg='#b1fa87' gui=none ctermbg='green' cterm=none
highlight OperatorSandwichDelete guibg='#cf5963' gui=none ctermbg='red' cterm=none

xmap iss <Plug>(textobj-sandwich-auto-i)
xmap ass <Plug>(textobj-sandwich-auto-a)
omap iss <Plug>(textobj-sandwich-auto-i)
omap ass <Plug>(textobj-sandwich-auto-a)

" lightspeed
" plece this line after runtime macros/sandwich..., it overwrites the `S` for lightspeed over sandwich in viusal mode
xmap S <Plug>Lightspeed_S

nnoremap <silent> <Space> <Cmd>call VSCodeNotify('whichkey.show')<CR>

" cursor fix in jupyter notebook
autocmd BufEnter *.ipynb#* if mode() == 'n' | call feedkeys("a\<C-c>")