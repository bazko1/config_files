set number
set backspace=2
set nospell
set tabstop=4
set shiftwidth=4
set expandtab
set nowrap
syntax on

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tomasiser/vim-code-dark'
Plug 'navarasu/onedark.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'vim-airline/vim-airline'
Plug 'kshenoy/vim-signature'
call plug#end()

colorscheme codedark

augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

let mapleader = ","

" Use ; as :
map ; :

noremap <Leader>t :NERDTreeToggle<CR>
nnoremap <Leader>e :GFiles <CR>
nnoremap <Leader>a :Files <CR>
nnoremap <silent> <Leader>s :AirlineToggle<CR>
nnoremap <silent> <Leader>h :tabp<CR>
nnoremap <silent> <Leader>l :tabn<CR>

ca tn tabnew
ca th tabp
ca tl tabn

" highlight trailing whitespaces
autocmd BufWinEnter <buffer> match Error /\s\+$/
autocmd InsertEnter <buffer> match Error /\s\+\%#\@<!$/
autocmd InsertLeave <buffer> match Error /\s\+$/
autocmd BufWinLeave <buffer> call clearmatches()

" show whitespaces as dot when in
set lcs+=space:·

" show whitespaces when in visual mode
au ModeChanged [vV\x16]*:* let &l:list = mode() =~# '^[vV\x16]'
au ModeChanged *:[vV\x16]* let &l:list = mode() =~# '^[vV\x16]'
au WinEnter,WinLeave * let &l:list = mode() =~# '^[vV\x16]'

" associate yaml templates
au! BufNewFile,BufRead *.yaml.tpl set filetype=yaml

" nohl on double esc
nnoremap <silent> <Esc><Esc> :let @/ = ""<CR>
