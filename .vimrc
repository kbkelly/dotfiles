set nocompatible
filetype off                  

set rtp+=~/.vim/bundle/vundle/ 
call vundle#rc()

" original repos on github
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'https://github.com/Lokaltog/vim-easymotion.git'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'mileszs/ack.vim'
Bundle 'wincent/Command-T'
Bundle 'kchmck/vim-coffee-script'
Bundle 'taglist.vim'
Bundle 'kbkelly/VimDebugger'
" " vim-scripts repos
"Bundle 'rails.vim'
" " non github repos


let mapleader = ","

" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Jul 02
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
  " Set where to store backups
  set backupdir=~/.vim/tmp

endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Steve Losh's sanity settings for VIM
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
" Clear out search easily once you're done with it.
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %
" Text width / wrap settings
set wrap
set textwidth=79
set formatoptions=qrn1
"set colorcolumn=85
" No need to press shift + ; for commands
nnoremap ; :
" au FocusLost * :wa
" Equivalent to Textmate Ctrl+Q 
nnoremap <leader>q gqip

" New vertical split + switch to it
nnoremap <leader>w <C-w>v<C-w>l

" Switching between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Enable cursor highlighting in insert mode
highlight iCursor guifg=white guibg=steelblue
" set guicursor+=i:ver100-iCursor
" Quick ack
nnoremap <leader>a :Ack<space>

" Don't let DBGp interact badly with MiniBufExplorer
let g:debuggerMiniBufExpl = 1

" MiniBufExplorer settings
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" Disable adding newline at the end of each file
" DO NOT USE THIS BECAUSE IT MESSES UP THE TABBING, ETC.
"autocmd FileType php setlocal noeol binary expandtab
set fileformats+=mac
" Debugger should go for a loong time so phpunit can run all tests.
let g:debuggerTimeout = 30
" Automatically reload files when they change (mostly from git checkouts, etc.)
set autoread

" The following are test settings for VimDebugger (different from
" debugger.vim).
"map <F11> :DbgStepInto<CR>
"map <F10> :DbgStepOver<CR>
"map <S-F11> :DbgStepOut<CR>
"map <F5> :DbgRun<CR>
"map <S-F5> :DbgDetach<CR>
"map <F8> :DbgToggleBreakpoint<CR>
map <F2> :DbgStepInto<CR>
map <F3> :DbgStepOver<CR>
map <F4> :DbgStepOut<CR>
map <F5> :DbgRun<CR>
map <F6> :DbgDetach<CR>
map <F8> :DbgToggleBreakpoint<CR>

" Automatically reload the vimrc every time it gets saved.
if has("autocmd")
    autocmd! bufwritepost .vimrc source $MYVIMRC
endif
nmap <leader>v :tabedit $MYVIMRC<CR>

" PHP parser check (CTRL-L)
autocmd FileType php noremap <C-L> :!php -l %<CR>
" Taglist
nnoremap <silent> <F7> :TlistToggle<CR>

nmap <leader>f :CommandTFlush<CR>
nmap <leader>t :CommandT<CR>

nmap <leader>sc :%s/pick/squash/gc

nmap <leader>gs 3jy2jGO<Esc>pVG:s/\vprivate (\w+) (\w+);/public \1 get\u\2() { return \2; }\r\tpublic void set\u\2( \1 ~2<BS><BS>\2 ) {\r\t\tthis.\2 = \2;\r\t}\r/<CR><CR>ddZZ

" Do not have the 'g' option for substitute disable global substitute by default
set nogd

vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

"autocmd FileType ruby setlocal ts=2 sts=2 sw=2

nmap <leader>cn /\v\<\<\<<CR>

let g:EasyMotion_leader_key = '<leader>m'

" Check for MacVim before applying settings. 
" What we really want is to check for Vim 7.3 but I can't seem to figure that
" one out.
if has("gui_macvim")
    set colorcolumn=80,120
    set undofile
    set undodir=/tmp
    set rnu
endif

"if exists('+autochdir')
  "set autochdir
"else
  "autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /
"endif

nmap <leader>l :TlistToggle<CR>

" Change directory to current file
map ,cd :cd %:p:h<CR>:pwd<CR>

syn match Normal '>'

" Ctrl+r for find and replace visual selection.
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Do not use F1 to go to help (annoying).
inoremap <F1> <Esc>
noremap <F1> :call MapF1()<CR>

function! MapF1()
  if &buftype == "help"
    exec 'quit'
  else
    exec 'help'
  endif
endfunction

"autocmd FileType yaml setlocal shiftwidth=2 tabstop=2
"autocmd FileType php setlocal shiftwidth=4 tabstop=4
"autocmd FileType scss  setlocal shiftwidth=2 tabstop=2
"autocmd FileType xml setlocal shiftwidth=2 tabstop=2
"autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=4
"autocmd FileType css setlocal shiftwidth=2 tabstop=2
"autocmd FileType coffee setlocal shiftwidth=2 tabstop=2
"autocmd FileType js setlocal shiftwidth=2 tabstop=2
setlocal shiftwidth=2 tabstop=2 softtabstop=4


