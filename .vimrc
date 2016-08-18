" Set history by number of lines
set history=500

" Enable Filetype plugins
filetype plugin on
filetype indent on

set autoread

" Vertical jump with 'j' and 'k'
set so=7

" Always show current position
set ruler

" Configure Backspace
set backspace=eol,start,indent

" For search
set ignorecase
set smartcase
set hlsearch
set incsearch

" Regex
set magic

" Brackets
set showmatch
set mat=2

" Syntax highlighting
syntax enable

" Statusline
set laststatus=2
let g:airline_powerline_fonts=1

 " Enable advanced operator highlighting
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

set encoding=utf8

" Tabbing and indents
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

" Windows
set splitright

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" Line Numbers (Press Ctrl+n twice to toggle)
nmap <C-N><C-N> :set invnumber<CR>
" Set Line Numbers to initially on
set invnumber

" map control-backspace to delete the previous word
imap <C-BS> <C-W>
