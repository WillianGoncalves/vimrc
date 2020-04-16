" A VIM config file.
"
" Maintainer:	Willian Goncalves <w.goncalves91@gmail.com>
" Thanks to:    Guilherme Gonçalves <inacio.guilherme@gmail.com>
" Last change:	2017 Out 02
"
" To use it, copy it to
"  for Unix and OS/2:  ~/.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	 for OpenVMS:  sys$login:.vimrc


set nocompatible               " be iMproved, required
set encoding=utf-8             " Use utf-8

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'xolox/vim-misc'
Plug 'valloric/youcompleteme', { 'do': './install.py --tern-completer' }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs' "Vim plugin, insert or delete brackets, parens, quotes in pair
Plug 'alvan/vim-closetag' "Auto close (X)HTML tags
Plug 'xolox/vim-session' "Extended session management for Vim
Plug 'terryma/vim-multiple-cursors' "True Sublime Text style multiple selections for Vim
Plug 'scrooloose/nerdcommenter' "Code comment plugin
Plug 'maksimr/vim-jsbeautify', {'do': 'git submodule update --init --recursive'}
Plug 'dense-analysis/ale', { 'commit': 'd837169f1d10f0fee605cc17564c68563db94601' } "Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support
Plug 'honza/vim-snippets'
Plug 'https://github.com/sirver/ultisnips.git'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree' "A tree explorer plugin for vim
Plug 'Xuyuanp/nerdtree-git-plugin' "A plugin of NERDTree showing git status
Plug 'tpope/vim-surround' "Quoting/parenthesizing made simple
Plug 'tyrannicaltoucan/vim-deep-space' "Vim theme
Plug 'suan/vim-instant-markdown', { 'do': 'sudo npm install -g instant-markdown-d' } "Instant Markdown previews from Vim!
Plug 'tpope/vim-repeat' "Enable repeating supported plugin maps with '.'
Plug 'Yggdroot/indentLine' "A vim plugin to display the indention levels with thin vertical lines
Plug 'junegunn/vim-easy-align' "A Vim alignment plugin
Plug 'lervag/vimtex' "A modern vim plugin for editing LaTeX files
Plug 'kshenoy/vim-signature' "Plugin to toggle, display and navigate marks
Plug 'airblade/vim-gitgutter' "A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks and partial hunks.
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

:set linespace=7

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup     " do not keep a backup file, use versions instead
else
  set backup       " keep a backup file (restore to previous version)
  set undofile     " keep an undo file (undo changes after closing)
endif
set history=50     " keep 50 lines of command line history
set ruler          " show the cursor position all the time
set showcmd        " display incomplete commands
set incsearch      " do incremental searching
set number relativenumber " display line numbers
set numberwidth=1
set nowrap
set hlsearch

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
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
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
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

" search tags
set tags=tags;/

" window settings
syntax enable
colorscheme deep-space 
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scrollbar
set guioptions-=L  "remove left-hand scrollbar

" font
set guifont=FuraMonoForPowerline\ Nerd\ Font

" split style for monokay
set fillchars+=vert:\ 
hi! VertSplit guibg=#293031 ctermbg=238

" jsbeautify
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

" Store swap files in fixed location, not current directory.
set backupdir=/tmp
set undodir=/tmp
set directory=/tmp

" session settings
let g:session_autosave = 'no'
let g:session_autoload = 'no'

" youcompleteme
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
let g:ycm_filepath_blacklist = {}
set completeopt-=preview

" ale
" Fix files with prettier, and then ESLint.
let g:ale_linters = {'javascript': ['eslint']}
let g:ale_fixers = {'javascript': ['prettier', 'eslint']}

" closetag
let g:closetag_filenames = "*.html.erb,*.html,*.xhtml,*.phtml,*.js"

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
packadd matchit

" current directory abreviation '%%'
cabbr <expr> %% expand('%:p:h')
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR>

" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Set split sides
set splitbelow
set splitright

" Find/Replace selected text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Disable bell
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" highlighting current line
set cul

" auto refresh files
set autoread

" indentLine
let g:indentLine_enabled=1
let g:indentLine_char='|'
set listchars=tab:\┆\ 
set list

" ==== NERD tree
" Open the project tree and expose current file in the nerdtree with Ctrl-\
" " calls NERDTreeFind iff NERDTree is active, current window contains a modifiable file, and we're not in vimdiff
function! OpenNerdTree()
  if &modifiable && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
  else
    NERDTreeToggle
  endif
endfunction
nnoremap <silent> <C-\> :call OpenNerdTree()<CR>
let NERDTreeShowHidden=1
let NERDTreeNodeDelimiter="\u00a0"

" nerdtree-syntax-highlight
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name

" disable auto-hide
let g:vim_json_syntax_conceal = 0
set conceallevel=0
set cole=0 
au FileType * setl cole=0 

" spell
set nospell

" default tabsize
set tabstop=2
set shiftwidth=2
set expandtab

" airline
set laststatus=2
let g:airline_theme='lucius'
let g:airline_powerline_fonts=0
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#show_buffers=0
let g:airline#extensions#hunks#enabled=0

" hide end of buffer '~'
"if has('gui_running')
    "hi! EndOfBuffer guibg=bg guifg=bg
"else 
    "hi! EndOfBuffer ctermbg=bg ctermfg=bg
"endif

" config hidden characters exibition.
" use with ':set list' and disable with ':set nolist'
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set nolist

" map :nohl to back slask (Leader)
nnoremap <silent> <Leader>/ :nohlsearch<CR>

let g:vue_disable_pre_processors=1

set scrolloff=5

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" improve ruby performance
set regexpengine=1
set lazyredraw

" disable polyglot language packs to avoid conflict with other plugins
let g:polyglot_disabled = ['latex']

command! FormatJson set syntax=json | %!python -m json.tool

" close other tabs
command! Q %bd|e#

" GitGutter
nmap <Leader>uh <Plug>(GitGutterUndoHunk)
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

" ale
nmap ]e :ALENext<cr>
nmap [e :ALEPrevious<cr>

" git commit with 72 columns
autocmd Filetype gitcommit setlocal spell textwidth=72

" fzf
nnoremap <C-p> :Files<Cr>
