
" How much history to remember
set history=1000

" Make decisions based on filetype
filetype plugin on
"filetype indent on

" Read when a file is changed outside
set autoread

" Show thecurrent position
set ruler
set number
" Height of the commad bar
set cmdheight=1
" And add a status line
set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ %l:%c

" Backspace done properly
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Remove alarms
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Enable syntax highlighting
syntax enable
colorscheme desert

" Unicode FTW!
set encoding=utf8
" Unix FTW!
set ffs=unix,dos,mac

" You are using version control?
set nobackup
set nowb
set noswapfile

" Indentation
set expandtab
"set smarttab
set tabstop=4
set shiftwidth=4

"set ai "Auto indent
"set si "Smart indent

set background=dark


" true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Mouse?
set mouse=a

" System clipboard
set clipboard=unnamed

autocmd BufWritePre * %s/\s\+$//e

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Red line on the side
set colorcolumn=80,100

" git clone --depth 1 https://github.com/zxqfl/tabnine-vim ~/.vim/tabnine-vim
set runtimepath+=~/.vim/tabnine-vim

" disable go fmt
let g:go_fmt_autosave = 0
