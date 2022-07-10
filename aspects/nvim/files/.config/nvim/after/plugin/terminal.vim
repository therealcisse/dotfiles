
function! s:small_terminal() abort
  new
  wincmd J
  call nvim_win_set_height(0, 12)
  set winfixheight
  term /usr/local/bin/zsh
  startinsert
endfunction

" ANKI: Make a small terminal at the bottom of the screen.
nnoremap <leader>T :call <SID>small_terminal()<CR>

" TODO: Make a floating terminal for one shot command?

