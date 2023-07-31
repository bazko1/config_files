set number
set backspace=2
set nospell
set tabstop=4
set shiftwidth=4
set expandtab
set nowrap
" make copy into * clipboard by default
set clipboard=unnamedplus
syntax on
let mapleader = ','

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tomasiser/vim-code-dark'
Plug 'navarasu/onedark.nvim'
Plug 'rakr/vim-two-firewatch'
Plug 'rakr/vim-one'
Plug 'endel/vim-github-colorscheme'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'vim-airline/vim-airline'
Plug 'kshenoy/vim-signature'
Plug 'numToStr/Comment.nvim'
Plug 'folke/zen-mode.nvim'
call plug#end()

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

"colorscheme codedark
colorscheme one
set background=light

lua require('Comment').setup()
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Use ; as :
map ; :

noremap <Leader>t :NERDTreeToggle<CR>
nnoremap <Leader>e :GFiles <CR>
nnoremap <Leader>a :Files <CR>
nnoremap <Leader>h :History<CR>
nnoremap <silent> <Leader>s :AirlineToggle<CR>

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

" coc configurations
" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" hide all status bar related stuff
let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
        set showtabline=0
        windo set nonumber
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
        set showtabline=2
        windo set number
    endif
endfunction

command ToggleHiddenAll :call ToggleHiddenAll()

