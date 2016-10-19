" text wrapping is pretty much useless here
setlocal nowrap

setlocal nolist
setlocal nonumber
setlocal norelativenumber
setlocal nocursorline

if exists('+colorcolumn')
  setlocal colorcolumn=
endif

if has('folding')
  setlocal nofoldenable
endif

" set nobuflisted

