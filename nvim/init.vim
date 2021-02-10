" @file   NeoVim init.vim
"
" @author LeRoy Gary <leroyisgreat@gmail.com>
" @date   27.08.2019
"
" Configuration for NeoVim, built from an old vimrc.
" TODO: Reduce number of groupings, make this more sensible.

" Include checks for file existence before sourcing.
function Include(src)
  if !empty(glob(a:src))
    exec "source " . a:src
  endif
endfunction

" {{{ INSTALLATION
" Plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" }}}

" {{{ HISTORY
set history=500

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" }}}

" {{{ PLUGINS
" {{{ Plug
call plug#begin('~/.config/nvim/plugged')
Plug 'edkolev/tmuxline.vim'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()
" }}}

" {{{ Tmuxline
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#W',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'z'    : '#H' }
" }}}

filetype plugin on
filetype indent on

set autoread
" }}}

" {{{ MOVEMENT
" Vertical jump with 'j' and 'k'
set so=7
" Allow mouse scrolling in RXVT-Unicode. Literally enables mouse in Normal,
" Visual, Insert, and Command-line mode.
" Note: this also prevents mouse selection from selecting the Line Numbers or
" through splits. Preventing mouse in visual mode could be useful.
set mouse=a
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
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'minimalist'
let g:tmuxline_powerline_separators = 1

" Always show current position
set ruler
" }}}

" {{{ COLORING
colorscheme gruvbox
set background=dark

" for Tmux
set t_Co=256
set colorcolumn=80
" }}}

" {{{ FORMATTING
set encoding=utf8

" use » to mark Tabs and ° to mark trailing whitespace. This is a
" non-obtrusive way to mark these special characters.
set list listchars=tab:»\ ,trail:°
" }}}

" {{{ FOLDING
set fdm=marker
" }}}

" {{{ TABBING & INDENTS
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set lbr
set textwidth=80
set ai
set si
set wrap
set cinoptions=l1
" }}}

" {{{ WINDOWS
set splitright
" }}}

" {{{ LINE NUMBERS
"
" Allows a user to press (Ctrl+N, Ctrl+N) to toggle relative or absolute line
" numbers. Useful on some commands.
function! NumberToggle()
  if(&relativenumber == 1)
    set nu
    set rnu!
  else
    set rnu
    set nu!
  endif
endfunc

nnoremap <C-N><C-N> :call NumberToggle()<CR>
"nnoremap <C-N><C-N> :set rnu!<CR>:set nu!<CR>
" Set Line Numbers to initially on
set nu
" }}}

" {{{ MAPPINGS
" map control-backspace to delete the previous word
imap <C-BS> <C-W>
map <ESC>[1;5D <C-Left>
map <ESC>[1;5C <C-Right>

" trim whitespace before write
:ca trim %s/\s\+$//e
" }}}

" Currently that config requires Python support and I don't know what to do :(
"call Include("$XDG_CONFIG_HOME/work/work.nvim")
