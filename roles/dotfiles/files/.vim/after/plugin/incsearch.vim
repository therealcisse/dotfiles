" Incsearch

map /  <Plug>(incsearch-forward)\c\v
map ?  <Plug>(incsearch-backward)\c\v
map g/ <Plug>(incsearch-stay)

let g:incsearch#auto_nohlsearch = 1

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.

" Thanks to https://yuez.me/vim-ji-qiao/
" n always for searching down, N always for searching up
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

map n  <Plug>(incsearch-nohl-n)zzzv
map N  <Plug>(incsearch-nohl-N)zzzv

map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

let g:incsearch#magic = '\v' " very magic

