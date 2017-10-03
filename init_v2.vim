"   _____                        _____  _                
"  / ____|                      |  __ \(_)               
" | |     __ _ _ __ _ __   ___  | |  | |_  ___ _ __ ___  
" | |    / _` | '__| '_ \ / _ \ | |  | | |/ _ \ '_ ` _ \ 
" | |___| (_| | |  | |_) |  __/ | |__| | |  __/ | | | | |
"  \_____\__,_|_|  | .__/ \___| |_____/|_|\___|_| |_| |_|
"                  | |                                   
"                  |_|                                   
" Author: Kwon-Young Choi
" Date: septembre 29, 2017
"
" Description:
"		Configuration file for Vim and Neovim
"
" Compatibility: Vim and Neovim
"

set nocompatible
" Enable file type detection, plugins files and indent files
filetype indent plugin on
" Enable syntax highlighting
syntax on

" Enable undo files and backup files {{{
set undofile
set backup

if has('nvim')
  " Neovim backupdir default has current directory which I don't like
  set backupdir-=.
else
  " Use ~/.vim path when using Vim
  set directory=$HOME/.vim/swap//
  set undodir=$HOME/.vim/undo
  set backupdir=$HOME/.vim/backup
endif
" }}}

" various Vim settings {{{
" Don't be shy, use utf-8 ...
set fileencoding=utf-8
set fileencodings=utf-8
if !has('nvim')
  " Removed in Neovim
  set encoding=utf-8
endif
" Show absolute line numbers
set number
" Allow switching buffer when not saved
set hidden
" Ignore case when searching
set ignorecase
" Becomes case sensitive when starting a search with uppercase
set smartcase
" Show match when searching
set incsearch
" Highlight previous search
set hlsearch
" Show interactive bracket match
set showmatch
" Show line and column number of the cursor position
set ruler
" Show partial normal command
set showcmd
" Enable mouse
set mouse=a
" Enable command mode history
set history=1000
" Maximum number of changes that can be undone
set undolevels=1000
" Enable spell checker us
set spell
set spelllang=en_us
" Turn off this horrible horrible settings
set noerrorbells
" disable bell of Vim
set noeb vb t_vb=
" Always show 2 lines above and below the cursor
set scrolloff=2
" Wrap lines
set wrap
" Show tabline only if more than 1 tab
set showtabline=1
if has('nvim')
  " show incremental search/replace
  set inccommand=nosplit
endif
" always show last window status line
set laststatus=2
" }}}

" Indentation option {{{
" ============================================================================
" Indenting newlines
" ============================================================================

set autoindent                        " indent when creating newline
set smartindent                       " add an indent level inside braces

" for autoindent, use same spaces/tabs mix as previous line, even if
" tabs/spaces are mixed. Helps for docblock, where the block comments have a
" space after the indent to align asterisks
set copyindent

" Try not to change the indent structure on "<<" and ">>" commands. I.e. keep
" block comments aligned with space if there is a space there.
set preserveindent

" ============================================================================
" Tabbing - overridden by editorconfig, sleuth.vim
" ============================================================================

set expandtab                         " default to spaces instead of tabs
set shiftwidth=2                      " softtabs are 2 spaces for expandtab

" Alignment tabs are two spaces, and never tabs. Negative means use same as
" shiftwidth (so the 2 actually doesn't matter).
" Works with IndentTab.
set softtabstop=-2

" real tabs render 4 wide. Applicable to HTML, PHP, anything using real tabs.
" I.e., not applicable to JS.
set tabstop=4

" use multiple of shiftwidth when shifting indent levels.
" this is OFF so block comments don't get fudged when using ">>" and "<<"
set noshiftround

" When on, a <Tab> in front of a line inserts blanks according to
" 'shiftwidth'.  'tabstop' or 'softtabstop' is used in other places.  A
set smarttab

set backspace=indent,eol,start        " bs anything
" }}}

" mappings {{{
" QWERTY layout
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
let mapleader = "'"
" AZERTY layout
" let mapleader = "ù"

" Escape
inoremap jk <Esc>
inoremap kj <Esc>

"Edit and source vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>eg :vsplit $MYGVIMRC<cr>
nnoremap <leader>sg :source $MYGVIMRC<cr>
" Edit note file
nnoremap <leader>en :edit $HOME/.local/share/nvim/note.md<CR>
nnoremap <leader>exn :vsplit $HOME/.local/share/nvim/note.md<CR>
nnoremap <leader>esn :split $HOME/.local/share/nvim/note.md<CR>
nnoremap <leader>etn :tabedit $HOME/.local/share/nvim/note.md<CR>

" delete buffer without deleting split
nnoremap <leader>d :bp\|bd #<cr>

" switching split
nnoremap <a-l> :wincmd l<CR>
nnoremap <a-k> :wincmd k<CR>
nnoremap <a-j> :wincmd j<CR>
nnoremap <a-h> :wincmd h<CR>
" Remove search highlight
noremap <leader>h :nohlsearch<cr>
" diffupdate to du
nnoremap du :diffupdate<CR>
" Add very magic to search command
nnoremap / /\v
nnoremap ? ?\v
" }}}

