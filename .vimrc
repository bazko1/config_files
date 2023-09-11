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
let mapleader = " "

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
Plug 'lervag/vimtex'
call plug#end()

let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 2
let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing', 'long', 'conflicts' ]
" tabline configurations
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

let g:airline_powerline_fonts = 1

let g:vimtex_compiler_latexmk = {'options' : [
        \   '-verbose',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \   '-shell-escape',
        \ ],}
let g:vimtex_quickfix_ignore_filters = ['Overfull', 'Underfull']
let g:vimtex_grammar_vlty = {'lt_directory': '/home/bazyli/gitworkspace/LanguageTool-6.2-stable'}
set spelllang=pl
set spell

" let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_close_button = 0

" Golang related options
let g:go_auto_type_info = 1
let g:go_def_mapping_enabled = 0

" changing nerdtree root dir is changed vim cwd also
let NERDTreeChDirMode = 2

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

" Use ; as : not to need use shift
noremap ; :
noremap , ;
noremap <Leader>, ,

noremap <Leader>t :NERDTreeToggle<CR>
noremap <Leader>e :GFiles <CR>
noremap <Leader>a :Files <CR>
noremap <Leader>b :Buffers<CR>
noremap <silent> <Leader>l :bn<CR>
noremap <silent> <Leader>h :bp<CR>
noremap <silent> <Leader>s :AirlineToggle<CR>
noremap <silent> <Leader>d :bdelete<CR>

ca tn tabnew
ca th tabp
ca tl tabn

" highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter <buffer> match ExtraWhitespace /\s\+$/
autocmd InsertEnter <buffer> match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave <buffer> match ExtraWhitespace /\s\+$/
autocmd BufWinLeave <buffer> call clearmatches()

function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

command TrimWhiteSpace :call TrimWhiteSpace()

" show whitespaces as dot when in visual mode
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
nmap <silent> gD :split<CR><Plug>(coc-definition)
nmap <silent> gdt :vsplit<CR><Plug>(coc-definition)
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
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
        set showtabline=2
    endif
endfunction
command ToggleHiddenAll :call ToggleHiddenAll()

let g:fzf_action = {
  \ 'ctrl-q': 'wall | bdelete',
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
