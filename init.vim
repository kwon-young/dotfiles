filetype indent plugin on
syntax on

"Personal Settings.
" Change directory for swp, undo and backup file {{{
set undofile
set backup
augroup backup_file
   autocmd!
   autocmd BufWritePre * let &backupext=substitute(expand("%:p"), ":\\=\\", "%%", "g")
augroup END
if has("win32")
  set undodir=$HOME\vimfiles\_undo//
  set backupdir=$HOME\vimfiles\_backup//
  set directory=$HOME\vimfiles\_swp//
elseif has('nvim')
  set undodir=$HOME/.config/nvim/undo//
  set backupdir=$HOME/.config/nvim/backup//
  set directory=$HOME/.config/nvim/swp//
else
  set undodir=$HOME/.vim/undo//
  set backupdir=$HOME/.vim/backup//
  set directory=$HOME/.vim/swp//
endif
" }}}

" folding settings {{{
augroup ft
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
  "autocmd FileType vim setlocal foldlevel=0
  autocmd FileType cpp setlocal foldmethod=syntax
  "autocmd FileType cpp setlocal foldlevel=2
augroup END
set foldlevel=999
" }}}

" Terminal settings {{{
if has('nvim')
  augroup terminal
    autocmd!
    autocmd TermOpen * setlocal nospell
  augroup END
  if !has('win32')
    set shell=zsh
  endif
endif
" }}}

" Exclude qf from buflist {{{
augroup qf
    autocmd!
    autocmd FileType qf set nobuflisted
augroup END
" }}}

"gvim configuration {{{
if has("gui_running")
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar
endif
" }}}

"personnal abbreviation {{{
iabbrev unsinged unsigned
iabbrev Egien Eigen
iabbrev unsi unsigned
iabbrev KYC Kwon-Young Choi
iabbrev @@ kwon-young.choi@hotmail.fr
iabbrev @@e k1choi@enib.fr
iabbrev ssig -- <cr>Kwon-Young Choi<cr>kwon-young.choi@hotmail.fr
iabbrev lambda Î»
iabbrev lpro Î»Prolog
iabbrev lPro Î»Prolog
" }}}

"personal map command {{{
let mapleader="ù"
" Escape
inoremap jk <Esc>
inoremap kj <Esc>
" Move up a line
nnoremap <leader>_ ddkP
" Move down a line
nnoremap <leader>- ddp
" Replace " by '
nnoremap <leader>' :s/"/'/g<cr>``
" Replace ' by "
nnoremap <leader>" :s/'/"/g<cr>``
" U command in insert mode
inoremap <a-u> <esc>viw~ea
"Edit and source vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" Add ; at the end of line
nnoremap <leader>; mqA;<esc>`q
" Show/unshow trailing space
nnoremap <leader>w :match ExtraWhiteSpace /\v\s+$/<cr>
nnoremap <leader>W :match none<cr>
" Add very magic to search command
nnoremap / /\v
nnoremap ? ?\v
" Remove search highlight
noremap <leader>h :nohlsearch<cr>
nnoremap <leader>n :cnext<cr>
nnoremap <leader>N :cprevious<cr>
" delete buffer without deleting split
nnoremap <leader>d :bp\|bd #<cr>
" exit insert mode in terminal
if has('nvim')
  tnoremap jk <C-\><C-n>
  tnoremap kj <C-\><C-n>
  tnoremap <Esc> <C-\><C-n>
endif
" Personnal F1-12 mapping {{{
" nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
" }}}
" You Complete Me map {{{
nnoremap <leader>jd :YcmCompleter GoTo<CR>
" }}}

" Switching split with alt {{{
nnoremap <a-l> :wincmd l<CR>
nnoremap <a-k> :wincmd k<CR>
nnoremap <a-j> :wincmd j<CR>
nnoremap <a-h> :wincmd h<CR>
if has('nvim')
  tnoremap <A-h> <C-\><C-n><C-w>h
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l
endif
" }}}
" Cycling through buffer
nnoremap <Tab> :bnext<CR>:redraw<CR>
nnoremap <S-Tab> :bprevious<CR>:redraw<CR>
" scroll with alt
nnoremap <a-f> <c-e>j
nnoremap <a-d> <c-y>k
" remap CTRL-O to ALT-O
inoremap <a-o> <c-o>
" visual mode swapping
vnoremap <C-X> <Esc>`.``gvP``P
" }}}

"set line no, buffer, search, highlight, autoindent and more. {{{
set fenc=utf-8
if !has('nvim')
  set encoding=utf-8
endif
set nu
set hidden
set ignorecase
set incsearch
set hlsearch
set smartcase
set showmatch
set autoindent
set ruler
set showcmd
set mouse=a
set history=1000
set undolevels=1000
set relativenumber
let loaded_spellfile_plugin=0
set spell spelllang=en_us
set spell
set tabstop=2
set shiftwidth=2
set expandtab
set number
set relativenumber
set grepprg=grep
set backspace=2
set noerrorbells
set scrolloff=2
" }}}

" markdown settings {{{
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
let g:markdown_fenced_languages = ['matlab', 'cpp']
" }}}

"Set the status line options. Make it show more information. {{{
set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
" }}}

