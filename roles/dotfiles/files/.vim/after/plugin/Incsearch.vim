" Incsearch

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

let g:incsearch#auto_nohlsearch = 1

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.

map n  <Plug>(incsearch-nohl-n)zzzv
map N  <Plug>(incsearch-nohl-N)zzzv

map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)

