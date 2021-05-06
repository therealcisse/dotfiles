" usage:
" nnoremap <silent> g<c-o> :call tweak#enhance_jumps#buffer_c_o()<CR>
" nnoremap <silent> g<c-i> :call tweak#enhance_jumps#buffer_c_i()<CR>

func! tweak#enhance_jumps#init()
  augroup tweak_enhance_jumps
    " this one is which you're most likely to use?
    autocmd BufWritePost * let b:_tweak_enhance_jumps_modified = 1
  augroup end
endfunc

" this key will close the buffer if it is never modified since vim start
func! tweak#enhance_jumps#buffer_c_o()
  let l:buf = bufnr('%')
  let l:modified = s:modified()
  while bufnr('%') == l:buf
    silent! call feedkeys("\<c-o>","x")
    redir => l:jumps
    silent jumps
    redir END
    if split(l:jumps,"\n")[1][0]==">"
      echom 'no more jumps!'
      return
    endif
  endwhile
  " no need to keep the buffer
  if l:modified == 0
    silent! execute "bd " .  l:buf
  endif
endfunc

" func! tweak#enhance_jumps#buffer_c_i()
"   let l:buf = bufnr('%')
"   while bufnr('%') == l:buf
"     silent! call feedkeys("\<c-i>","x")
"     redir => l:jumps
"     silent jumps
"     redir END
"     let l:splitted = split(l:jumps,"\n")
"     let l:len = len(l:splitted)
"     if l:splitted[l:len-1][0] == ">"
"       echom 'no more jumps!'
"       return
"     endif
"   endwhile
" endfunc

func s:modified()
  return get(b:,'_tweak_enhance_jumps_modified',&modified)
endfunc

