" Vundle
"
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'rust-lang/rust.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
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
"
" /Vundle


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

" Performance gains
"set lazydraw

" Regex
set magic

" Brackets
set showmatch
set mat=2

" Syntax highlighting
syntax enable

try
    colorscheme gruvbox
catch
endtry

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

" Line Numbers (Press Ctrl+n twice to toggle)
nmap <C-N><C-N> :set invnumber<CR>
" Set Line Numbers to initially on
set invnumber

" map control-backspace to delete the previous word
imap <C-BS> <C-W>
