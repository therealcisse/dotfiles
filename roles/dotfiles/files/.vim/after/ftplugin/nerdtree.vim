setlocal nolist
setlocal nonumber
setlocal norelativenumber
setlocal nocursorcolumn

if exists('+colorcolumn')
  setlocal colorcolumn=
endif

if has('folding')
  setlocal nofoldenable
endif

