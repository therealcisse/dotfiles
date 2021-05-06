" Auto completion manager

" let g:asyncomplete_remove_duplicates = 1
"
" imap <C-Space> <Plug>(asyncomplete_force_refresh)
"
" au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
"     \ 'name': 'buffer',
"     \ 'whitelist': ['*'],
"     \ 'blacklist': ['go', 'java'],
"     \ 'completor': function('asyncomplete#sources#buffer#completor'),
"     \ }))
"
" au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
"     \ 'name': 'file',
"     \ 'whitelist': ['*'],
"     \ 'priority': 10,
"     \ 'completor': function('asyncomplete#sources#file#completor')
"     \ }))
"
" au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
"       \ 'name': 'ultisnips',
"       \ 'whitelist': ['*'],
"       \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
"       \ }))
