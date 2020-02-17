" reverse search with okular
" in okular custom editor setting
" 1st version
" nvr -c "drop %f | call cursor(%l, %c)"
" 2nd version: use fnameescape to deal with space in path
"              use execute to use drop and fnameescape together
" nvr -c "execute 'drop ' . fnameescape('%f') | call cursor(%l, %c)"

" forward search with okular
function! SyncTexForward()
  if !exists('g:main_pdf_file')
    let g:main_pdf_file = input('main pdf file: ', '', 'file')
    let g:main_pdf_file = fnamemodify(g:main_pdf_file, ':p')
    let g:main_pdf_file = fnameescape(g:main_pdf_file)
  endif
  let tex_file = fnameescape(expand("%:p"))
  let execstr = "silent !okular --unique " . g:main_pdf_file . "\\#src:" . line(".") . tex_file . " &"
  execute execstr
endfunction

nnoremap <Leader>jf :VimtexView<CR>
"nnoremap <Leader>jf :call SyncTexForward()<CR>
nnoremap <Leader>ji :VimtexInfo<CR>
nnoremap <Leader>jt :VimtexTocToggle<CR>
nnoremap <Leader>jC :VimtexClean<CR>
nnoremap <Leader>jc :VimtexCompile<CR>
nnoremap <Leader>js :VimtexStatus<CR>

" Remove : from being a word character
" Useful for label completion and manipulation
set iskeyword-=:

function! VirtualLatexSectionLevelClear()
  let namespace = nvim_create_namespace('section_level')
  call nvim_buf_clear_namespace(bufnr(), namespace, 0, -1)
  let b:vimtex_show_section_level = v:false
endfunction

function! VirtualLatexSectionLevelSet()
  let namespace = nvim_create_namespace('section_level')
  call nvim_buf_clear_namespace(bufnr(), namespace, 0, -1)
  if exists('b:vimtex')
    let file = bufname()
    if !has_key(b:vimtex['toc'], 'entries')
      call vimtex#toc#get_entries()
    endif
    for entry in b:vimtex['toc']['entries']
      if entry['type'] == 'content'
        if bufnr(entry['file']) == bufnr()
          let chunk = string(entry['number']['chapter'])
          if entry['number']['section'] != 0
            let chunk = chunk . '.' . entry['number']['section']
          endif
          if entry['number']['subsection'] != 0
            let chunk = chunk . '.' . entry['number']['subsection']
          endif
          if entry['number']['subsubsection'] != 0
            let chunk = chunk . '.' . entry['number']['subsubsection']
          endif
          call nvim_buf_set_virtual_text(bufnr(), namespace, entry['line'] - 1, [[chunk, 'VimtexTocNum']], {})
        endif
      endif
    endfor
  endif
  let b:vimtex_show_section_level = v:true
endfunction

function! VirtualLatexSectionLevelToggle()
  if has_key(b:, 'vimtex_show_section_level')
    if b:vimtex_show_section_level
      call VirtualLatexSectionLevelClear()
    else
      call VirtualLatexSectionLevelSet()
    endif
  else
    call VirtualLatexSectionLevelSet()
  endif
endfunction

nnoremap <Leader>jl :call VirtualLatexSectionLevelSet()<CR>
nnoremap <Leader>jL :call VirtualLatexSectionLevelToggle()<CR>