" vim-plug configuration {{{
if has('nvim')
  call plug#begin('~/.vim/plugged')
else
  call plug#begin()
endif
" appearance
Plug 'junegunn/seoul256.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" file system
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-ctrlspace/vim-ctrlspace'

" git
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'

" text editing
Plug 'thinca/vim-visualstar'
Plug 'godlygeek/tabular'

" terminal
Plug 'kassio/neoterm'

" language
" generic
Plug 'Valloric/YouCompleteMe', { 'for': ['cpp', 'c', 'python'] }
autocmd! User YouCompleteMe call youcompleteme#Enable()
Plug 'scrooloose/nerdcommenter'
Plug 'benekastah/neomake'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"Plug 'vim-scripts/LanguageTool'

" Lua
Plug 'xolox/vim-lua-ftplugin'
" dependency of vim-lua-ftplugin
Plug 'xolox/vim-misc'

" cpp
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'critiqjo/lldb.nvim'
if !has('nvim')
  Plug 'jeaye/color_coded'
endif

" python
"Plug 'jmcantrell/vim-virtualenv'
"Plug 'bfredl/nvim-ipy'
Plug 'klen/python-mode'

" markdown
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
call plug#end()
" }}}

"Set Color Scheme and Font Options {{{
" silent! colorscheme solarized
" Unified color scheme (default: dark)
let g:seoul256_background = 233
silent! colorscheme seoul256
" Light color scheme
"silent! colorscheme seoul256-light
" Switch
set background=dark
"set background=light

" Neovim-qt Guifont command
if has('nvim')
  command! -nargs=? Guifont call rpcnotify(0, 'Gui', 'SetFont', "<args>") | let g:Guifont="<args>"
endif

if has("win32") && has('nvim')
  Guifont Consolas\ for\ Powerline\ FixedD:h10
elseif has('win32') && !has('nvim')
  silent set guifont=Consolas_for_Powerline_FixedD:h10
elseif has('nvim')
  Guifont Inconsolata\ for\ Powerline:h10
else
  set guifont=Inconsolata\ for\ Powerline\ 10
endif
" }}}

"airline configuration {{{
if !exists('g:airline_symbols')
   let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
if has('win32')
  let g:airline_left_sep = '⮀'
  let g:airline_left_alt_sep = '⮁'
  let g:airline_right_sep = '⮂'
  let g:airline_right_alt_sep = '⮃'
  let g:airline_symbols.branch = '⭠'
  let g:airline_symbols.readonly = '⭤'
  let g:airline_symbols.linenr = '⭡'
else
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif
let g:airline_exclude_preview = 1
let g:airline_theme= 'simple'
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
"let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline_section_b = '%{strftime("%c")}'
"if exists('g:airline_section_b')
  "let g:airline_section_b = airline#section#create('%{virtualenv#statusline()}')
"endif
" }}}

" You Complete Me Configuration {{{
"let g:ycm_filetype_whitelist = { 'cpp': 1, 'python': 1 }
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_confirm_extra_conf = 0
" }}}

" UltiSnips You Complete Me Association {{{
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<s-c-j>"
" }}}

" virtualenv config {{{
let g:virtualenv_directory = '~'
" }}}

augroup cutecat
   autocmd!
   autocmd VimEnter * echo ">^.^<"
augroup END

" vim-lua-ftplugin configuration {{{
" This sets the default value for all buffers.
let g:lua_interpreter_path = '/udd/kchoi/torch/install/bin/qlua'
let g:lua_internal = 0
let g:lua_complete_omni = 0
" }}}

" CtrlSpace Configuration {{{
let g:CtrlSpaceSetDefaultMapping = 1
let g:CtrlSpaceDefaultMappingKey = "<C-Space>"
" }}}

" python-mode configuration {{{

" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 0

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 1

" Python indentation
let g:pymode_indent = 1
" }}}

" Neoterm configuration {{{
"let g:neoterm_automap_keys = ',tt'
"set statusline+=%#NeotermTestRunning#%{neoterm#test#status('running')}%*
"set statusline+=%#NeotermTestSuccess#%{neoterm#test#status('success')}%*
"set statusline+=%#NeotermTestFailed#%{neoterm#test#status('failed')}%*
let g:neoterm_keep_term_open = 0
function! GetRepl()
  if &filetype == 'lua'
    return 'th'
  elseif &filetype == 'python'
    return 'python'
  endif
endfunction

function! RunFileInTerm()
  execute ':w'
  execute ':T ' . GetRepl() . ' %'
endfunction

function! RunReplInTerm()
  execute ":T " . GetRepl()
endfunction

function! GoToTerm()
  execute bufwinnr(bufname("neoterm")) . "wincmd w"
endfunction
function! InsertInTerm()
  execute ":Topen"
  call GoToTerm()
  execute "normal! a"
endfunction
function! InsertInRepl()
  execute ":Topen"
  execute ":T " . GetRepl()
  call GoToTerm()
  execute "normal! a"
endfunction

nnoremap <leader>tf :call RunFileInTerm()<CR>
nnoremap <leader>tc :Tclose<CR>
nnoremap <leader>to :Topen<CR>
nnoremap <leader>tr :call InsertInRepl()<CR>
nnoremap <leader>ti :call InsertInTerm()<CR>
" }}}
