set nocompatible

" Vimscript default vimrc settings {{{
set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
" }}}

"Pathogen {{{
let g:pathogen_disabled = []
if !has('gui_running')
  call add(g:pathogen_disabled, 'vim-airline')
  call add(g:pathogen_disabled, 'seoul256.vim')
endif
execute pathogen#infect()
filetype plugin indent on
syntax on
" }}}

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
  set undodir=$HOME/.vim/undo//
  set backupdir=$HOME/.vim/backup//
  set directory=$HOME/.vim/swp//
endif
" }}}

" folding settings {{{
augroup ft
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType vim setlocal foldlevel=0
  autocmd FileType cpp setlocal foldmethod=syntax
  autocmd FileType cpp setlocal foldlevel=2
augroup END
" }}}

"gvim configuration {{{
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
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

"Highlight group {{{
augroup colorScheme
   autocmd!
   autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
augroup END
" }}}

" font settings {{{
if has("win32")
  set guifont=Consolas_for_Powerline_FixedD:b:h9
else
  set guifont=Consolas\ for\ Powerline\ 9
endif
" }}}

"personal map command {{{
set fenc=utf-8
set encoding=utf-8
let mapleader="ù"
" Escape
inoremap jk <Esc>
inoremap kj <Esc>
" Move up a line
noremap <leader>_ ddkP
" Move down a line
noremap <leader>- ddp
" Replace " by '
noremap <leader>' :s/"/'/g<cr>``
" Replace ' by "
noremap <leader>" :s/'/"/g<cr>``
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
noremap / /\v
noremap ? ?\v
" Remove search highlight
noremap <leader>h :nohlsearch<cr>
nnoremap <leader>n :cnext<cr>
nnoremap <leader>N :cprevious<cr>
" Personnal F1-12 mapping {{{
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
" }}}
" You Complete Me map {{{
nnoremap <leader>jd :YcmCompleter GoTo<CR>
" }}}
" Switching split with alt
nnoremap <a-l> :wincmd l<CR>
nnoremap <a-k> :wincmd k<CR>
nnoremap <a-j> :wincmd j<CR>
nnoremap <a-h> :wincmd h<CR>
" }}}
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
set spell
if has('gui_running')
  set cursorcolumn
  set cursorline
endif
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

" Cscope configuration {{{
augroup filetype_vim
    autocmd!
    autocmd FileType cpp cs add c:\Vim\cscope\libtools.out E:\Documents\GitHub\libtools
    autocmd FileType cpp cs add c:\Vim\cscope\Millenium-Player.out E:\Documents\GitHub\Millenium-Player
augroup END
" }}}

" omnicppcomplete options {{{
set tags+=$VIM/ctags/commontags

" --- OmniCppComplete ---

" -- optional --
" auto close options when exiting insert mode or moving away
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif
set completeopt=menu,menuone

" -- configs --
let OmniCpp_MayCompleteDot = 1 " autocomplete with .
let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
let OmniCpp_SelectFirstItem = 2 " select first item (but don't insert)
let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files
let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype (i.e. parameters) in popup window
let OmniCpp_LocalSearchDecl = 1 " don't require special style of function opening braces

" -- ctags --
" map +F12 to generate ctags for current folder:
nnoremap <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .
" add current directory's generated tags file to available tags
set tags+=./tags
" }}}

"Set Color Scheme and Font Options {{{
silent! colorscheme solarized
" Unified color scheme (default: dark)
let g:seoul256_background = 233
" silent! colorscheme seoul256
" Light color scheme
"silent! colorscheme seoul256-light
" Switch
set background=dark
"set background=light
" }}}

" cpp enhanced highlight {{{
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1
" }}}

"DoxygenToolkit configuration {{{
let g:DoxygenToolkit_briefTag_pre="@brief "
let g:DoxygenToolkit_paramTag_pre="@param "
let g:DoxygenToolkit_returnTag="@return 0 if everything is fine, else an error code"
let g:DoxygenToolkit_blockHeader="-----------------------------------------------------------"
let g:DoxygenToolkit_blockFooter="-----------------------------------------------------------"
let g:DoxygenToolkit_authorName="Thomas Choi"
let g:DoxygenToolkit_licenseTag="My own license"
" }}}

"airline configuration {{{
if !exists('g:airline_symbols')
   let g:airline_symbols = {}
endif
set encoding=utf-8
set fileencoding=utf-8
let g:airline_powerline_fonts = 1
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'
let g:airline_exclude_preview = 1
let g:airline_theme= 'luna'
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_b = '%{strftime("%c")}'
" }}}

" Colors of CtrlSpace for Solarized Dark {{{
if !has('gui_running')
  hi CtrlSpaceSelected term=reverse ctermfg=187  ctermbg=23  cterm=bold
  hi CtrlSpaceNormal   term=NONE    ctermfg=244  ctermbg=232 cterm=NONE
  hi CtrlSpaceSearch   ctermfg=220  ctermbg=NONE cterm=bold
  hi CtrlSpaceStatus   ctermfg=230  ctermbg=234  cterm=NONE
  " Based on Solarized TablineSel {{{
  "hi CtrlSpaceSelected guifg=#586e75 guibg=#eee8d5 guisp=#839496 gui=reverse,bold ctermfg=10 ctermbg=7 cterm=reverse,bold

  "" Based on Solarized Tabline/TablineFill
  "" original Normal
  "" hi CtrlSpaceNormal   guifg=#839496 guibg=#073642 guisp=#839496 gui=NONE ctermfg=12 ctermbg=0 cterm=NONE
  "" tweaked Normal with darker background in Gui
  "hi CtrlSpaceNormal   guifg=#839496 guibg=#021B25 guisp=#839496 gui=NONE ctermfg=12 ctermbg=0 cterm=NONE

  "" Based on Title
  "hi CtrlSpaceSearch   guifg=#cb4b16 guibg=NONE gui=bold ctermfg=9 ctermbg=NONE term=bold cterm=bold

  "" Based on PmenuThumb
  "hi CtrlSpaceStatus   guifg=#839496 guibg=#002b36 gui=reverse term=reverse cterm=reverse ctermfg=12 ctermbg=8
  " }}}
