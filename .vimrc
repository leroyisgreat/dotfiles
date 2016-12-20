" {{{ HISTORY
set history=500
" }}}

" {{{ PLUGINS 
filetype plugin on
filetype indent on

set autoread
" }}}

" {{{ MOVEMENT
" Vertical jump with 'j' and 'k'
set so=7
" }}}

" {{{ BACKSPACE
set backspace=eol,start,indent
" }}}

" {{{ SEARCH
set ignorecase
set smartcase
set hlsearch
set incsearch
" }}}

" {{{ REGEX
set magic
" }}}

" {{{ BRACKETS
set showmatch
set mat=2
" }}}

" {{{ SYNTAX HIGHLIGHTING
syntax enable
" }}}

" {{{ STATUSLINE
" always show Powerline/Airline
set laststatus=2
" show angled brackets correctly
let g:airline_powerline_fonts=1

" Always show current position
set ruler
" }}}

" {{{ COLORING
autocmd! FileType c,cpp,java,php call CSyntaxAfter()

try
    colorscheme gruvbox
catch
endtry

" if strftime("%H") < 20
"   set background=light
" else
"   set background=dark
" endif
set background=dark
" }}}

" {{{ FORMATTING
set encoding=utf8
" }}}

" {{{ FOLDING
set fdm=marker
" }}}

" {{{ TABBING & INDENTS
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

set lbr
set tw=120

set ai
set si
set wrap

set cinoptions=l1

" }}}

" {{{ WINDOWS
set splitright
" }}}

" {{{ LINE NUMBERS
    " Toggle Line Number View (Press Ctrl+n twice to toggle)
    nmap <C-N><C-N> :set invnumber<CR>
    " Set Line Numbers to initially on
    set rnu
    set number
" }}}

" {{{ MAPPINGS
" map control-backspace to delete the previous word
imap <C-BS> <C-W>
map <ESC>[1;5D <C-Left>
map <ESC>[1;5C <C-Right>
" }}}

" {{{ ???
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
" }}}
