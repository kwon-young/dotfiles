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
set history=10000
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
set foldlevel=1
set nofoldenable
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

" c/c++ indenting option to disable goto automatic indentation
set cinoptions+=L0
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
nnoremap <leader>en :edit $HOME/.local/share/nvim/note.md<CR>GG
nnoremap <leader>exn :vsplit $HOME/.local/share/nvim/note.md<CR>
nnoremap <leader>esn :split $HOME/.local/share/nvim/note.md<CR>
nnoremap <leader>etn :tabedit $HOME/.local/share/nvim/note.md<CR>

" Easy copy/pasting with X11 "+ register
noremap <leader>y "+y
noremap <leader>p "+p

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
nnoremap <leader>dt :windo diffthis<CR>
nnoremap <leader>do :windo diffoff<CR>
" Add very magic to search command
nnoremap / /\v
nnoremap ? ?\v
" fullscreen current buffer
nnoremap <a-o> :tab split<CR>
" }}}

" Neovim Terminal settings {{{
if has('nvim')
  augroup terminal
    autocmd!
    autocmd TermOpen * setlocal nospell
    autocmd TermOpen * setlocal nonumber
    autocmd TermOpen * startinsert
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

" Prolog filetype detection {{{
let g:filetype_pl="prolog"
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
  let s:plug_file = glob('~/.vim/autoload/plug.vim')
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
  
  " Gui
  Plug 'equalsraf/neovim-gui-shim'

  " Interface
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'
  if has('nvim')
    Plug 'machakann/vim-highlightedyank'
  endif
  Plug 'vim-utils/vim-troll-stopper', { 'on': 'Troller'}
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-flagship'

  " File system
  if has('unix')
    Plug 'junegunn/fzf', { 'dir': '~/.config/fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-eunuch'
  endif
  Plug 'zenbro/mirror.vim'
  Plug 'lambdalisue/suda.vim'

  " Searching
  Plug 'teoljungberg/vim-grep'
  
  " Git
  Plug 'tpope/vim-fugitive'

  " Text editing
  Plug 'godlygeek/tabular'
  Plug 'FooSoft/vim-argwrap'
  Plug 'Osse/double-tap'
  Plug 'tpope/vim-surround'

  " Clipboard
  Plug 'fcpg/vim-osc52'

  " Async
  Plug 'skywind3000/asynctasks.vim'
  Plug 'skywind3000/asyncrun.vim'

  " Languages
  " Generic
  "Plug 'ludovicchabant/vim-gutentags'
  Plug 'kwon-young/gen_tags.vim'
  if has('python3')
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
  endif
  Plug 'scrooloose/nerdcommenter'

  Plug 'tweekmonster/braceless.vim'

  Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh'
        \ }
  Plug 'roxma/vim-hug-neovim-rpc'
  Plug 'Shougo/echodoc.vim'
  Plug 'rhysd/vim-grammarous'
  Plug 'ncm2/ncm2'
  Plug 'roxma/nvim-yarp'
  Plug 'ncm2/ncm2-ultisnips'
  Plug 'ncm2/ncm2-bufword'
  Plug 'ncm2/ncm2-path'
  Plug 'ncm2/ncm2-syntax' | Plug 'Shougo/neco-syntax'
  Plug 'ncm2/ncm2-neoinclude' | Plug 'Shougo/neoinclude.vim'
  Plug 'ncm2/ncm2-vim' | Plug 'Shougo/neco-vim'

  if has('nvim')
    Plug 'mfussenegger/nvim-dap'
  endif

  " include for lots of filetypes
  Plug 'tpope/vim-apathy'

  " C/C++
  Plug 'octol/vim-cpp-enhanced-highlight'
  Plug 'dawikur/algorithm-mnemonics.vim'
  
  " Markdown
  Plug 'vim-pandoc/vim-pandoc'
  Plug 'vim-pandoc/vim-pandoc-syntax'

  " Latex
  Plug 'lervag/vimtex'

  " Python
  Plug 'vimjas/vim-python-pep8-indent', {'for': 'python'}
  Plug 'vim-scripts/python.vim--Herzog', {'for': 'python'}
  Plug 'sakhnik/nvim-gdb', {'for': 'python'}
  Plug '5long/pytest-vim-compiler', {'for': 'python'}

  " QML
  Plug 'peterhoeg/vim-qml'

  " typescript
  Plug 'leafgarland/typescript-vim'

  " Natural
  Plug 'voldikss/vim-translate-me'

  " glsl
  Plug 'tikhomirov/vim-glsl'

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
" fzf search in description of snippets
command! -bar -bang Snippets call fzf#vim#snippets({'options': '-n ..'}, <bang>0)
if has_key(g:plugs, 'fzf.vim')
  imap <c-x><c-f> <plug>(fzf-complete-path)
