set number
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

set cc=80,100,120
hi ColorColumn ctermbg=lightgrey guibg=lightgrey

nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

call plug#begin(stdpath('data') . '/plugged')

" Plug 'https://github.com/davidhalter/jedi-vim.git'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'yggdroot/indentline'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'easymotion/vim-easymotion'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

