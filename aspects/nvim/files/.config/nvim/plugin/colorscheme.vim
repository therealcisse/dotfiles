" Guard
" if exists('g:colors_name') && g:colors_name != "falcon"
"   finish
" endif

if exists('g:loaded_falcon')
  finish
endif
let g:loaded_falcon=1

" Required as colors will come from terminal without
" if !exists('g:fzf_colors')
"   let g:fzf_colors=
"     \ { 'fg':      ['fg', 'Comment'],
"       \ 'bg':      ['bg', 'PMenu'],
"       \ 'hl':      ['fg', 'Normal'],
"       \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"       \ 'bg+':     ['bg', 'PMenu', 'PMenu'],
"       \ 'hl+':     ['fg', 'Keyword'],
"       \ 'info':    ['fg', 'PreProc'],
"       \ 'border':  ['fg', 'Ignore'],
"       \ 'prompt':  ['fg', 'Conditional'],
"       \ 'pointer': ['fg', 'Question'],
"       \ 'marker':  ['fg', 'Directory'],
"       \ 'spinner': ['fg', 'Label'],
"       \ 'header':  ['fg', 'Comment'] }
" endif

function s:HandleInactiveBackground()

  if !exists('$TMUX')
    " NeoVim has support for changing background colour depending on active or not
    if !exists('g:falcon_inactive')
      let g:falcon_inactive=1
    endif

    " Put in a background colour for gui
    if !exists('g:falcon_background')
      let g:falcon_background=1
    endif

    if !has("gui_running") || g:falcon_background == 0
      hi NonText guifg=#000000 ctermfg=NONE guibg=#000000 ctermbg=NONE gui=NONE cterm=NONE
      " hi Normal guifg=#b4b4b9 ctermfg=249 guibg=#000000 ctermbg=NONE gui=NONE cterm=NONE
    else
      hi NonText guifg=#000000 ctermfg=NONE guibg=#000000 ctermbg=NONE gui=NONE cterm=NONE
      " hi Normal guifg=#b4b4b9 ctermfg=249 guibg=#000000 ctermbg=0 gui=NONE cterm=NONE
    endif

     hi! Normal ctermbg=none guibg=none
     hi! InactiveWindow ctermbg=none guibg=none
     hi! NormalNC ctermbg=none guibg=none
     hi! EndOfBuffer ctermbg=none guibg=none

    " if exists('+winhighlight') && g:falcon_inactive == 1
      " hi! ActiveWindow guibg=NONE
      " hi! InactiveWindow guibg=#151521
      " hi! InactiveWindow guibg=NONE

      "TODO normalfloat background settings to not use PMenu
      " set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
      " return
    " endif

    " if g:falcon_background == 1
    "   hi ActiveWindow guibg=#020221
    "   hi InactiveWindow guibg=#151521
    " else

      " hi! EndOfBuffer guibg=#000000 guifg=#000000

      " hi! ActiveWindow guibg=#000000
      " hi! InactiveWindow guibg=#000000

      hi! LspInlayHint guifg=#AAAAAA gui=italic,bold
      hi! DiagnosticError guifg=Red

      hi! link SnacksDashboardDir Text
      hi! link BlinkCmpGhostText Comment
endif
  " endif
endfunction


function! s:MyHighlights() abort
  hi! HoverFloatBorder ctermbg=None ctermfg=255
  hi! LspReferenceRead gui=bold guifg=LightYellow
  hi! LspReferenceText gui=bold guifg=LightYellow
  hi! LspReferenceWrite gui=bold guifg=LightYellow

  hi! SignColumn ctermfg=NONE guibg=NONE
  hi! NonText ctermbg=NONE guibg=NONE
  hi! LineNr ctermfg=NONE guibg=NONE
  " hi! StatusLine guifg=#16252b guibg=#6699CC
  " hi! StatusLineNC guifg=#16252b guibg=#16252b

  hi! VertSplit guifg=#fff
  hi! cursorLineNr gui=bold guifg=#fabd2f guibg=#1A1B2A

  hi! Search guifg=#969896 guibg=#f0c674
  hi! IncSearch guifg=#282a2e guibg=#de935f
  hi! PMenuSel guifg=#282a2e guibg=#c5c8c6
  hi! Pmenu guibg='00010a' guifg=#fff
  hi! MatchParen guifg=orange gui=bold

  hi! CursorLine gui=bold

  hi! link CompeDocumentation NormalFloat

  hi! clear Conceal

  hi! link CompeDocumentation NormalFloat

  hi! Floaterm guibg=black
  " hi! FloatermNC guibg=gray

  " highlight Comment cterm=italic gui=italic

  hi! FloatermNC guibg=black

  hi! link javaConceptKind javaTypeDef

  hi! link ElCommand Statusline
  hi! link ElNormal Statusline
  hi! link ElVisual Statusline
  hi! link ElVisualLine Statusline
  hi! link ElVisualBlock Statusline

  hi! Visual guibg=#3a3a3a cterm=italic gui=italic
  hi! SpecialKey guifg=#333333 guibg=#111111
endfunction

function s:SetColors()
  " Guard
  if !exists('g:colors_name') || !exists('g:loaded_falcon')
    return
  endif

  " if g:colors_name != "falcon"
  "   return
  " endif

  call s:HandleInactiveBackground()
  call s:MyHighlights()
endfunction

autocmd VimEnter,ColorScheme * call s:SetColors()
