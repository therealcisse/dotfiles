" ----------------------------------------------------------------------
" Startify
" ----------------------------------------------------------------------

let g:startify_enable_special         = 0
let g:startify_files_number           = 8
let g:startify_relative_path          = 1
let g:startify_change_to_dir          = 0
let g:startify_update_oldfiles        = 1
let g:startify_session_autoload       = 0
let g:startify_session_persistence    = 0
let g:startify_session_delete_buffers = 0

let g:startify_skiplist = [
      \ 'COMMIT_EDITMSG',
      \ '~/.config/nvim/init.vim'
      \ ]

let g:startify_bookmarks = [
      \ '~/.config/nvim/init.vim'
      \ ]

let g:startify_custom_footer =
      \ ['', "   Vim is charityware. Please read ':help uganda'.", '']

hi StartifyBracket ctermfg=240
hi StartifyFile    ctermfg=147
hi StartifyFooter  ctermfg=240
hi StartifyHeader  ctermfg=114
hi StartifyNumber  ctermfg=215
hi StartifyPath    ctermfg=245
hi StartifySlash   ctermfg=240
hi StartifySpecial ctermfg=240

