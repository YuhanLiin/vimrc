set nocompatible    "not vi compatible"
filetype plugin on  "file-type based plugin selection
filetype indent on  "file-type based indent
syntax on           "syntax colouring

set number          "line numbers"
set ruler           "bottom right ruler"

set history=500     "Increase command line history"
set autoread        "Reload file when externally changed
set wildmenu        "autocomplete

set smartcase       "Case sensitive search when caps are included
set ignorecase      "Case insensitive without caps
set hlsearch        "Highlight searches
set incsearch       "Search as I type
set showmatch       "Show matching parenthesis

set lazyredraw      "Don't redraw after every macro
set backspace=eol,start,indent  "Backspace works in insert mode

set expandtab       "Tabs are spaces
set smarttab        "Smart tabs
set softtabstop=0
set tabstop=4       "Tab width of 4
set shiftwidth=4    "Indent width 4
set ai              "auto indent
set si              "smart indent
set wrap            "Wrap long lines
set laststatus=2    "Unsaved indicator

"Return to last edited position when opening files"
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

let mapleader=" "
nnoremap <space> <NOP>
"Quicksave"
noremap <leader>w :w!<cr>
"Move lines"
nnoremap <leader>j :m +1!<cr>
nnoremap <leader>k :m -2!<cr>
noremap <leader>h ^
noremap <leader>l $
"Delete word
nnoremap <leader>d diw
"Highlight word
nnoremap <leader>v viw
"Search highlighted text
vnoremap <leader>v y/<c-r>"<cr>
"Fast replace all
nnoremap <leader>s :%s/
"Replace all in selection
vnoremap <leader>s :s/\%V

"Select all C and h files for find/replace
noremap <leader>ac :argadd **/*.c<CR>:argadd **/*.h<CR>
"Select all py files for find replace
noremap <leader>ap :argadd **/*.py<CR>
"Find in all files
nnoremap <leader>? :argdo /
"Replace in all files
nnoremap <leader>S :argdo :%s/

"Disable arrows
noremap <Left> <NOP>
noremap <Right> <NOP>
noremap <Up> <NOP>
noremap <Down> <NOP>

"Remove all trailing whitespace by pressing F3
noremap <F3> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
"Press jj to go to command mode
inoremap jj <ESC>
"Jump to end in insert mode
inoremap <c-a> <ESC>A
"Insert ; at end in insert mode
inoremap <c-A> <ESC>A;

"plug-vim
call plug#begin('~/.vim/plugged')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'danro/rename.vim'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/nerdcommenter'
Plug 'mileszs/ack.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'easymotion/vim-easymotion'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'brookhong/cscope.vim'
Plug 'Valloric/YouCompleteMe'
call plug#end()

"Ctr d for Nerdtree toggle
nnoremap <C-d> :NERDTreeTabsToggle<cr>

"Have ctrl p open new tabs
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }

"Cscope related commands
" s: Find this C symbol
nnoremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>
" silence cscope when saving
let g:cscope_silent=1

" UltiSnips triggering
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
