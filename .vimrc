set nocompatible       " don't keep vi bugs
set noautoindent       " in favor of smart
set smartindent        " go with the flow
set showmatch          " braces
set ruler              " show cursor position
set number             " line numbers
set incsearch          " search as you type
set virtualedit=all    " free roaming cursor
set tabstop=4          " normal tabs
set shiftwidth=4       " same
set expandtab          " tabs to spaces
set paste              " sane pasting
set mouse=a            " auto mouse
set shortmess+=I       " remove splash
set background=dark    " assume dark background
set t_Co=256           " 256 color support   
syntax enable          " hightlighing
colorscheme railscasts " railscasts theme
map <C-J> <C-W>j<C-W>_ " simplify splitting hotkeys
map <C-K> <C-W>k<C-W>_ "

let g:user_zen_leader_key = '<c-e>'
let g:user_zen_settings = {
\  'php' : {
\    'extends' : 'html',
\    'filters' : 'c',
\  },
\  'xml' : {
\    'extends' : 'html',
\  },
\  'haml' : {
\    'extends' : 'html',
\  },
\}
