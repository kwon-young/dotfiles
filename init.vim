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
else
  set undodir=$HOME/.config/nvim/undo//
  set backupdir=$HOME/.config/nvim/backup//
  set directory=$HOME/.config/nvim/swp//
endif
" }}}

" folding settings {{{
augroup ft
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType vim setlocal foldlevel=2
  autocmd FileType cpp setlocal foldmethod=syntax
  autocmd FileType cpp setlocal foldlevel=2
augroup END

" Terminal settings {{{
augroup terminal
  autocmd TermOpen * setlocal nospell
augroup END
" }}}
" }}}

"personnal abbreviation {{{
iabbrev unsinged unsigned
iabbrev Egien Eigen
iabbrev unsi unsigned
iabbrev KYC Kwon-Young Choi
iabbrev @@ kwon-young.choi@hotmail.fr
iabbrev @@e k1choi@enib.fr
iabbrev ssig -- <cr>Kwon-Young Choi<cr>kwon-young.choi@hotmail.fr
iabbrev lambda λ
iabbrev lpro λProlog
iabbrev lPro λProlog
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
inoremap <c-u> <esc>viw~ea
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
" exit insert mode in terminal
tnoremap jk <C-\><C-n>
tnoremap kj <C-\><C-n>
tnoremap <Esc> <C-\><C-n>
" Personnal F1-12 mapping {{{
" nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
" }}}
" You Complete Me map {{{
" nnoremap <leader>jd :YcmCompleter GoTo<CR>
" }}}
" Switching split with alt {{{
nnoremap <a-l> :wincmd l<CR>
nnoremap <a-k> :wincmd k<CR>
nnoremap <a-j> :wincmd j<CR>
nnoremap <a-h> :wincmd h<CR>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
" }}}
" Cycling through buffer
nnoremap <Tab> :bnext<CR>:redraw<CR>:ls<CR>
nnoremap <S-Tab> :bprevious<CR>:redraw<CR>:ls<CR>
" }}}

"set line no, buffer, search, highlight, autoindent and more. {{{
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
set spell spelllang=en_us
set spell
set tabstop=2
set shiftwidth=2
set expandtab
set showtabline=0
set number
set relativenumber
set grepprg=grep
set backspace=2
set noerrorbells
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
let g:markdown_fenced_languages = ['fsharp', 'matlab', 'cpp']
" }}}

"Set the status line options. Make it show more information. {{{
set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
" }}}

augroup cutecat
   autocmd!
   autocmd VimEnter * echo ">^.^<"
augroup END

" vim-plug configuration {{{
call plug#begin()
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'junegunn/seoul256.vim'
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
" Code to execute when the plugin is loaded on demand
Plug 'Valloric/YouCompleteMe'
autocmd! User YouCompleteMe call youcompleteme#Enable()
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
" Plug 'jeaye/color_coded'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'kongo2002/fsharp-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'critiqjo/lldb.nvim'
Plug 'benekastah/neomake'
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
command! -nargs=? Guifont call rpcnotify(0, 'Gui', 'SetFont', "<args>") | let g:Guifont="<args>"

Guifont Inconsolata:h11

" }}}

"airline configuration {{{
if !exists('g:airline_symbols')
   let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'
let g:airline_exclude_preview = 1
let g:airline_theme= 'simple'
let g:airline#extensions#tabline#enabled = 1
" let g:airline_section_b = '%{strftime("%c")}'
" }}}

" You Complete Me Configuration {{{
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_filetype_whitelist = { 'cpp': 1, 'python': 1 }
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_path_to_python_interpreter = ''
" }}}

" UltiSnips You Complete Me Association {{{
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<s-c-j>"
" }}}


