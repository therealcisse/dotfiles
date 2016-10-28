" ----------------------------------------------------------------------
" | CTRLP                                                              |
" ----------------------------------------------------------------------

let g:ctrlp_working_path_mode = 0

if executable("ag")
  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .DS_Store
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore node_modules
      \ --ignore logs
      \ --ignore out
      \ -g ""'

  let g:ackprg = 'ag --vimgrep --smart-case'
  cnoreabbrev ag Ack!

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

noremap <leader>b :CtrlPBuffer<CR>

let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:50,results:50'
let g:ctrlp_reuse_window = 'NERD_tree'
let g:ctrlp_max_files = 0

