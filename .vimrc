set nocompatible    "not vi compatible"
filetype plugin on  "file-type based plugin selection
filetype indent on  "file-type based indent

"Prevent braces inside parenthesis from being marked as errors
let c_no_curly_error=1

syntax on           "syntax colouring

set nu              "line numbers"
set rnu             "Relative line numbers"
set ruler           "bottom right ruler"
set pastetoggle=<F4>    "Paste mode toggle"
set path=$PWD/**

set history=500     "Increase command line history"
set autoread        "Reload file when externally changed
set wildmenu        "autocomplete

set smartcase       "Case sensitive search when caps are included
set ignorecase      "Case insensitive without caps
set incsearch       "Search as I type
set nohls
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

set laststatus=2    "Unsaved indicator
set hidden          "Open new buffers while current one is unsaved
set cmdheight=2     "Better message display
set signcolumn=yes  "Show signs always
set updatetime=300  "Faster cursorhold
set shortmess+=c    "No ins-completion-menu messages

set undodir=~/.vimdid   "Persistent undo history
set undofile

set foldmethod=syntax
set foldlevel=99

"Return to last edited position when opening files"
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

let mapleader=" "
noremap <space> <NOP>
"Quicksave"
noremap <leader>w :w!<cr>
"Move to front/back of line
noremap <leader>hh ^
noremap <leader>ll $
"Search highlighted text
xnoremap <leader>v y/<c-r>"<cr>
"Replace instances of currently searched word
nnoremap <leader>s :%s/<c-r>//
"Replace all in selection
xnoremap <leader>s :s/\%V
"Search for yanked word
nnoremap <leader>/ /<c-r>"<cr>

"Switch buffers
nnoremap <leader>b :ls<cr>:b<space>
"Go to last buffer
nnoremap <leader>o :b#<cr>
"Go to last edited buffer
nnoremap <BS> <C-^>

"Disable arrows except for scrolling floating windows
noremap <expr> <Down> coc#float#has_scroll() ? coc#float#scroll(1) : '\<NOP>'
noremap <expr> <Up> coc#float#has_scroll() ? coc#float#scroll(0) : '\<NOP>'
noremap <Left> <NOP>
noremap <Right> <NOP>

"Remove all trailing whitespace by pressing F3
noremap <F3> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
"Press jj to go to command mode
inoremap jj <ESC>
snoremap jj <ESC>
"Jump to end in insert mode
inoremap <c-a> <ESC>A
"Insert ; at end in insert mode
inoremap <c-s> <ESC>A;

if has('nvim')
    tnoremap jj <C-\><C-n>
end

"Termdebug
packadd termdebug
let g:termdebug_wide = 1
let termdebugger = "rust-gdb" "For debugging Rust specifically
nnoremap <leader><leader>h :Continue<CR>
nnoremap <leader><leader>j :Step<CR>
nnoremap <leader><leader>k :Over<CR>
nnoremap <leader><leader>l :Finish<CR>
nnoremap <leader><leader>b :Break<CR>
nnoremap <leader><leader>n :Clear<CR>

"plug-vim
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'danro/rename.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-rooter'

Plug 'tomlion/vim-solidity'
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'rust-lang/rust.vim'
Plug 'othree/html5.vim'
Plug 'petRUShka/vim-opencl'
call plug#end()

"FZF triggers
noremap <C-p> :Files<cr>
noremap <leader><C-p> :GFiles<cr>

"Sneak mappings for f and t
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

"rooter patterns
let g:rooter_patterns = ['.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'Cargo.toml']

"Rust plugin options
let g:rustfmt_autosave = 1
let g:rust_keep_autopairs_default = 1
"let g:rust_cargo_check_tests = 1
"let g:rust_cargo_check_benches = 1

"Coc settings
"Autocomplete automatically
inoremap <silent><expr> <TAB>
	  \ pumvisible() ? "\<C-n>" :
	  \ <SID>check_back_space() ? "\<TAB>" :
	  \ coc#refresh()

let g:coc_snippet_next = '<tab>'
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
				\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>r <Plug>(coc-rename)
nmap <silent> <leader>k <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>j <Plug>(coc-diagnostic-next)
nmap <leader>q <Plug>(coc-fix-current)
nmap <leader>a <Plug>(coc-codeaction-cursor)
xmap <leader>a <Plug>(coc-codeaction-selected)

nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
nmap <silent> <C-a> <Plug>(coc-range-select-backward)
xmap <silent> <C-a> <Plug>(coc-range-select-backward)

xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Find symbol of current document
nnoremap <silent> <leader><leader>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <leader><leader>s  :<C-u>CocList -I symbols<cr>
" Diagnostics
nnoremap <silent> <leader><leader>d  :<C-u>CocList diagnostics<cr>
" Refactor
nmap <leader><leader>f <Plug>(coc-refactor)
" Smart replace
nnoremap <silent> <leader><leader>r :<C-u>CocCommand rust-analyzer.ssr<cr>
