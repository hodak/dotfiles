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
" line, relative numbers
set number
set relativenumber
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

" """ NEOBUNDLE
" if has('vim_starting')
"   set nocompatible               " Be iMproved

"   " Required:
"   set runtimepath+=~/.vim/bundle/neobundle.vim/
" endif

" " " Required:
" call neobundle#begin(expand('~/.vim/bundle/'))

" " Let NeoBundle manage NeoBundle
" " Required:
" NeoBundleFetch 'Shougo/neobundle.vim'
" NeoBundle 'Shougo/vimproc', {
"       \ 'build' : {
"       \     'windows' : 'make -f make_mingw32.mak',
"       \     'unix' : 'make -f make_unix.mak',
"       \    },
"       \ }

" NeoBundle 'tpope/vim-rails'
" NeoBundle 'tpope/vim-sleuth'
" NeoBundle 'tpope/vim-haml'
" NeoBundle 'digitaltoad/vim-jade'

" " ,rt -> to strings
" " ,rr -> to symbols
" NeoBundle 'rorymckinley/vim-rubyhash'

" " NeoBundle 'vim-scripts/IndexedSearch'
" NeoBundle 'vim-scripts/gitignore'

" NeoBundle

" NeoBundle 'https://github.com/Valloric/YouCompleteMe.git' , {
"       \ 'build' : {
"       \ 'unix' : './install.sh --clang-completer --system-libclang'
"       \ },
"       \ }


" NeoBundle 'godlygeek/tabular'


" NeoBundle 'terryma/vim-expand-region'

" " NeoBundle 'elixir-lang/vim-elixir'
" " NeoBundle 'pearofducks/ansible-vim'

" call neobundle#end()
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

" http://newbiedoc.sourceforge.net/tutorials/vim/mapping-vim.html.en
" map! ,cl console.log<space>
map! ,cl console.log();<esc>hi
map! ,cg console.group('')<return>console.log()<return>console.groupEnd()<esc>kkhi
map! ,ie Node.connect(:'pry@hodak'); require IEx; IEx.pry<esc>
map! ,ii IO.inspect<space>

if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" " Put plugins and dictionaries in this dir (also on Windows)
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

" autocmd filetype crontab setlocal nobackup nowritebackup

call plug#begin()
Plug 'kien/ctrlp.vim'
Plug 'rking/ag.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'flazz/vim-colorschemes'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rails'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-rooter'
Plug 'yunake/vimux' | Plug 'skalnik/vim-vroom'
Plug 'rking/pry-de', {'rtp': 'vim/'}
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/syntastic'
Plug 'keith/rspec.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'slim-template/vim-slim'
Plug 'mtscout6/vim-cjsx'
Plug 'othree/html5.vim'
Plug 'posva/vim-vue'

" ,rt -> to strings
" ,rr -> to symbols
" Plug 'rorymckinley/vim-rubyhash'

Plug 'elixir-lang/vim-elixir'
call plug#end()

" ctrlp
let g:ctrlp_user_command    = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_use_caching     = 0
let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
      \ }
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'

" vim-colorschemes
colorscheme Tomorrow-Night

" vim-vroom
let g:vroom_use_vimux = 1
let g:VimuxOrientation = "v"
let g:VimuxHeight = "40"
if filereadable("bin/rspec")
  let g:vroom_spec_command = './bin/rspec --format=documentation'
else
  let g:vroom_spec_command = 'rspec --format=documentation'
endif
let g:vroom_mix_test_command = 'elixir --sname mixtest -S mix test --color'

" vim-airline
let g:airline_theme='powerlineish'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_section_z=''

" syntastic
let g:syntastic_check_on_open=0
let g:syntastic_enable_signs=1

let g:used_javascript_libs = 'angularjs'

set ttyfast
set ttyscroll=3

augroup reload_vimrc " {
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

au BufRead,BufNewFile *.vue set filetype=html
