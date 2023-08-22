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

let mapleader = ","

" Use ; as :
map ; :

noremap <Leader>t :NERDTreeToggle<CR>
nnoremap <Leader>e :GFiles <CR>
nnoremap <Leader>a :Files <CR>
nnoremap <silent> <Leader>h :History<CR>
nnoremap <silent> <Leader>s :AirlineToggle<CR>


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
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction

command ToggleHiddenAll :call ToggleHiddenAll()

