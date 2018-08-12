" ** MINIMAL VIMRC **
set encoding=utf-8
" nocompatible - break away from old vi compatibility
set nocp
" make backspace work like most other apps
set bs=indent,eol,start
" Turn off cursor blinking
set gcr=n:blinkon0
" enable language-dependent indenting.
" filetype plugin indent on
filetype indent off
set smartindent
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
" behave mswin
" noremap <C-V> <C-V>
" vmap <C-x> :!pbcopy<CR>
" vmap <C-c> :w !pbcopy<CR><CR>
" vmap <C-c> "+y
" set clipboard=unnamed

" Change the mapleader from \ to ,
let mapleader=","
" ; instead of : - :w -> ;w. saves milliseconds on each operation
nnoremap ' ;
nnoremap ; :

" Switch between last opened file
map <leader><leader> <C-^>

" ,xml -> format xml file
map <leader>xml :%!xmllint --format -<ENTER>

" Disable backup and swap files
set nobackup
set noswapfile

set fileformat=unix

" strip trailing whitespaces and keep new line at the end of file
" https://gist.github.com/jandudulski/4451806
if has("autocmd")
  autocmd BufWritePre * :%s/\s\+$//e
endif

" fix tmux background, hopefully
" http://stackoverflow.com/questions/14689925/vim-background-with-gnu-screen
set t_ut=

" 256 colors in terminal
set t_Co=256

" Open NERDTree
map <leader>N :NERDTree<CR>
map <leader>n :NERDTreeFind<cr>

" http://newbiedoc.sourceforge.net/tutorials/vim/mapping-vim.html.en
" map! ,cl console.log<space>
map! ,cl console.log()<esc>i
map! ,cg console.group('')<return>console.log()<return>console.groupEnd()<esc>kkhi
" map! ,ie Node.connect(:'pry@hodak'); require IEx; IEx.pry<esc>
map! ,ie require IEx; IEx.pry<esc>
map! ,ip IO.puts<space>
map! ,ii IO.inspect<space>
map ,iI O\|> IO.inspect<esc>

set colorcolumn=80

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

" vim was scrolling slowly
set ttyfast
set ttyscroll=3

" reload vimrc after save
augroup reload_vimrc " {
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" strange :( https://github.com/spf13/spf13-vim/issues/540#issuecomment-101488443
" set shortmess=a
" set cmdheight=2

call plug#begin()
Plug 'kien/ctrlp.vim'
Plug 'rking/ag.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'flazz/vim-colorschemes'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'yunake/vimux' | Plug 'skalnik/vim-vroom'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'digitaltoad/vim-pug'
Plug 'posva/vim-vue'
Plug 'elixir-lang/vim-elixir'

" Plug 'tpope/vim-surround'
" Plug 'tpope/vim-rails'
" Plug 'airblade/vim-rooter'
" Plug 'rking/pry-de', {'rtp': 'vim/'}
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
" Plug 'othree/javascript-libraries-syntax.vim'
" Plug 'scrooloose/syntastic'
" Plug 'keith/rspec.vim'
" Plug 'kchmck/vim-coffee-script'
" Plug 'pangloss/vim-javascript'
" Plug 'othree/html5.vim'
call plug#end()

" ctrlp
let g:ctrlp_user_command    = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_use_caching     = 0
let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
      \ }
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'

" vim-commentary
autocmd FileType vue setlocal commentstring=//\ %s

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

" javascript-libraries-syntax
" let g:used_javascript_libs = 'vue'

" syntastic
" let g:syntastic_check_on_open=0
" let g:syntastic_enable_signs=1
" let g:syntastic_ignore_files = []
