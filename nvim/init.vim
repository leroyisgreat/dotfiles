" @file   NeoVim init.vim
"
" @author Set Gary <leroyisgreat@gmail.com>
" @date   27.08.2019
"
" Configuration for NeoVim, built from an old vimrc.

" Include checks for file existence before sourcing.
function Include(src)
  if !empty(glob(a:src))
    exec "source " . a:src
  endif
endfunction

" {{{ History
set history=500

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" }}}

" {{{ Plugins
" {{{ Plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'edkolev/tmuxline.vim'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-syntastic/syntastic'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
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

" Vim LSP {{{
" Send async completion requests.
" WARNING: Might interfere with other completion plugins.
let g:lsp_async_completion = 1
" Enable UI for diagnostics
let g:lsp_signs_enabled = 1           " enable diagnostics signs in the gutter
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
" Automatically show completion options
let g:asyncomplete_auto_popup = 1
" }}}

" Asyncomplete {{{
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'allowlist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))
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

set fdm=marker    " Fold on triple-brace
set splitright    " Split to the right by default

" {{{ Line Numbers
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

" {{{ Keyboard Mapping

" map control-backspace to delete the previous word
imap <C-BS> <C-W>
map <ESC>[1;5D <C-Left>
map <ESC>[1;5C <C-Right>

" trim whitespace before write
:ca trim %s/\s\+$//e

" Search selected text
vnoremap <C-f> "hy/<C-r>h/

" Replace selected text
vnoremap <C-g> "hy:%s/<C-r>h//gc<left><left><left>

" LSP/Async Autocomplete
" gd in Normal mode triggers gotodefinition
nnoremap gd   :LspDefinition<CR>
" F4 in Normal mode shows all references
nnoremap <F4> :LspReferences<CR>
" Tab Completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
" }}}

" File explorer {{{
" Open with :Vex
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 25
" }}}

"call Include("$XDG_CONFIG_HOME/work/work.nvim")
