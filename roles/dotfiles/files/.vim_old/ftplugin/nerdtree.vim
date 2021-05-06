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

" Move up a directory using "-" like vim-vinegar (usually "u" does this).
nmap <buffer> <expr> - g:NERDTreeMapUpdir

