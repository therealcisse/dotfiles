let s:INT = { 'MAX': 2147483647 }

let g:AmsaykBlacklistBufType = [
      \ 'nofil|e',
      \ 'nowrite',
      \ 'acwrite',
      \ 'quickfix',
      \ 'help'
      \ ]
let g:AmsaykNumberBlacklist = [
      \ 'diff',
      \ 'fugitiveblame',
      \ 'undotree',
      \ 'nerdtree',
      \ 'ctrlp',
      \ 'qf',
      \ 'startify',
      \ 'help',
      \ 'vim-plug',
      \ 'terminal',
      \ 'neoterm',
      \ 'list'
      \ ]
let g:AmsaykColorColumnBlacklist = [
      \ 'diff',
      \ 'fugitiveblame',
      \ 'undotree',
      \ 'nerdtree',
      \ 'ctrlp',
      \ 'qf',
      \ 'terminal',
      \ 'neoterm',
      \ 'list'
      \ ]
let g:AmsaykCursorlineBlacklist = ['ctrlp']
let g:AmsaykMkviewFiletypeBlacklist = [
  \ 'diff',
  \ 'gitcommit',
  \ 'hgcommit',
  \ 'list'
  \ ]

function! autocmds#escape_pattern(str) abort
  return escape(a:str, '~"\.^$[]*')
endfunction

function! autocmds#get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

function! autocmds#should_number() abort
  return index(g:AmsaykNumberBlacklist, &filetype) == -1 && index(g:AmsaykBlacklistBufType, &buftype) == -1
endfunction

function! autocmds#should_colorcolumn() abort
  return index(g:AmsaykColorColumnBlacklist, &filetype) == -1
endfunction

function! autocmds#should_cursorline() abort
  return index(g:AmsaykCursorlineBlacklist, &filetype) == -1
endfunction

" Loosely based on: http://vim.wikia.com/wiki/Make_views_automatic
function! autocmds#should_mkview() abort
  return
        \ &buftype == '' &&
        \ index(g:AmsaykMkviewFiletypeBlacklist, &filetype) == -1 &&
        \ !exists('$SUDO_USER') " Don't create root-owned files.
endfunction

function! autocmds#mkview() abort
  if exists('*haslocaldir') && haslocaldir()
    " We never want to save an :lcd command, so hack around it...
    cd -
    mkview
    lcd -
  else
    mkview
  endif
endfunction

" Loosely based on: http://vim.wikia.com/wiki/Make_views_automatic
function! autocmds#should_mkview() abort
  return
        \ &buftype == '' &&
        \ index(g:AmsaykMkviewFiletypeBlacklist, &filetype) == -1 &&
        \ !exists('$SUDO_USER') " Don't create root-owned files.
endfunction

function! autocmds#blur_window() abort
  if autocmds#should_colorcolumn()
    if !exists('w:amsayk_matches')
      " Instead of unconditionally resetting, append to existing array.
      " This allows us to gracefully handle duplicate autocmds.
      let w:amsayk_matches=[]
    endif
    let l:height=&lines
    let l:slop=l:height / 2
    let l:start=max([1, line('w0') - l:slop])
    let l:end=min([line('$'), line('w$') + l:slop])
    while l:start <= l:end
      let l:next=l:start + 8
      let l:id=matchaddpos(
            \   'LineNr',
            \   range(l:start, min([l:end, l:next])),
            \   0
            \ )
      call add(w:amsayk_matches, l:id)
      let l:start=l:next
    endwhile
  endif
endfunction

function! autocmds#focus_window() abort
  if autocmds#should_colorcolumn()
    if exists('w:amsayk_matches')
      for l:match in w:amsayk_matches
        try
          call matchdelete(l:match)
        catch /.*/
          " In testing, not getting any error here, but being ultra-cautious.
        endtry
      endfor
      let w:amsayk_matches=[]
    endif
  endif
endfunction

" Directories where we want to perform auto-encryption on save.
let s:encrypted={}
let s:encrypted[expand('~/dotfiles')]='vendor/git-cipher/bin/git-cipher'

" Update encryptable files after saving.
function! autocmds#encrypt(file) abort
  let l:base=fnamemodify(a:file, ':h')
  let l:directories=keys(s:encrypted)
  for l:directory in l:directories
    if stridx(a:file, l:directory) == 0
      let l:encrypted=l:base . '/.' . fnamemodify(a:file, ':t') . '.encrypted'
      if filewritable(l:encrypted) == 1
        let l:executable=l:directory . '/' . s:encrypted[l:directory]
        if executable(l:executable)
          call system(
                \   fnamemodify(l:executable, ':S') .
                \   ' encrypt ' .
                \   shellescape(a:file)
                \ )
        endif
      endif
      break
    endif
  endfor
endfunction

function! autocmds#attempt_select_last_file() abort
  let l:previous=expand('#:t')
  if l:previous != ''
    call search('\v<' . l:previous . '>')
  endif
endfunction

function! autocmds#idleboot() abort
  " Make sure we automatically call autocmds#idleboot() only once.
  augroup AmsaykIdleboot
    autocmd!
  augroup END

  " Make sure we run deferred tasks exactly once.
  doautocmd User AmsaykDefer
  autocmd! User AmsaykDefer
endfunction

