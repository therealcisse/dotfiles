" " Language servers
"
" if executable('pyls')
"   " pip install python-language-server
"   au User lsp_setup call lsp#register_server({
"         \ 'name': 'pyls',
"         \ 'cmd': {server_info->['pyls']},
"         \ 'whitelist': ['python'],
"         \ })
" endif
"
" if executable('typescript-language-server')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'typescript-language-server',
"         \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
"         \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
"         \ 'whitelist': ['typescript'],
"         \ })
" endif
"
" if executable('go-langserver')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'go-langserver',
"         \ 'cmd': {server_info->['go-langserver', '-mode', 'stdio']},
"         \ 'whitelist': ['go'],
"         \ })
" endif
"
" if executable('dart_language_server')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'dart_language_server',
"         \ 'cmd': {server_info->['dart_language_server']},
"         \ 'whitelist': ['dart'],
"         \ })
" endif
"
" if executable('flow-language-server')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'flow-language-server',
"         \ 'cmd': {server_info->[&shell, &shellcmdflag, 'flow-language-server --stdio']},
"         \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.flowconfig'))},
"         \ 'whitelist': ['javascript', 'javascript.jsx'],
"         \ })
" endif
"
" if executable('java-language-server')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'java-language-server',
"         \ 'cmd': {server_info->[&shell, &shellcmdflag, 'java-language-server']},
"         \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'pom.xml'))},
"         \ 'whitelist': ['java'],
"         \ })
" endif
"
" if executable('rls')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'rls',
"         \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
"         \ 'whitelist': ['rust'],
"         \ })
" endif
"
" if executable('cquery')
"    au User lsp_setup call lsp#register_server({
"       \ 'name': 'cquery',
"       \ 'cmd': {server_info->['cquery']},
"       \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
"       \ 'initialization_options': { 'cacheDirectory': '~/.cache/cquery' },
"       \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
"       \ })
" endif
"
" autocmd FileType java,rust,typescript,javascript,javascript.jsx,scala,dart,go nnoremap <buffer>
"   \ <localleader>sd :LspDefinition<CR>
"
" autocmd FileType java,rust,typescript,javascript,javascript.jsx,scala,dart,go nnoremap <buffer>
"   \ <localleader>sh :LspHover<CR>
"
" autocmd FileType java,rust,typescript,javascript,javascript.jsx,scala,dart,go nnoremap <buffer>
"   \ <localleader>sf :LspDocumentSymbol<CR>
"
" autocmd FileType java,rust,typescript,javascript,javascript.jsx,scala,dart,go nnoremap <buffer>
"   \ <localleader>sr :LspReferences<CR>
"
" " autocmd FileType rust,typescript,javascript,javascript.jsx,scala,dart,go inoremap <buffer>
" "   \ <localleader>sc :call LanguageClient_textDocument_completion()<CR>
"
" let g:lsp_signs_enabled = 1
" let g:lsp_diagnostics_echo_cursor = 1
"
" let g:lsp_signs_error = {'text': '✗'}
" let g:lsp_preview_keep_focus = 0
"
" hi LspErrorText guibg=NONE guifg=red
"
