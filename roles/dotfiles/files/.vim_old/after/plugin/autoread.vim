set autoread " if not changed in Vim, automatically pick up changes after "git checkout" etc
if &ttimeoutlen == -1 && &timeoutlen > 50 || &ttimeoutlen > 50
  set ttimeoutlen=50 " speed up O etc in the Terminal
endif

let g:AutoreadBlacklist = [
      \  'diff',
      \  'undotree',
      \  'nerdtree',
      \  'ctrlp',
      \  'qf',
      \  'list'
      \ ]

if has('autocmd')
  augroup CheckTimeOnFocus
    autocmd!
    autocmd FocusGained * if &modifiable && index(g:AutoreadBlacklist, &filetype) == -1 | silent! checktime | endif
  augroup END
endif

