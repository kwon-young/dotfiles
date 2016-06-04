filetype plugin indent on
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
    autocmd TermOpen * setlocal nospell
  augroup END
  if !has('win32')
    set shell=zsh
  endif
endif
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
let maploca=","
let mapleader="ù"
inoremap Ñ <NOP>
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
  tnoremap <Esc> <C-\><C-n>
endif
" Personnal F1-12 mapping {{{
" nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
nnoremap <F5> :NeomakeSh make<CR>
nnoremap <F4> :NeomakeSh cd build && cmake ..<CR>
" }}}
" You Complete Me map {{{
nnoremap <leader>jd :YcmCompleter GoTo<CR>
" }}}
" LanguageTool {{{
nnoremap <leader>g :LanguageToolCheck<CR>
vnoremap <leader>g :LanguageToolCheck<CR>
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
"nnoremap <a-f> <c-e><c-e>jj
"nnoremap <a-d> <c-y><c-y>kk
nnoremap <a-f> <c-e><c-e>
nnoremap <a-d> <c-y><c-y>
" remap CTRL-O to ALT-O
inoremap <a-o> <c-o>
" Neoterm mapping {{{
let g:projectname = 'MyProject'
nnoremap <leader>tt :Ttoggle<CR>
nnoremap <leader>tr :execute join(["T ./", g:projectname], "")<CR>
nnoremap <leader>tc :Tclose<CR>
" }}}
" fzf mapping
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>m :Marks<CR>
" }}}

"set line no, buffer, search, highlight, autoindent and more. {{{
set fenc=utf-8
if !has('nvim')
  set encoding=utf-8
endif
"if has('nvim')
  "set termguicolors
"endif
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
set scrolloff=4
set listchars=tab:>-,trail:-
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
Plug 'equalsraf/neovim-gui-shim'
" appearance
Plug 'junegunn/seoul256.vim'
Plug 'mhartington/oceanic-next'
Plug 'freeo/vim-kalisi'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" file system
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'junegunn/fzf', { 'dir': '~/.config/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" git
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'

" text editing
Plug 'thinca/vim-visualstar'
Plug 'godlygeek/tabular'

" language
" generic
Plug 'Valloric/YouCompleteMe', { 'for': ['cpp', 'c', 'python'] }
autocmd! User YouCompleteMe call youcompleteme#Enable()
Plug 'scrooloose/nerdcommenter'
Plug 'benekastah/neomake'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'vim-scripts/LanguageTool'
Plug 'xolox/vim-lua-ftplugin'
" dependency of vim-lua-ftplugin
Plug 'xolox/vim-misc'

" cpp
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'critiqjo/lldb.nvim'
"Plug 'gilligan/vim-lldb'
Plug 'octol/vim-cpp-enhanced-highlight'
if !has('nvim')
  Plug 'jeaye/color_coded'
else
  Plug 'bbchung/Clamp'
endif

" python
Plug 'jmcantrell/vim-virtualenv'
"Plug 'bfredl/nvim-ipy'

" markdown
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'rhysd/nyaovim-popup-tooltip'
Plug 'rhysd/nyaovim-markdown-preview'

" latex
Plug 'lervag/vimtex'

" neovim terminal
Plug 'kassio/neoterm'
call plug#end()
" }}}

"Set Color Scheme and Font Options {{{
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"silent! colorscheme kalisi
"silent! colorscheme OceanicNext
"silent! colorscheme solarized
" Unified color scheme (default: dark)
let g:seoul256_background = 233
silent! colorscheme seoul256
" Light color scheme
"silent! colorscheme seoul256-light
" Switch
set background=dark
set t_Co=256

" in case t_Co alone doesn't work, add this as well:
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"

" Neovim-qt Guifont command
if has('nvim')
  command! -nargs=? Guifont call rpcnotify(0, 'Gui', 'SetFont', "<args>") | let g:Guifont="<args>"
endif

if has("win32") && has('nvim')
  Guifont Consolas\ for\ Powerline\ FixedD:h10
elseif has('win32') && !has('nvim')
  set guifont=Consolas_for_Powerline_FixedD:h10
elseif has('nvim')
  GuiFont Inconsolata\ for\ Powerline:h10
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
"let g:airline_theme= 'simple'
let g:airline_theme='oceanicnext'
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
"let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline_section_b = '%{strftime("%c")}'
let g:airline#extensions#virtualenv#enabled = 1
if exists('g:airline_section_b')
  let g:airline_section_b = airline#section#create('%{virtualenv#statusline()}')
endif
" }}}

" You Complete Me Configuration {{{
let g:ycm_filetype_whitelist = { 'cpp': 1, 'python': 1, 'latex': 1}
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
let g:lua_complete_omni = 1
" }}}

" lldb.nvim Configuration {{{

"nmap <leader>lb <Plug>LLBreakSwitch
"vmap <F2> <Plug>LLStdInSelected
"nnoremap <F4> :LLstdin<CR>
"nnoremap <F5> :LLmode debug<CR>
"nnoremap <S-F5> :LLmode code<CR>
"nnoremap <leader>ld :LLmode debug<CR>
"nnoremap <leader>lr :LLmode code<CR>
"nnoremap <F8> :LL continue<CR>
"nnoremap <S-F8> :LL process interrupt<CR>
"nnoremap <F9> :LL print <C-R>=expand('<cword>')<CR>
"vnoremap <F9> :<C-U>LL print <C-R>=lldb#util#get_selection()<CR><CR>
" }}}

let g:clamp_autostart = 1
let g:clamp_libclang_file = '/usr/lib/libclang.so'
let g:clamp_compile_args = ['-DMyProjectLib_EXPORTS', '-DQT_CORE_LIB', '-DQT_GUI_LIB', '-DQT_NO_DEBUG', '-DQT_WIDGETS_LIB', '-I/home/kwon-young/prog/qt5-tutorial', '-I/tmp/tmpOlCxI1', '-isystem', '/usr/include/qt', '-isystem', '/usr/include/qt/QtCore', '-isystem', '/usr/include/qt/QtGui', '-isystem', '/usr/include/qt/QtWidgets', '-isystem', '/usr/lib/qt/mkspecs/linux-g++']
" }}}

" vimtex {{{
let g:tex_flavor = "latex"
if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = [
      \ 're!\\[A-Za-z]*cite[A-Za-z]*(\[[^]]*\]){0,2}{[^}]*',
      \ 're!\\[A-Za-z]*ref({[^}]*|range{([^,{}]*(}{)?))',
      \ 're!\\hyperref\[[^]]*',
      \ 're!\\includegraphics\*?(\[[^]]*\]){0,2}{[^}]*',
      \ 're!\\(include(only)?|input){[^}]*',
      \ 're!\\\a*(gls|Gls|GLS)(pl)?\a*(\s*\[[^]]*\]){0,2}\s*\{[^}]*',
      \ 're!\\includepdf(\s*\[[^]]*\])?\s*\{[^}]*',
      \ 're!\\includestandalone(\s*\[[^]]*\])?\s*\{[^}]*',
      \ ]
" }}}

" vim-pandoc {{{
let g:pandoc#modules#disabled = ["chdir"]
" }}}

" LanguageTool {{{
let g:languagetool_jar='/home/kwon-young/soft/languagetool/languagetool-standalone/target/LanguageTool-3.4-SNAPSHOT/LanguageTool-3.4-SNAPSHOT/languagetool-commandline.jar'

" }}}
