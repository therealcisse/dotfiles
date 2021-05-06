" Don't let built-in plug-in override our setting here.
let b:did_ftplugin=1

autocmd FileType qf wincmd J

if exists('+colorcolumn')
  setlocal colorcolumn=
endif

let b:undo_ftplugin = "setl fo< com< ofu<"

" text wrapping is pretty much useless in the quickfix window
setlocal wrap

" relative line numbers don't make much sense either
" but absolute numbers definitely do
setlocal norelativenumber
setlocal number

" we don't want quickfix buffers to pop up when doing :bn or :bp
" set nobuflisted

setlocal nolist

