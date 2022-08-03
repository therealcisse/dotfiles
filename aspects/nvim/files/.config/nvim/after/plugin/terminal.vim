
function! s:small_terminal() abort
  vsplit
  " wincmd J
  call nvim_win_set_width(0, 64)
  set winfixwidth
  term /opt/homebrew/bin/zsh
endfunction

" ANKI: Make a small terminal at the bottom of the screen.
nnoremap <leader>T :call <SID>small_terminal()<CR>i

" TODO: Make a floating terminal for one shot command?

