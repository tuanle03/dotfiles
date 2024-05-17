let mapleader = " "
set backspace=2   " Backspace deletes like most programs in insert mode
set tabstop=2
set shiftwidth=2
set expandtab
set noswapfile
set history=10
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set list listchars=tab:»·,trail:·,nbsp:·

" Numbers
set number
set numberwidth=5
syntax on

" if (&t_co > 2 || has("gui_running")) && !exists("syntax_on")
"   syntax on
" endif
filetype plugin indent on

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  " let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
  let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$|vendor\|\.hg$\|\.svn$\|\.yardoc\|public\|app\/assets\/images\|public\|app\/assets\/fonts\|data\|log\|node_modules\|bin\|tmp$',
    \ 'file': '\.exe$\|\.so$\|\.min\.js$\|\.min\.css$\|\.png|\.jpg|\.jpeg|\.otf|\.gif|\.svg|\.|\.dat$'
    \ }
endif

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