" Neovim Terminal settings {{{
if has('nvim')
  augroup terminal
    autocmd!
    autocmd TermOpen * setlocal nospell
  augroup END
  set shell=zsh
  " exit insert mode in terminal
  tnoremap jk <C-\><C-n>
  " Switching split with alt
  tnoremap <A-h> <C-\><C-n><C-w>h
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l
  " neovim terminal emulator colorscheme
  let g:terminal_color_0 = "#4E4E4E"
  let g:terminal_color_1 = "#d68787"
  let g:terminal_color_2 = "#5f865f"
  let g:terminal_color_3 = "#d8af5f"
  let g:terminal_color_4 = "#85acd4"
  let g:terminal_color_5 = "#D7AFAF"
  let g:terminal_color_6 = "#87AFAF"
  let g:terminal_color_7 = "#D0D0D0"
  let g:terminal_color_8 = "#626262"
  let g:terminal_color_9 = "#D75F87"
  let g:terminal_color_10 = "#87AF87"
  let g:terminal_color_11 = "#FFD787"
  let g:terminal_color_12 = "#ACD4FA"
  let g:terminal_color_13 = "#FFAFAF"
  let g:terminal_color_14 = "#87D7D7"
  let g:terminal_color_15 = "#E4E4E4"
  let g:terminal_color_background="#171717"
  let g:terminal_color_foreground="#D0D0D0"
endif
" }}}

" Plugins configuration {{{
" Automatic installation of vim-plug
if has('win32')
  let s:plug_file = glob('~/vimfiles/autoload/plug.vim')
elseif has('unix')
  let s:plug_file = glob('~/.vim/autoload/plug.vim')
endif

if has('win32') && empty(s:plug_file)
  silent !bitsadmin /transfer vimplug /download /priority normal https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim C:\users\kwon-young\vimfiles\autoload\plug.vim
elseif has('unix') && empty(s:plug_file)
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

if !empty(s:plug_file)
  call plug#begin()

  " Nice plugins name completion from vimawesome
  if has('unix')
    Plug 'https://gist.github.com/5dff641d68d20ba309ce.git',
          \ {'as': 'vimawesome', 'do': 'mkdir -p plugin; cp -f *.vim plugin/'}
  elseif has('win32')
    Plug 'https://gist.github.com/5dff641d68d20ba309ce.git',
          \ {'as': 'vimawesome', 'do': 'mkdir plugin && move *.vim plugin/'}
  endif

  Plug 'junegunn/seoul256.vim'
  
  " Interface
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'
  Plug 'machakann/vim-highlightedyank'
  Plug 'vim-utils/vim-troll-stopper', { 'on': 'Troller'}
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-flagship'

  " File system
  if has('unix')
    Plug 'junegunn/fzf', { 'dir': '~/.config/fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-eunuch'
  endif

  " Searching
  Plug 'teoljungberg/vim-grep'
  
  " Git
  Plug 'tpope/vim-fugitive'

  " Text editing
  Plug 'godlygeek/tabular'

  " Languages
  " Generic
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'scrooloose/nerdcommenter'

  Plug 'tweekmonster/braceless.vim'

  if !has('nvim')
    Plug 'roxma/vim-hug-neovim-rpc'
  else
    Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
    " (Optional) Completion integration with nvim-completion-manager.
    Plug 'roxma/nvim-completion-manager'
    Plug 'Shougo/echodoc.vim'
  endif
  Plug 'Shougo/neco-syntax'
  Plug 'Shougo/neco-vim'

  " C/C++
  Plug 'octol/vim-cpp-enhanced-highlight'
  
  " Markdown
  Plug 'vim-pandoc/vim-pandoc'
  Plug 'vim-pandoc/vim-pandoc-syntax'

  " Latex
  Plug 'latex-box-team/latex-box', {'for': 'tex'}
  call plug#end()
else
  echom "vim-plug couldn't be installed, check if curl and " . &shell " is installed."
endif
" }}}

" Seoul256 configuration {{{
let g:seoul256_srgb = 1
let g:seoul256_background = 236
silent! colorscheme seoul256
" brighten/dim background - a'la macOS dim screen function keys
" 233 (darkest) ~ 239 (lightest) 252 (darkest) ~ 256 (lightest)
function! Seoul256Brighten()
    if g:seoul256_background == 239
        let g:seoul256_background = 252
    elseif g:seoul256_background == 256
        let  g:seoul256_background = 256
    else
        let g:seoul256_background += 1
    endif
    colo seoul256
endfunction
"
function! Seoul256Dim()
    if g:seoul256_background == 252
        let g:seoul256_background = 239
    elseif g:seoul256_background == 233
        let g:seoul256_background = 233
    else
        let g:seoul256_background -= 1
    endif
    colo seoul256
endfunction
"
nnoremap <F1> :call Seoul256Dim()<CR>
nnoremap <F2> :call Seoul256Brighten()<CR>
" }}}

" Fugitive mappings {{{
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gw :Gwrite<CR>
" }}}

" vim-highlightedyank plugin configuration {{{
hi HighlightedyankRegion cterm=underline gui=underline
" }}}

" fzf mapping {{{
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>m :Marks<CR>
nnoremap <leader>u :Snippets<CR>
" }}}

" Braceless configuration {{{
autocmd FileType python BracelessEnable +indent
" }}}

" UltiSnips configuration {{{
if has('nvim')
  let g:UltiSnipsSnippetsDir = "$XDG_CONFIG_HOME/UltiSnips"
else
  let g:UltiSnipsSnippetsDir = "$HOME/.vim/UltiSnips"
endif
" }}}

" pandoc configuration {{{
let g:pandoc#modules#disabled = ["chdir"]
" }}}

" LanguageClient-neovim configuration {{{

let g:LanguageClient_serverCommands = {
      \ 'python': ['pyls'],
      \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

"nnoremap <silent> K :call
"LanguageClient_textDocument_hover()<CR>
"nnoremap <silent> gd :call
"LanguageClient_textDocument_definition()<CR>
"nnoremap <silent> <F2> :call
"LanguageClient_textDocument_rename()<CR>
" }}}

augroup cutecat
   autocmd!
   autocmd VimEnter * echo ">^.^<"
augroup END
