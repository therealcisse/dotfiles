let g:MyMkviewFiletypeBlacklist = [
  \ 'diff',
  \ 'gitcommit',
  \ 'hgcommit',
  \ 'list'
  \ ]

" Loosely based on: http://vim.wikia.com/wiki/Make_views_automatic
function! autocmds#should_mkview() abort
  return
        \ &buftype == '' &&
        \ index(g:MyMkviewFiletypeBlacklist, &filetype) == -1 &&
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


function! autocmds#idleboot() abort
  " Make sure we automatically call autocmds#idleboot() only once.
  augroup Idleboot
    au!
  augroup END

  " Make sure we run deferred tasks exactly once.
  doautocmd User MyDefer
  au! User MyDefer
endfunction
