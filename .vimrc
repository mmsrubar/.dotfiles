" Encodings ********************************************************************
set encoding=utf-8	" Internal file encoding (utf-8, iso-8859-2, cp1250)
set termencoding=utf-8 " tell vim that terminal I'm working with uses
							" iso-8859-2
"set fileencodings=iso-8859-1,iso-8859-2,cp1250,utf-8

" Tabelators & scrolling *******************************************************
set tabstop=2				" size of tab
set shiftwidth=2		" size of spaces for shifting
set scrolloff=5			" starts srcoll 2 lines before end of visible EOF
set smartindent			" use the current line's indent level on new lines
set textwidth=80		" text width
set expandtab				" use spacesinstead of tabs

" Search ***********************************************************************
set hlsearch			" highlight searching
set incsearch			" incremental searching
set ignorecase		" ignore case-sensitive
set smartcase			" /hidude (HiDude, hiDude) | /HiDude (HiDude !hiDude)

" Other stuff ******************************************************************
set nocompatible		" disable compatibility with 'vi'
set number				" show line numbers
set showmode			" show current mode (left bottom corner)
set showtabline=2		" show name of file as one tab
set ruler				" show line and current char position
set autowrite			" auto write while switching buffers, :make, etc.

" Backup files *****************************************************************
set backup							          " start create backup files
set backupext=.bak					      " extension for backup files 
set backupdir=~/.vim/backup,.,~/	" path for backuped files

" Temporary files **************************************************************
set directory=~/.vim/tmp,.,~/

" Fx KEYs **********************************************************************
" compile
map <F11> :!gcc `echo expand('%:t')`<CR>
"nmap <C-Enter> <C-w><C-]><C-w>T
" run make command
map <F9> :make<CR>
map <F4> :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>

" open tag list
nnoremap <silent> <F8> :TlistOpen<CR>
":let Tlist_Auto_Open=1
:let Tlist_Auto_Highlight_Tag=1

" insert timestamp 
:nnoremap <F5> "=strftime("%c")<CR>P
:inoremap <F5> <C-R>=strftime("%c")<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>

filetype on
filetype plugin indent on					" enable plugin supporting
syntax enable
syntax on

" not bad are: desert, slate, oceanblack256
colorscheme mustang
"colorscheme ir_black

" disable scrollbars in gvim
set guioptions+=LlRrb
set guioptions-=LlRrb

inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

" use default skeletons 
au BufNewFile *.c 0r ~/.vim/skeletons/c.skel | let IndentStyle = "c"
au BufNewFile *.cc 0r ~/.vim/skeletons/cc.skel | let IndentStyle = "c"
au BufNewFile *.h 0r ~/.vim/skeletons/h.skel | let IndentStyle = "h"
au BufNewFile *.html 0r ~/.vim/skeletons/html.skel | let IndentStyle = "html"

" default font for gvim
"set guifont=Monaco\ 9
"set guifont=Monospace\ 9
set guifont=Terminess\ Powerline\ 8

nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