endif
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

" -header-insertion-decorators=false remove leading space from clangd completion
let g:LanguageClient_serverCommands = {
      \ 'python': ['pyls'],
      \ 'cpp': ['clangd', '-header-insertion-decorators=false'],
      \ 'c': ['clangd', '-header-insertion-decorators=false'],
      \ 'typescript': ['typescript-language-server', '--stdio'],
      \ 'tex': ['texlab', '-vvv']
      \ }

" Automatically start language servers.
let g:LanguageClient_settingsPath = ".vim/settings.json"
let g:LanguageClient_loadSettings = 1
let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsList = "Location"
let g:LanguageClient_useFloatingHover = 1
let g:LanguageClient_windowLogMessageLevel = 'LOG'
let g:LanguageClient_loggingFile = expand('/tmp/LanguageClient.log')
let g:LanguageClient_loggingLevel = 'INFO'

nnoremap <silent> <leader>jh :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> <leader>jd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <leader>js :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <silent> <leader>jr :call LanguageClient_textDocument_references()<CR>
nnoremap <silent> <leader>jw :call LanguageClient_workspace_symbol()<CR>
nnoremap <silent> <leader>jc :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> <leader>jz :call LanguageClient_contextMenu()<CR>
" }}}

" ncm2 configuration {{{
" enable ncm2 for all buffers
if has('nvim')
  autocmd BufEnter * call ncm2#enable_for_buffer()
endif
set completeopt=noinsert,menuone,noselect
" The parameters are the same as `:help feedkeys()`
" Use <CR> to expand lsp snippets
if has('nvim')
  inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
endif
" }}}

" Status-line configuration {{{
function! QuickfixNumberEntry()
  let qflist = getqflist()
  if len(qflist)
    let num_valid_entry = 0
    for line in qflist
      let num_valid_entry = num_valid_entry + line['valid']
    endfor
    if num_valid_entry > 0
      return 'qf=' . num_valid_entry
    else
      return ''
    endif
  else
    return ''
  endif
endfunction

function! LocationlistNumberEntry()
  let loclist = getloclist(winnr())
  if len(loclist)
    let num_valid_entry = 0
    for line in loclist
      let num_valid_entry = num_valid_entry + line['valid']
    endfor
    if num_valid_entry > 0
      return 'loc=' . num_valid_entry
    else
      return ''
    endif
  else
    return ''
  endif
endfunction

function! SpelllangEntry()
  return &spelllang
endfunction

augroup quickloc
  autocmd!
  autocmd User Flags call Hoist('buffer', 6, 'SpelllangEntry')
  autocmd User Flags call Hoist('buffer', 7, 'QuickfixNumberEntry')
  autocmd User Flags call Hoist('buffer', 8, 'LocationlistNumberEntry')
augroup END
" }}}

" latex-box configuration {{{
let g:tex_flavor = "latex"
"let g:LatexBox_latexmk_async = 1
"let g:LatexBox_latexmk_preview_continuously = 1
"let g:LatexBox_latexmk_options = "-pdflatex='pdflatex -synctex=1'"
"let g:LatexBox_output_type = "pdf"
"let g:LatexBox_quickfix = 4
" }}}

