set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'
Plugin 'rakr/vim-two-firewatch'
Plugin 'simnalamburt/vim-mundo'

" All of your Plugins must be added before the following line
call vundle#end()            " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

filetype plugin indent on    " required
" Enable persistent undo so that undo history persists across vim sessions

" Syntax and color
syntax enable
set background=dark
colors Dim
let g:color_coded_enabled = 1

" Tabbing and indentation
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set backspace=2

" Numbers, lines etc
set number
set cursorline
hi cursorline cterm=NONE ctermbg=239 ctermfg=NONE
"
" Searching
set showmatch
set incsearch
set ignorecase
set smartcase
set hlsearch

" Only redraws when necessary. Speeds up things as scrolling
set lazyredraw

" Start scrolling when < 8 lines left and scroll 1 line each time
set scrolloff=8
set sidescrolloff=15
set sidescroll=1

" Vertical boxes instead of horizontal in tmux
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif


" Starts VIM at same line as last time
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"""""""""""""""""""""""""
" Clang Format:

let mapleader = ','

let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "false",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11",
            \ "BreakBeforeBraces" : "Attach",
            \ "AllowShortBlocksOnASingleLine" : "false",
            \ "AllowShortCaseLabelsOnASingleLine" : "false",
            \ "AllowShortFunctionsOnASingleLine" : "Empty"}

" map to <Leader>f in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>f :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>f :ClangFormat<CR>
""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""
" RustFmt
let g:rustfmt_command = 'rustup run stable rustfmt'
"let g:rustfmt_autosave = 1
autocmd FileType rust nnoremap <buffer><Leader>f :<C-u>RustFmt<CR>
autocmd FileType rust vnoremap <buffer><Leader>f :RustFmt<CR>

set hidden
let g:racer_cmd = '~/.cargo/bin/racer'
let g:racer_experimental_completer = 1

""""""""""""""""""""""""""""""""

" Trailing whitespace highlighting
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Go .h -> .cc and .cc -> .h
map <leader>< :call CurtineIncSw()<CR>

" For .tex files
autocmd FileType tex :NoMatchParen
au FileType tex setlocal nocursorline

""" Prose
function! ProseMode()
  call goyo#execute(0, [])
  "set spell noci nosi noai nolist noshowmode noshowcmd
  set noci nosi noai nolist noshowmode noshowcmd
  set complete+=s
  "set bg=light
  "if !has('gui_running')
  "  let g:solarized_termcolors=256
  "endif
  "colors solarized
endfunction

command! ProseMode call ProseMode()
nmap <Leader>p :ProseMode<CR>

""" NERDtree
" toggle with , + t
nmap <Leader>t :NERDTreeToggle<CR>
"remap nerdtree v-split to , + v instead of s
let NERDTreeMapOpenVSplit='<Leader>v'
let NERDTreeMapPreviewVSplit='<Leader>gv'

" auto enter nerdtree and goes to opened file
function! AutoNerdTree()
    autocmd vimenter * NERDTree
    autocmd vimenter * wincmd l
endfunction
" (un)comment to toggle
" call AutoNerdTree()


" if nerdtree is the only thing left when closing, close vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


""" Mundo (undo tree)
nnoremap <Leader>u :MundoToggle<CR>

set undofile
set undodir=~/.vim/undo


"""""""""""""""""""
" Airline
let g:airline_theme='bubblegum'
"let g:airline_theme='angr'
"let g:airline_theme='zenburn'
"let g:airline_theme='vice'
"let g:airline_theme='hybridline'


"""""""""""""""""""""
" Move through screen lines
nnoremap j gj
nnoremap k gk
" Wrap on window break
set wrap linebreak nolist

set rtp+=~/.fzf
