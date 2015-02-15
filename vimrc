"<c-p> ** MINIMAL VIMRC **
set encoding=utf-8
" nocompatible - break away from old vi compatibility
set nocp
" make backspace work like most other apps
set bs=indent,eol,start
" Turn off cursor blinking
set gcr=n:blinkon0
" enable language-dependent indenting.
filetype plugin indent on
" line numbers
set number
" remove toolbar in gVIm
set go-=T

" TABBING
set expandtab       " Expand TABs to spaces
set softtabstop=2   " Sets the number of columns for a TAB
set shiftwidth=2    " Indents will have a width of 4
" The width of a TAB is set to 2.
" Still it is a \t. It is just that
" Vim will interpret it to be having
" a width of 4.
set tabstop=2

" Stop the highlighting for the 'hlsearch' option.
set nohlsearch
" Split vertically to right
set splitright
" ignore case while search
set ic
" ** END OF MINIMAL VIMRC **

" Beautiful font
set guifont=Monaco

" disable auto commenting // while going to next line
au FileType c,java,php,js setlocal comments-=:// comments+=f://

" extended % matching for HTML, LaTeX, and many other languages
:source $VIMRUNTIME/macros/matchit.vim

" <C-C><C-V>
source $VIMRUNTIME/mswin.vim

" Pathogen plugin
" execute pathogen#infect()

" Change the mapleader from \ to ,
let mapleader=","
" ; instead of : - :w -> ;w. saves milliseconds on each operation
nnoremap ' ;
nnoremap ; :

" Switch between last opened file
map <leader><leader> <C-^>
" Open NERDTree
map <leader>N :NERDTree<CR>
map <leader>n :NERDTreeFind<cr>

set nobackup
set noswapfile

" always start gvim's window maximized
au GUIEnter * simalt ~x

""" NEOBUNDLE
if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

NeoBundle 'kien/ctrlp.vim'
let g:ctrlp_user_command    = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_use_caching     = 0
let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
      \ }
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'

" Ack
NeoBundle 'rking/ag.vim'

NeoBundle 'AndrewRadev/splitjoin.vim'
nmap sj :SplitjoinSplit<cr>
nmap sk :SplitjoinJoin<cr>

NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-sleuth'
NeoBundle 'tpope/vim-haml'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'digitaltoad/vim-jade'

" NeoBundle 'vim-scripts/IndexedSearch'
NeoBundle 'vim-scripts/gitignore'

NeoBundle 'airblade/vim-rooter'

NeoBundle 'christoomey/vim-tmux-navigator'

NeoBundle 'https://github.com/Valloric/YouCompleteMe.git' , {
      \ 'build' : {
      \ 'unix' : './install.sh --clang-completer --system-libclang'
      \ },
      \ }


NeoBundle 'benmills/vimux'
NeoBundle 'skalnik/vim-vroom'
let g:vroom_use_vimux = 1
let g:VimuxOrientation = "v"
let g:VimuxHeight = "40"
if filereadable("bin/rspec")
  let g:vroom_spec_command = './bin/rspec --format=documentation'
else
  let g:vroom_spec_command = 'rspec --format=documentation'
endif


NeoBundle 'rking/pry-de', {'rtp': 'vim/'}
map <Leader>bP orequire'pry-remote';binding.remote_pry<esc>:w<cr>

NeoBundle 'bling/vim-airline'
let g:airline_theme='powerlineish'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_section_z=''

NeoBundle 'scrooloose/nerdtree.git'
NeoBundle 'godlygeek/tabular'
NeoBundle 'sheerun/vim-polyglot'

NeoBundle 'scrooloose/syntastic'
let g:syntastic_check_on_open=0
let g:syntastic_enable_signs=1

NeoBundle 'terryma/vim-expand-region'

NeoBundle 'flazz/vim-colorschemes'

call neobundle#end()
""" /NEOBUNDLE

" testing
set fileformat=unix
" strip trailing whitespaces and keep new line at the end of file
" https://gist.github.com/jandudulski/4451806
if has("autocmd")
  " remove trailing white spaces
  autocmd BufWritePre * :%s/\s\+$//e
endif
" fix tmux background, hopefully
" http://stackoverflow.com/questions/14689925/vim-background-with-gnu-screen
set t_ut=

syntax on
" 256 colors in terminal
set t_Co=256

set relativenumber

" http://newbiedoc.sourceforge.net/tutorials/vim/mapping-vim.html.en
map! ,cl console.log<space>

if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
  let myUndoDir = expand(vimDir . '/undodir')
  " No console pops up
  call system('mkdir ' . myUndoDir)
  let &undodir = myUndoDir
  set undofile
endif

" Tab2Space
:command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'

colorscheme monokain

