" Full Vim always
set nocompatible
filetype plugin on
syntax on
source $VIMRUNTIME/defaults.vim

" Vimplug
call plug#begin('~/.vim/vimplug')

" editor
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug  'Raimondi/delimitMate'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" netrw options
let g:netrw_banner = 0

" grepprg
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

" --- Theme
set background=dark

" tweak highlight colors
highlight Search     term=reverse ctermfg=0 ctermbg=222 guifg=#000000 guibg=#FFE792

" Cursorline on current buffer
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" leader is space
let g:mapleader = " "

" No more Ex mode
nnoremap <silent> Q <nop>

" clipboard
nnoremap <Leader>y "*y
vnoremap <Leader>y "*y

" fzf
nnoremap <silent> <leader>ff :FZF<CR>
nnoremap <silent> <leader>x :Commands<CR>

" Match term color
if !has('gui_running')
    set t_Co=256
endif

" Case sensitive search iff typed term contains no uppercase
set ignorecase
set smartcase

" Wildmenu
set wildmenu
set wildmode=list:longest,full

" Conveniences for ESC in insert.
inoremap jk 

" Blink instead of Beep
set visualbell
set noerrorbells

" Directions for Split
set splitbelow splitright

" Always show status line
set laststatus=2

" Show line and colnum at cursor position
set ruler

" Command line completion via CTRL+N / CTRL+P
set wildmenu
set wildignore=*.swp,*.bak

" Swap : and ; in normal and visual
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" Split Navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Syntax Highlighting
syntax on
autocmd BufEnter * :syntax sync fromstart
set redrawtime=10000

" Highlight Search / Inc Search
set hls is

" Tab config
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Min lines to keep above and below cursor
set scrolloff=1

" Matchit (default installed)
runtime macros/matchit.vim

" Autoindent
set autoindent
