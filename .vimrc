" .vimrc
" Tyler Mulligan <z@interwebninja.com>
" Last Updated 02/24/2016

set nocompatible        " don't keep vi bugs
filetype off            " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" My Plugins
Plugin 'kien/tabman.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Theme
set background=dark     " assume dark background
set term=xterm-256color " for compatibility with tmux
set t_Co=256            " 256 color support   

syntax enable           " highlighting
"colorscheme railscasts  " railscasts theme
"colorscheme duotone-darkforest
"colorscheme duotone-dark
"colorscheme onedark
colorscheme wolfpack
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='wombat'
set laststatus=2


" Environment Basics
set shortmess+=I        " remove splash
set virtualedit=all     " free roaming cursor
set paste               " sane pasting
set mouse=iv            " auto mouse
set ruler               " show cursor position
set number              " line numbers
"set spell               " spell checker
set history=100         " history
set visualbell          " No beeps

" Tabs
"set autoindent          " in favor of smart
set smartindent         " go with the flow
set tabstop=4           " normal tabs
set smarttab            " smart tabs
set softtabstop=4       " normal tabs
set shiftwidth=4        " normal tabs
set expandtab           " tabs to spaces

" Better Editor
set linebreak           " Break lines at word
set showbreak=+++       " Broken line prefix
set textwidth=100       " Line wrap # of cols
set cursorline          " highlight current line
set showmatch           " braces
set incsearch           " search as you type
set hlsearch
set wrap                " wrap text
set wildmenu            " show commands at the bottom
set wildmode=list:longest,full
set autoread            " reload file when written to externally

" Simplify splitting hotkeys
map <C-H> <C-W>h<C-W>_
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_

" Tab switching ctrl + left/right
map <C-Left> <Esc>:tabprev<CR>
map <C-Right> <Esc>:tabnext<CR>
"nnoremap <C-h> <Esc>:tabprev<CR>
"nnoremap <C-l> <Esc>:tabnext<CR>

" New Tab ctrl + t
nnoremap <C-t> :tabnew<CR>
inoremap <C-t> <Esc>:tabnew<CR>

" Plugin hotkeys
nmap <leader>nt :NERDTreeToggle<cr>

" sudo saver
command W w !sudo tee % > /dev/null

" SuperTab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" Omnomnomnom
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" Tab widths per filetype
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2

" tmux compatibility
if &term =~ '^screen' && exists('$TMUX')
    set mouse+=a
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
    " tmux will send xterm-style keys when xterm-keys is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
    execute "set <xHome>=\e[1;*H"
    execute "set <xEnd>=\e[1;*F"
    execute "set <Insert>=\e[2;*~"
    execute "set <Delete>=\e[3;*~"
    execute "set <PageUp>=\e[5;*~"
    execute "set <PageDown>=\e[6;*~"
    execute "set <xF1>=\e[1;*P"
    execute "set <xF2>=\e[1;*Q"
    execute "set <xF3>=\e[1;*R"
    execute "set <xF4>=\e[1;*S"
    execute "set <F5>=\e[15;*~"
    execute "set <F6>=\e[17;*~"
    execute "set <F7>=\e[18;*~"
    execute "set <F8>=\e[19;*~"
    execute "set <F9>=\e[20;*~"
    execute "set <F10>=\e[21;*~"
    execute "set <F11>=\e[23;*~"
    execute "set <F12>=\e[24;*~"
endif


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
