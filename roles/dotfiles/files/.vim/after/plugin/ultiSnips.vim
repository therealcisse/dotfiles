" " ==================== UltiSnips ====================
"
" " List all snippets
" let g:UltiSnipsListSnippets = '<c-.>'
"
" " Open in vertical split
" let g:UltiSnipsEditSplit    = 'vertical'
"
" " Prevent UltiSnips from removing our carefully-crafted mappings.
" let g:UltiSnipsMappingsToIgnore = ['autocomplete']
"
" function! g:UltiSnips_Complete()
"   call UltiSnips#ExpandSnippet()
"   if g:ulti_expand_res == 0
"     if pumvisible()
"       return "\<C-n>"
"     else
"       call UltiSnips#JumpForwards()
"       if g:ulti_jump_forwards_res == 0
"         return "\<TAB>"
"       endif
"     endif
"   endif
"   return ""
" endfunction
"
" function! g:UltiSnips_CR()
"   if pumvisible()
"     call UltiSnips#ExpandSnippet()
"     if g:ulti_expand_res == 0
"       return "\<C-Y>"
"     else
"       call UltiSnips#JumpForwards()
"       if g:ulti_jump_forwards_res == 0
"         return "\<CR>"
"       endif
"     endif
"   endif
"   return "\<CR>"
" endfunction
"
" function! g:UltiSnips_Reverse()
"   call UltiSnips#JumpBackwards()
"   if g:ulti_jump_backwards_res == 0
"     return "\<C-O>k"
"   endif
"
"   return ""
" endfunction
"
" if !exists("g:UltiSnipsJumpForwardTrigger")
"   let g:UltiSnipsJumpForwardTrigger = "<Tab>"
" endif
"
" if !exists("g:UltiSnipsJumpBackwardTrigger")
"   let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
" endif
"
" au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<CR>"
" au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<CR>"
"
" let g:ulti_expand_or_jump_res = 0
" function ExpandSnippetOrCarriageReturn()
"   let snippet = UltiSnips#ExpandSnippetOrJump()
"   if g:ulti_expand_or_jump_res > 0
"     return snippet
"   else
"     return "\<C-Y>"
"   endif
" endfunction

" imap <expr> <CR> pumvisible()
"       \ ? (empty(v:completed_item)?"\<C-n>\<C-y>\<CR>":"\<C-y>") :
"       \ (delimitMate#WithinEmptyPair() ? "<Plug>delimitMateCR" : "\<CR>")

imap <expr> <CR> pumvisible()
      \ ? coc#_select_confirm() :
      \ (delimitMate#WithinEmptyPair() ? "<Plug>delimitMateCR" : "\<CR>")

" let g:UltiSnipsSnippetsDir = $HOME . '/.config/nvim/ultisnips'
" let g:UltiSnipsSnippetDirectories = [
"       \ $HOME . '/.vim/ultisnips',
"       \ $HOME . '/.vim/plugged/vim-react-snippets/UltiSnips',
"       \ $HOME . '/.vim/plugged/vim-es2015-snippets/UltiSnips'
"       \ ]
"
