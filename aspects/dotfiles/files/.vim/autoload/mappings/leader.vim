function! mappings#leader#matchparen() abort
  " Preserve current window becaus {Do,No}MatchParen cycle with :windo.
  " let l:currwin=winnr()
  " if exists('g:loaded_matchparen')
  "   NoMatchParen
  " else
  "   DoMatchParen
  " endif
  " execute l:currwin . 'wincmd w'
endfunction

" Zap trailing whitespace.
function! mappings#leader#zap() abort
  let l:pos=getcurpos()
  let l:search=@/
  keepjumps %substitute/\s\+$//e
  let @/=l:search
  nohlsearch
  call setpos('.', l:pos)
endfunction

" Zap trailing whitespace.
function! mappings#leader#align() abort
  let l:pos=getcurpos()
  let l:search=@/
  keepjumps :normal =ae
  let @/=l:search
  nohlsearch
  call setpos('.', l:pos)
endfunction