endif
" }}}

"ctrl-space configuration {{{
let g:ctrlspace_unicode_font = 1
" unicode {{{
if g:ctrlspace_unicode_font
  let g:ctrlspace_symbols = {
        \ "cs":      "#",
        \ "tab":     "∙",
        \ "all":     "፨",
        \ "file":    "☉",
        \ "tabs":    "○",
        \ "c_tab":   "●",
        \ "load":    "|✠|",
        \ "save":    "[✠]",
        \ "zoom":    "☯",
        \ "s_left":  "›",
        \ "s_right": "‹",
        \ "bm":      "♥",
        \ "help":    "?",
        \ "iv":      "☆",
        \ "ia":      "★",
        \ "im":      "+",
        \ "dots":    "…"
        \ }
else
   let g:ctrlspace_symbols = {
            \ "cs":      "#",
            \ "tab":     "TAB",
            \ "all":     "ALL",
            \ "file":    "FILE",
            \ "tabs":    "-",
            \ "c_tab":   "+",
            \ "load":    "|::|",
            \ "save":    "[::]",
            \ "zoom":    "*",
            \ "s_left":  "[",
            \ "s_right": "]",
            \ "bm":      "BM",
            \ "help":    "?",
            \ "iv":      "-",
            \ "ia":      "*",
            \ "im":      "+",
            \ "dots":    "..."
            \ }
endif
"}}}
" }}}

" vim shell plugin configuration {{{
let g:shell_fullscreen_always_on_top = 0
" }}}

" You Complete Me Configuration {{{
let g:ycm_global_ycm_extra_conf = 'C:\Users\thomas\.ycm_extra_conf.py'
let g:ycm_filetype_whitelist = { 'cpp': 1, 'python': 1 }
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_confirm_extra_conf = 0
" }}}

" UltiSnips You Complete Me Association {{{
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<s-c-j>"
" }}}

" Easy Align Configuration {{{
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" color_coded Configuration {{{
let g:color_coded_enabled = 1
" }}}

" clighter configuration {{{
let g:clighter_libclang_file = 'libclang.dll'
" }}}

" pandoc syntax {{{
augroup pandoc_syntax
  au! BufNewFile,BufFilePRe,BufRead *.md set filetype=markdown.pandoc
augroup END
" }}}

" To enable the saving and restoring of screen positions. {{{
let g:screen_size_restore_pos = 1

" To save and restore screen for each Vim instance.
" This is useful if you routinely run more than one Vim instance.
" For all Vim to use the same settings, change this to 0.
let g:screen_size_by_vim_instance = 1

" function for restoring screen position
if has("gui_running")
   function! ScreenFilename()
      if has('amiga')
         return "s:.vimsize"
      elseif has('win32')
         return $HOME.'\_vimsize'
      else
         return $HOME.'/.vimsize'
      endif
   endfunction

   function! ScreenRestore()
      " Restore window size (columns and lines) and position
      " from values stored in vimsize file.
      " Must set font first so columns and lines are based on font size.
      let f = ScreenFilename()
      if has("gui_running") && g:screen_size_restore_pos && filereadable(f)
         let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
         for line in readfile(f)
            let sizepos = split(line)
            if len(sizepos) == 5 && sizepos[0] == vim_instance
               silent! execute "set columns=".sizepos[1]." lines=".sizepos[2]
               silent! execute "winpos ".sizepos[3]." ".sizepos[4]
               return
            endif
         endfor
      endif
   endfunction

   function! ScreenSave()
      " Save window size and position.
      if has("gui_running") && g:screen_size_restore_pos
         let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
         let data = vim_instance . ' ' . &columns . ' ' . &lines . ' ' .
                  \ (getwinposx()<0?0:getwinposx()) . ' ' .
                  \ (getwinposy()<0?0:getwinposy())
         let f = ScreenFilename()
         if filereadable(f)
            let lines = readfile(f)
            call filter(lines, "v:val !~ '^" . vim_instance . "\\>'")
            call add(lines, data)
         else
            let lines = [data]
         endif
         call writefile(lines, f)
      endif
   endfunction

   if !exists('g:screen_size_restore_pos')
      let g:screen_size_restore_pos = 1
   endif
   if !exists('g:screen_size_by_vim_instance')
      let g:screen_size_by_vim_instance = 1
   endif
   augroup restore_pos
   autocmd!
   autocmd VimEnter * if g:screen_size_restore_pos == 1 | call ScreenRestore() | endif
   autocmd VimLeavePre * if g:screen_size_restore_pos == 1 | call ScreenSave() | endif
   augroup END
endif
" }}}

augroup cutecat
   autocmd!
   autocmd VimEnter * echo ">^.^<"
augroup END
