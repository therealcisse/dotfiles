set autoread " if not changed in Vim, automatically pick up changes after "git checkout" etc
if &ttimeoutlen == -1 && &timeoutlen > 50 || &ttimeoutlen > 50
  set ttimeoutlen=50 " speed up O etc in the Terminal
endif

if has('autocmd')
  augroup CheckTimeOnFocus
    autocmd!
    autocmd FocusGained * checktime
  augroup END
endif