" vimtex configuration {{{
let g:vimtex_fold_enabled = 1
let g:vimtex_fold_types = {
      \ 'envs' : {'blacklist': ['itemize', 'figure', 'table', 'enumerate']},
      \}
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
"if exists("*ncm2#enable_for_buffer")
  "augroup my_cm_setup
    "autocmd!
    "autocmd BufEnter * call ncm2#enable_for_buffer()
    "autocmd Filetype tex call ncm2#register_source({
            "\ 'name' : 'vimtex-cmds',
            "\ 'priority': 8, 
            "\ 'complete_length': -1,
            "\ 'scope': ['tex'],
            "\ 'matcher': {'name': 'prefix', 'key': 'word'},
            "\ 'word_pattern': '\w+',
            "\ 'complete_pattern': g:vimtex#re#ncm2#cmds,
            "\ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
            "\ })
    "autocmd Filetype tex call ncm2#register_source({
            "\ 'name' : 'vimtex-labels',
            "\ 'priority': 8, 
            "\ 'complete_length': -1,
            "\ 'scope': ['tex'],
            "\ 'matcher': {'name': 'combine',
            "\             'matchers': [
            "\               {'name': 'substr', 'key': 'word'},
            "\               {'name': 'substr', 'key': 'menu'},
            "\             ]},
            "\ 'word_pattern': '\w+',
            "\ 'complete_pattern': g:vimtex#re#ncm2#labels,
            "\ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
            "\ })
    "autocmd Filetype tex call ncm2#register_source({
            "\ 'name' : 'vimtex-files',
            "\ 'priority': 8, 
            "\ 'complete_length': -1,
            "\ 'scope': ['tex'],
            "\ 'matcher': {'name': 'combine',
            "\             'matchers': [
            "\               {'name': 'abbrfuzzy', 'key': 'word'},
            "\               {'name': 'abbrfuzzy', 'key': 'abbr'},
            "\             ]},
            "\ 'word_pattern': '\w+',
            "\ 'complete_pattern': g:vimtex#re#ncm2#files,
            "\ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
            "\ })
    "autocmd Filetype tex call ncm2#register_source({
            "\ 'name' : 'bibtex',
            "\ 'priority': 8, 
            "\ 'complete_length': -1,
            "\ 'scope': ['tex'],
            "\ 'matcher': {'name': 'combine',
            "\             'matchers': [
            "\               {'name': 'prefix', 'key': 'word'},
            "\               {'name': 'abbrfuzzy', 'key': 'abbr'},
            "\               {'name': 'abbrfuzzy', 'key': 'menu'},
            "\             ]},
            "\ 'word_pattern': '\w+',
            "\ 'complete_pattern': g:vimtex#re#ncm2#bibtex,
            "\ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
            "\ })
  "augroup END
"endif
" }}}

" vim-argwrap configuration {{{
nnoremap <leader>a :ArgWrap<CR>
" }}}

" vim-grammarous configuration {{{
let g:grammarous#use_vim_spelllang=1
let g:grammarous#languagetool_cmd = 'languagetool'
let g:grammarous#disabled_rules = {
            \ 'pandoc' : ['FRENCH_WHITESPACE'],
            \ }
" }}}

" double-tap configuration {{{
let g:loaded_doubletap = 1
" }}}

" vim-osc52 configuration {{{
xmap <F7> y:call SendViaOSC52(getreg('"'))<cr>
" }}}

" Termdebug configuration {{{
let g:termdebug_useFloatingHover = 1
" }}}

" vim-translate-me configuration {{{
let g:vtm_default_to_lang = 'ko'
let g:vtm_popup_window = 'floating'
let g:vtm_default_mapping = 0
" Type <Leader>t to translate the text under the cursor, print in the cmdline
nnoremap <Leader>t :TranslateW<CR>
vnoremap <Leader>t :<C-U>call vtm#TranslateV("complex")<CR>
nnoremap <Leader>r :TranslateR<CR>
" }}}

" nvim-gdb configuration {{{
let g:nvimgdb_disable_start_keymaps = 1
let g:nvimgdb_config_override = {
  \ 'key_until':      '<f6>',
  \ 'key_continue':   '<f5>',
  \ 'key_next':       '<f8>',
  \ 'key_step':       '<f7>',
  \ 'key_finish':     '<f12>',
  \ 'key_breakpoint': 'B',
  \ 'key_eval':       'K',
  \ 'split_command': 'vsplit'
  \ }
" }}}

" suda.vim configuration {{{
let g:suda_smart_edit = 1
" }}}

" vimspector configuration {{{
let g:vimspector_enable_mappings = 'HUMAN'
"}}}

" nvim-dap configuration {{{
if has('nvim')
lua << EOF
local dap = require('dap')
dap.adapters.python = {
  type = 'executable';
  command = 'python';
  args = { '-m', 'debugpy.adapter' };
}
dap.adapters.cpp = {
  type = 'executable',
  attach = {
    pidProperty = "pid",
    pidSelect = "ask"
  },
  command = 'lldb-vscode', -- my binary was called 'lldb-vscode-11'
  env = {
    LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
  },
  name = "lldb"
}
EOF

lua << EOF
local dap = require('dap')
dap.configurations = {
  python = {
    type = 'python';
    request = 'launch';
    name = "Launch file";
    program = "${file}";
    cwd = vim.fn.getcwd();
    pythonPath = 'python';
    args = { 'ressources/needed_data.csv', '--output', 'ressources/reject_ratio.tex', 'reject_ratio' };
  },
}
EOF

lua << EOF
--local dap = require('dap')
--for k, v in pairs(dap.adapters) do
--  print(k)
--end
--for k, v in pairs(dap.configurations) do
--  print(k)
--end
EOF
endif
" }}}

augroup cutecat
   autocmd!
   autocmd VimEnter * echo ">^.^<"
augroup END
