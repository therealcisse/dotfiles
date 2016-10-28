
let NERDTreeShowLineNumbers=0

" let NERDTreeIgnore=['dist/*', 'out', 'logs', '.DS_Store', '.git', '.idea', '.tags', '\~$']

let NERDTreeShowHidden=1

let NERDTreeRespectWildIgnore=1

" Disable display of '?' text and 'Bookmarks' label.
let g:NERDTreeMinimalUI=1

" The default of 31 is just a little too narrow.
let g:NERDTreeWinSize=40

" Single-click to toggle directory nodes, double-click to open non-directory
" nodes.
let g:NERDTreeMouseMode=2

let NERDTreeHijackNetrw = 0


" let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" let g:DevIconsEnableFoldersOpenClose = 1

" the amount of space to use after the glyph character (default ' ')
let g:WebDevIconsNerdTreeAfterGlyphPadding = ''
let g:WebDevIconsNerdTreeGitPluginForceVAlign=0

" NERDTree

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:WebDevIconsOS = 'Darwin'

" let g:NERDTreeDirArrowExpandable = '›'
" let g:NERDTreeDirArrowCollapsible = '⌄'

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

let g:NERDTreeGitStatusNodeColorization = 1
let g:NERDTreeGitStatusWithFlags = 0

" let g:NERDTreeFileExtensionHighlightFullName = 1

" Let <Leader><Leader> (^#) return from NERDTree window.
let g:NERDTreeCreatePrefix='silent keepalt keepjumps'

let g:webdevicons_conceal_nerdtree_brackets = 1

let g:webdevicons_enable_nerdtree = 1

" Tweaks for browsing
let g:netrw_banner = 0
let g:netrw_browse_splits = 4
let g:netrw_altv = 1
let g:netrw_liststyle = 3
let g:netrw_list_hide = netrw_gitignore#Hide()
let g:netrw_list_hide .= ',\(^\|\s\s\)\zs\.\S\+'

