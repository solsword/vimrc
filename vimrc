" ******
" HEADER
" ******

" vi is old...
set nocompatible

" Use utf-8 by default:
set encoding=utf-8
set fileencoding=utf-8

" Easier plugin management:
call pathogen#infect()
"call pathogen#helptags() 
" Additional runtime autoloading:
autocmd FuncUndefined * exe 'runtime autoload/' . expand('<afile>') . '.vim'

" set <space> as the leader key for mappings: 
nnoremap <space> <nop>
let mapleader = " "

" Enable filetype detection, as well as loading plugins and indentation for
" detected filetypes:
filetype on
filetype plugin on
filetype indent on

" **********
" END HEADER
" **********

" --------
" Includes
" --------

" More things for % to match:
runtime macros/matchit.vim

" -------------
" Basic options
" -------------

" Enable modelines:
set modeline
set modelines=5

" Backspacing:
set backspace=indent,eol,start

" Indenting/tabs:
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set cinoptions=+s,(s,U1,m1,j1,J1

" Don't put two spaces after periods when joining lines:
set nojoinspaces

" Show matching parens/brackets/etc:
set showmatch

" Replace-all as default:
set gdefault

" Show line/character/file percent in bottom right:
set ruler

" Informative terminal titles:
set title

" Put all backup and swap files in one place:
set backupdir=~/.vim-tmp//,~/.tmp//,~/tmp//,/var/tmp//,/tmp//
set directory=~/.vim-tmp//,~/.tmp//,~/tmp//,/var/tmp//,/tmp//

" Scroll before the cursor is at the *very* edge of the screen:
set scrolloff=3

" Tab completion menu settings:
set wildmenu
set wildmode=list:longest

" More history:
set history=500

" Custom thesaurus file for C-X C-T:
set thesaurus+=/home/pmawhorter/text/ebooks/moby/mthesaur.txt

" Get rid of the bell:
set visualbell
set t_vb=

" ------------
" Highlighting
" ------------

" Syntax highlighting:
syntax on

" Spell checking:
set spell

" Ensure spell-checking of top-level stuff
syntax spell toplevel

" Spelling highlight groups:
hi SpellBad term=standout,bold cterm=standout,bold ctermfg=none ctermbg=none
hi SpellCaps term=standout,bold cterm=standout,bold ctermfg=none ctermbg=none

" Highlight background for the omni-completion menu
hi Pmenu ctermbg=2

" Limit highlighting for long lines:
set synmaxcol=1000

" -------------------
" Loading large files
" -------------------
" http://vim.wikia.com/wiki/Faster_loading_of_large_files

if !exists("largefile_autocmd_def")
  let largefile_autocmd_def = 1
  " Large files are > 50 MB
  let g:LargeFile = 1024 * 1024 * 10
  augroup LargeFile
    autocmd BufReadPre * let fs=getfsize(expand("<afile>")) | if fs > g:LargeFile || fs == -2 | call LargeFile() | endif
  augroup END
  function LargeFile()
    " No syntax highlighting etc.
    set eventignore+=FileType
    syntax off
    " No swap file
    setlocal noswapfile
    " Read-only by default
    setlocal buftype=nowrite
    " No line wrapping
    setlocal nowrap
    " display message
    autocmd VimEnter * echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . "MB, so some options are changed (see .vimrc for details)."
  endfunction
endif

" -------
" Folding
" -------

set foldmethod=expr

set foldexpr=getline(v:lnum)=~'^$'\|\|getline(v:lnum)=~'^#.*'?'=':getline(v:lnum)=~'^\ \ [^#].*'\|\|getline(v:lnum)=~'^)\ {$'?1:0

" Unfold when opening a new file...
au BufRead,BufNewFile * normal zR

" ------
" Remaps
" ------

" Switch ' and `:
nnoremap ' `
nnoremap ` '

" Faster screen scrolling:
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" ---------
" Shortcuts
" ---------

" Who likes typing ":"?
nnoremap <Enter> :

" To toggle paste mode (even when in paste mode):
set pastetoggle=<F2>

" Edit the vimrc file in a new tab:
nmap <silent> <leader>vrc :tabe $MYVIMRC<CR>

" Execute the current line (from the cursor) in a shell:
nmap <leader>x y$:!<C-R>"<CR>

" Execute the current line (from the cursor) as an ex command:
nmap <leader>vx y$:<C-R>"<CR>

" Toggle list mode:
set listchars=tab:>-,trail:.,eol:$,nbsp:',extends:#
nmap <silent> <leader>s :set invlist<CR>

" Togge line numbers:
nmap <silent> <leader>n :set invnu<CR>
nmap <silent> <leader>N :set invrnu<CR>

" Tab-completion using Tab (!) in insert mode:
imap <Tab> 
imap <S-Tab> 

" Beautiful quotes in insert mode:
nmap <leader>ql a“<esc>
nmap <leader>qr a”<esc>
nmap <leader>qsl a‘<esc>
nmap <leader>qsr a’<esc>
nmap <leader>' a‘’<esc>
nmap <leader>" a“”<esc>

" Check highlight group:
nmap <leader>H :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . "> trans<" . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#") . " BG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"bg#")<CR>

" Copy/paste to/from the X clipboard using Tab and Shift-Tab:
" Note: vim must be compiled with +clipboard enabled.
nmap <Tab> "+p
vmap <S-Tab> "+y

" Maybe works for mac?
"nmap <Tab> :r !pbpaste<CR>
"vmap <S-Tab> :w !pbcopy<CR><CR>

" Deleting without overwriting the default cut buffer:
nmap dx "_dd
vmap d "_d

" Repeat the 'j' macro using 'q.':
nmap q. @j

" Formatting paragraphs:
vmap Q gq
nmap Q gqap

" Faster window switching:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Who wants to worry about sudo *before* opening the file?
command WW :execute ':silent w !sudo tee % > /dev/null' | :edit!

" Make :W by itself ambiguous to avoid typos putting you at the sudo prompt:
command WX :execute ':echo "You fool!"'

" Searching for ligatures, accented characters, and the like.
command Oop /[^^a-zA-Z0-9`~!@#$%^&*()-_=+[\]{}\\|;:'"/?,<.> \t]<CR>

" Jumping around functions:
nmap <leader><space> $%

" Tab switching:
nmap <leader>h gT
nmap <leader>l gt

" Splitting lines on arguments
nmap <leader>k 0/[({[]<CR>a<CR><Esc>:s/\([,()]\+\) \?/\1<C-V><CR>/<CR>k:+g/\m^\s*$/d<CR>k$i<CR><Esc>V%:s/\()[,:]\?\)$/<C-V><CR>\1<CR>:-g/\m^\s*$/d<CR>$V%=

" --------------
" Plugin-related
" --------------

" Take back 'vs' from the surround plugin:
xmap <leader>s <plug>Vsurround

" Use the sideways plugin to shift arguments around:
nmap <leader>wh :SidewaysLeft<CR>
nmap <leader>wl :SidewaysRight<CR>

" Easy cnext and cprevious:
nmap <leader>. :cnext<CR>
nmap <leader>, :cprevious<CR>

" Re-sync syntax from start and re-draw on-demand:
nmap <leader>r :syntax sync fromstart<CR>:redraw!<CR>

" Running a line in the shell:
nmap <leader><return> v$hy:!"<CR>

" Get syntax attributes under cursor (see SynAttr.vim):
nmap <leader>H :call SyntaxAttr()<CR>

" -------------------
" Local customization
" -------------------
"  Note: This comes *last* to override non-local options where necessary.

if filereadable("local.vim")
  source "local.vim"
endif
