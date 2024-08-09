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

" cursor fix in jupyter notebook
autocmd BufEnter *.ipynb#* if mode() == 'n' | call feedkeys("a\<C-c>")