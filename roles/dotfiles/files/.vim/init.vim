
function! MyHighlights() abort
  hi! link LspReferenceText CursorColumn
  hi! link LspReferenceRead CursorColumn
  hi! link LspReferenceWrite CursorColumn

  hi! SignColumn ctermfg=NONE guibg=NONE
  hi! NonText ctermbg=NONE guibg=NONE
  hi! LineNr ctermfg=NONE guibg=NONE
  hi! StatusLine guifg=#16252b guibg=#6699CC
  hi! StatusLineNC guifg=#16252b guibg=#16252b

  hi! VertSplit guifg=#fff
  hi! CursorLineNr gui=bold guifg=NONE guibg=NONE

  hi! Search guifg=#969896 guibg=#f0c674
  hi! IncSearch guifg=#282a2e guibg=#de935f
  hi! PMenuSel guifg=#282a2e guibg=#c5c8c6
  hi! Pmenu guibg='00010a' guifg=white

  hi clear Conceal
endfunction

augroup MyColors
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup END

autocmd BufWritePost $MYVIMRC nested source $MYVIMRC

set background=dark
colorscheme PaperColor

" LSP
nnoremap <silent> <C-]>       <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K           <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gy          <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gi          <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr          <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gds         <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gws         <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <leader>rn  <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>f   <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <leader>ca  <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>ws  <cmd>lua require'metals'.worksheet_hover()<CR>
nnoremap <silent> <leader>a   <cmd>lua require'metals'.open_all_diagnostics()<CR>
nnoremap <silent> <space>d    <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> [c          <cmd>lua vim.lsp.diagnostic.goto_prev { wrap = false }<CR>
nnoremap <silent> ]c          <cmd>lua vim.lsp.diagnostic.goto_next { wrap = false }<CR>

if has('clipboard')
  "http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
  set clipboard^=unnamed
  set clipboard^=unnamedplus
end

nnoremap <silent> <localleader>w :call mappings#leader#zap()<CR>

" Automatically strip the trailing
" whitespaces when files are saved.

augroup strip_trailing_whitespaces

  " List of file types that use the trailing whitespaces:
  "
  "  * Markdown
  "    https://daringfireball.net/projects/markdown/syntax#block

  let excludedFileTypes = [
        \ "markdown",
        \ "mkd.markdown"
        \]

  " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  " Only strip the trailing whitespaces if
  " the file type is not in the excluded list.

  au!
  au BufWritePre * if index(excludedFileTypes, &ft) < 0 | :call mappings#leader#zap()

augroup END

let g:auto_save = 0
let g:nvcode_termcolors=256
let g:airline_theme='minimalist'

let mapleader="\<Space>"
let maplocalleader="\\"

scriptencoding utf-8

set termguicolors

set inccommand=split

set ttyfast

set mouse=a

au BufWritePost plugins.lua PackerCompile

if exists('$SUDO_USER')
  set nobackup                        " don't create root-owned files
  set nowritebackup                   " don't create root-owned files
else
  set backupdir=~/.vim/tmp/backup   " Set directory for backup files.
endif

set backupskip=/tmp/*               " ┐ Don't create backups
set backupskip+=/private/tmp/*      " ┘ for certain files.

if exists('$SUDO_USER')
  set nobackup                        " don't create root-owned files
  set nowritebackup                   " don't create root-owned files
else
  set backupdir=~/.vim/tmp/backup   " Set directory for backup files.
endif

if exists('$SUDO_USER')
  set noswapfile                      " don't create root-owned files
else
  set directory=~/.vim/tmp/swap//  " Set directory for swap files.
endif

set history=1000               " Increase command line history.
set noignorecase                 " Don't ignore case in search patterns.

set incsearch                  " Highlight search pattern
                               " as it is being typed.

set lazyredraw                 " Do not redraw the screen while
                               " executing macros, registers
                               " and other commands that have
                               " not been typed.

if has('linebreak')
  set breakindent                     " indent wrapped lines to match start
  if exists('&breakindentopt')
    set breakindentopt=shift:2        " emphasize broken lines by indenting them
  endif
endif

set magic                      " Enable extended regexp.
set mousehide                  " Hide mouse pointer while typing.
set noerrorbells               " Disable error bells.

set nojoinspaces               " When using the join command,
                               " only insert a single space
                               " after a `.`, `?`, or `!`.

set nostartofline              " Kept the cursor on the same column.
set number                     " Show line number.

set numberwidth=4              " Increase the minimal number of
                               " columns used for the `line number`.

set report=100                 " Report the number of lines changed.
set ruler                      " Show cursor position.

set scrolloff=1                " When scrolling, keep the cursor
                               " 5 lines below the top and 5 lines
                               " above the bottom of the screen.

set sidescrolloff=5            " same as scolloff, but for columns

set display+=lastline

if has('linebreak')
  let &showbreak='⤷ '          " ARROW POINTING DOWNWARDS THEN CURVING RIGHTWARDS (U+2937, UTF-8: E2 A4 B7)
endif

" Avoid all the hit-enter prompts.
set shortmess+=A                 " ignore annoying swapfile messages
set shortmess+=I                 " no splash screen
set shortmess+=O                 " file-read message overwrites previous
set shortmess+=T                 " truncate non-file messages in middle
set shortmess+=W                 " don't echo "[w]"/"[written]" when writing
set shortmess+=a                 " use abbreviations in messages eg. `[RO]` instead of `[readonly]`
set shortmess+=o                 " overwrite file-written messages
set shortmess+=t                 " truncate file messages at start

" don't give |ins-completion-menu| messages.  For example,
" '-- XXX completion (YYY)', 'match 1 of 2', 'The only match',
try
  set shortmess+=c
catch
endtry

if has('showcmd')
  set showcmd                    " Show the command being typed.
endif

set showmode                   " Show current mode.
set spelllang=en_us            " Set the spellchecking language.

set smartcase                  " Override `ignorecase` option
                               " if the search pattern contains
                               " uppercase characters.

set infercase                   " Smarter case during autocompletion.

set synmaxcol=2500             " Limit syntax highlighting (this
                               " avoids the very slow redrawing
                               " when files contain long lines).

set tabstop=2                  " ┐
set shiftround                 " │ Set global <TAB> settings.
set shiftwidth=2               " │
set expandtab                  " ┘

if v:progname !=# 'vi'
  set softtabstop=-1           " use 'shiftwidth' for tab/bs at end of line
endif

if has('persistent_undo')
  if exists('$SUDO_USER')
    set noundofile                    " don't create root-owned files
  else
    set undodir+=~/.vim/tmp/undo      " keep undo files out of the way
    set undofile                      " actually use undo files
  endif
endif

set visualbell                 " ┐
set noerrorbells               " │ Disable beeping and window flashing
set t_vb=                      " ┘ https://vim.wikia.com/wiki/Disable_beeping


set wildmenu                   " Enable enhanced command-line
                               " completion (by hitting <TAB> in
                               " command mode, Vim will show the
                               " possible matches just above the
                               " command line with the first
                               " match highlighted).

set wildmode=longest:full,full        " shell-like autocomplete to unambiguous portion

set wildcharm=<C-z>            " substitue for 'wildchar' (<Tab>) in macros

set wildignore+=*.swp   " Ignored files

set winminheight=0             " Allow windows to be squashed.

if has('folding')
  if has('windows')
    set fillchars=vert:┃              " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
  endif
  set foldenable                      " enable folding
  set foldmethod=indent               " not as cool as syntax, but faster
  set foldlevelstart=99               " start unfolded

endif

set pumheight=10             " Completion window max size

if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j                " remove comment leader when joining comment lines
endif

set formatoptions+=n                  " smart auto-indenting inside numbered lists

" indentation
set formatoptions+=w

" Search and replace the word under the cursor.

" Replace all

nnoremap <leader>r :%s/\V\<<C-r>=autocmds#escape_pattern(expand('<cword>'))<CR>\>//c<Left><Left>
vnoremap <leader>r :<c-u>%s/\V<c-r>=autocmds#escape_pattern(autocmds#get_visual_selection())<CR>//c<Left><Left>

" Align current paragraph
nmap <leader>F :call mappings#leader#format#align()<CR>
vmap <leader>F =

set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,func,fun,fn,interface,trait " auto indent on these words

if has('linebreak')
  set linebreak                       " wrap long lines at characters in 'breakat'
endif


" Make the opening of the `.vimrc` file easier.

nnoremap <localleader>e :e $MYVIMRC<CR>
nnoremap <localleader>r :source $MYVIMRC<CR>

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" toggle invisible characters
set list
set listchars=nbsp:⦸                  " CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
set listchars+=tab:▷┅                 " WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7)
                                      " + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
set listchars+=extends:»              " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
set listchars+=precedes:«             " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
set listchars+=trail:•                " BULLET (U+2022, UTF-8: E2 80 A2)

set completeopt-=preview    " Don't show preview window during completion.
set complete-=i

set smarttab                " tab respects 'tabstop', 'shiftwidth', and 'softtabstop

set textwidth=80               " automatically hard wrap at 80 columns

set showtabline=0

" ----------------------------------------------------------------------------
" Readline-style key bindings in command-line (excerpt from rsi.vim)
" ----------------------------------------------------------------------------
cnoremap        <C-A> <Home>
cnoremap        <C-B> <c-Left>
cnoremap        <C-G> <c-Right>
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"

" Align current paragraph
nmap <leader>F :call mappings#leader#format#align()<CR>
vmap <leader>F =

" Kill double quotes
nmap <c-s>" :%s/\V\"/'<CR><C-L>
nmap <c-s>' :%s/\V\'/"<CR><C-L>

"-----------------------------------------------------------------------------
" Helpful general settings
"-----------------------------------------------------------------------------
" Needed for compltions _only_ if you aren't using completion-nvim
au FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" Ensure au works for Filetype
set shortmess-=F

if has('timers')
  " Blink 2 times with 50ms interval
  noremap <expr> <plug>(slash-after) slash#blink(2, 50)
endif

augroup MyAutocmds
    au!

    au VimResized * wincmd =

    if has('mksession')
      " Save/restore folds and cursor position.
      au BufWritePost,BufWinLeave,BufLeave,WinLeave ?* if autocmds#should_mkview() | call autocmds#mkview() | endif
      if has('folding')
        au BufWinEnter ?* if autocmds#should_mkview() | silent! loadview | execute 'silent! ' . line('.') . 'foldopen!' | endif
      else
        au BufWinEnter ?* if autocmds#should_mkview() | silent! loadview | endif
      endif
    elseif has('folding')
      " Like the au described in `:h last-position-jump` but we add `:foldopen!`.
      au BufWinEnter * if line("'\"") > 1 && line("'\"") <= line('$') | execute "normal! g`\"" | execute 'silent! ' . line("'\"") . 'foldopen!' | endif
    else
      au BufWinEnter * if line("'\"") > 1 && line("'\"") <= line('$') | execute "normal! g`\"" | endif
    endif

    " Let's close the location and the quickfix window if it's the last one
    if exists('##QuitPre')
      au QuitPre * if &filetype != 'qf' | silent! lclose | silent! cclose | endif
    endif

    au CompleteDone * pclose

    if exists('##TextYankPost')
      au TextYankPost * silent! lua return (not vim.v.event.visual) and require'vim.highlight'.on_yank('Substitute', 200)
    endif

augroup end

" Make the jk behave

nnoremap j gj
nnoremap k gk

nnoremap gj j
nnoremap gk k

" Save all
nn <leader>s :wa<CR>

" Save current buffer
nn <leader>S :update<CR>

" Quickly quick current buffer
nn <leader>q :confirm q<CR>

" Close all
nn <leader>Q :confirm qall<CR>

" Always use vertical diffs
set diffopt+=vertical

" Avoid unintentional switches to Ex mode. This would be more useful.
nnoremap Q :normal n.<CR>

nnoremap Y y$

vnoremap y myy`y
vnoremap Y myY`y

" Backspace should delete selection and put me in insert mode

vnoremap <BS> "_xi

nn _ "_dd

" Open file under the cursor in a vsplit
nnoremap gf :rightbelow wincmd f<CR>

set suffixesadd=.js
set suffixesadd=.ts
set suffixesadd+=.json

set path+=*/**

set shell=/bin/sh

set updatetime=250

" always show signcolumns
set signcolumn=yes

" Better display for messages
set cmdheight=3

if exists('&swapsync')
  set swapsync=                       " let OS sync swapfiles lazily
endif
set switchbuf=usetab

set whichwrap=b,h,l,s,<,>,[,],~     " Allow <BS>/h/l/<Right>/<Space> to move cross line boundaries

if has('windows')
  set splitbelow                      " open horizontal splits below current window
endif

if has('vertsplit')
  set splitright                      " open vertical splits to the right of the current window
endif

if has('viminfo')
  if exists('$SUDO_USER')
    set viminfo=                      " don't create root-owned files
  else
    set viminfo+=n~/.vim/tmp/viminfo

    if !empty(glob('~/.vim/tmp/viminfo'))
      if !filereadable(expand('~/.vim/tmp/viminfo'))
        echoerr 'warning: ~/.vim/tmp/viminfo exists but is not readable'
      endif
    endif

  endif
endif

if has('mksession')
  set viewdir=~/.vim/tmp/view
  set viewoptions=cursor,folds        " save/restore just these (with `:{mk,load}view`)
  set sessionoptions=folds
endif


" <Leader><Leader> -- Open last buffer.
nnoremap <leader><leader> <C-^>

nnoremap <leader>o :only<CR>

" <LocalLeader>c -- Fix (most) syntax highlighting problems in current buffer
" (mnemonic: coloring).
nnoremap <silent> <localleader>c :syntax sync fromstart<CR>

syntax sync minlines=256 " start highlighting from 256 lines backwards
set synmaxcol=300        " do not highlith very long lines
set re=1                 " use explicit old regexpengine, seems to be more faster

" Count occurences of word under cursor
nnoremap <leader>* *<C-O>:%s///gn<CR>

"" Git
"no mappings by gitgutter
let g:gitgutter_map_keys = 0

let g:gitgutter_max_signs = 1200

"focus window of last created buffer
function! JumpLastBufferWindow()
  call win_gotoid(win_getid(bufwinnr(last_buffer_nr())))
endfunction

nnoremap <c-g>b :Git blame<cr>
nnoremap <c-g>B :Git browse<cr>
nnoremap <c-g>s :Git status<cr>
" nnoremap <c-g>c :Gcommit<cr>
nnoremap <c-g>d :Gvdiff<cr>
nnoremap <c-g>P :Gpush<cr>
nnoremap <c-g>L :Gpull<cr>
" nnoremap <c-g>R :!git checkout <c-r>%<cr><cr>
nnoremap <c-g>p :GitGutterPreviewHunk<cr>:call JumpLastBufferWindow()<cr>
" nnoremap <c-g>r :GitGutterUndoHunk<cr>
nnoremap <c-g>S :GitGutterStageHunk<cr>
nnoremap <c-g>l :GitGutterLineHighlightsToggle<cr>
nnoremap [h :GitGutterPrevHunk<cr>
nnoremap ]h :GitGutterNextHunk<cr>

let g:gitgutter_sign_added = '┃'
let g:gitgutter_sign_removed = '┃'
let g:gitgutter_sign_modified = '┃'
let g:gitgutter_sign_modified_removed = '┃'

if has('virtualedit')
  set virtualedit=insert    " allow the cursor to go everywhere (insert)
  set virtualedit+=onemore  " allow the cursor to go just past the end of line
  set virtualedit+=block    " allow the cursor to go everywhere (visual block)
endif

vnoremap . :norm.<CR>

" Folds
nmap <expr> <Tab> 'za'
nmap <expr> <S-Tab> 'za'

" vim-move

let g:move_key_modifier = 'C'
let g:move_map_keys = 0

vmap <C-j> <Plug>MoveBlockDown
nmap <C-j> <Plug>MoveLineDown

vmap <C-k> <Plug>MoveBlockUp
nmap <C-k> <Plug>MoveLineUp

" Ctrl-o: Go back in the jumplist, also realign the screen
nnoremap <c-o> <c-o>zzzv

" the /g flag on :s substitutions by default
set gdefault

" ----------------------------------------------------------------------
" Startify
" ----------------------------------------------------------------------

let g:startify_enable_special         = 0
let g:startify_files_number           = 10
let g:startify_relative_path          = 1
let g:startify_change_to_dir          = 0
let g:startify_update_oldfiles        = 1
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

let g:startify_session_autoload     = 0
let g:startify_session_persistence  = 0

" Join lines with M
nn M J

" Navigate line with H L
nn H ^
nn L $

" ----------------------------------------------------------------------------
" :Root | Change directory to the root of the Git repository
" ----------------------------------------------------------------------------
function! s:root()
  let root = systemlist('git rev-parse --show-toplevel')[0]
  if v:shell_error
    echo 'Not in git repo'
  else
    execute 'lcd' root
    echo 'Changed directory to: '.root
  endif
endfunction
command! Root call s:root()

" ----------------------------------------------------------------------------
" EX | chmod +x
" ----------------------------------------------------------------------------
command! EX if !empty(expand('%'))
         \|   write
         \|   call system('chmod +x '.expand('%'))
         \|   silent e
         \| else
         \|   echohl WarningMsg
         \|   echo 'Save the file first'
         \|   echohl None
         \| endif

" Terminal mappings
if has('nvim')
  tnoremap <Esc> <C-\><C-n>

  " Prefer Neovim terminal insert mode to normal mode.
  au BufEnter,FocusGained term://* startinsert

  " Don't close terminal on :q
  au TermOpen * set bufhidden=hide

  " Append --no-height
  " let $FZF_DEFAULT_OPTS .= ' --no-height' " https://github.com/neovim/neovim/issues/4151
endif

" otherwise vim replaces the content of current buffer with the new file you
" open. Or maybe deletes the current buffer and creates a new one. Either way,
" it makes swithcing between open files quickly a pain in the ass.
" If i set the hidden option, i lose the line numbers for some reason. Not
" for every file though. If i open this file, everything's fine. If i open
" a directory and then open a js file. Boom!
set hidden


" Select pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Fix mixed indent
nnoremap <C-s>i :%retab!<CR>

nnoremap <silent> <c-n>e :Explore<cr>

" Vim-signiture
let g:SignatureMarkTextHLDynamic = 1

" the amount of space to use after the glyph character (default ' ')
let g:WebDevIconsNerdTreeAfterGlyphPadding = ''
let g:WebDevIconsNerdTreeGitPluginForceVAlign=0

let g:WebDevIconsOS = 'Darwin'

" Sort motion
let g:sort_motion_flags = "u"

" Ctrl click and drag for visual block mode
noremap <S-LeftMouse> <4-LeftMouse>
noremap <S-LeftDrag> <LeftDrag>

" close last open tag
imap <localleader>/ </<C-x><C-o>

map <localleader>q :cclose <BAR> pclose <BAR> lclose<CR>

" Duplicate line
nn <leader>D "xyy"xp

" last typed word to lower case
inoremap <C-g>u <esc>guawA

" last typed word to UPPER CASE
inoremap <C-g>~ <esc>gUawA

" entire line to lower case
" inoremap <C-g>u <esc>guuA

" entire line to UPPER CASE
inoremap <C-g>U <esc>gUUA

" current line to title case
inoremap <C-g>t <esc>:s/\v<(.)(\w*)/\u\1\L\2/g<cr>A

inoremap <c-c> <ESC>

" ` is more precise than '
noremap ' `

" do not override the register after paste in select mode
xnoremap <expr> p 'pgv"'.v:register.'y`>

" like emacs mode shell command editing
inoremap <C-E> <C-o>$
inoremap <C-Q> <C-o>^
inoremap <C-B> <left>
inoremap <C-F> <right>
inoremap <C-D> <Delete>

" command line editing
cnoremap <C-A>      <Home>
cnoremap <C-B>      <Left>
cnoremap <C-D>      <Delete>
" <C-F>  is also used for open  normal command-line editing. So if the
" cursor is at the end of the command-line, open normal command-line
" editing, otherwise move the cursor one character right.
cnoremap <expr> <C-F>  (getcmdpos()<(len(getcmdline())+1)) && (getcmdtype()==":") ?  "\<Right>" : "\<C-F>"
" already well mapped by default:
" <C-P> <Up>
" <C-N> <Down>
" <C-E> <End>

" not working?
snoremap <BS> <BS>i

" Same when moving up and down
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz

" Arg wrap
nnoremap <silent> J :ArgWrap<CR>

augroup MyArgWrapCmds
  au!
  au FileType javascript,javascript.jsx let b:argwrap_tail_comma = 1
  au FileType javascript,javascript.jsx let b:argwrap_padded_braces = '[{'
  au FileType javascript,javascript.jsx let b:argwrap_tail_comma_braces = '[{'
augroup END

nnoremap <Left> :vertical resize -1<CR>
nnoremap <Right> :vertical resize +1<CR>
nnoremap <Up> :resize -1<CR>
nnoremap <Down> :resize +1<CR>
" Disable arrow keys completely in Insert Mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Echodoc
set noshowmode

" === echodoc === "
" Enable echodoc on startup
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'
" To use a custom highlight for the float window,
" change Pmenu to your highlight group
highlight link EchoDocFloat Pmenu

augroup dirvish_config
  au!
  au FileType dirvish silent! unmap <buffer> <C-p>
  au FileType dirvish silent! unmap <buffer> <C-n>

  au FileType dirvish
        \ nnoremap <silent><buffer> t ddO<Esc>:let @"=substitute(@", '\n', '', 'g')<CR>:r ! find "<C-R>"" -maxdepth 1 -print0 \| xargs -0 ls -Fd<CR>:silent! keeppatterns %s/\/\//\//g<CR>:silent! keeppatterns %s/[^a-zA-Z0-9\/]$//g<CR>:silent! keeppatterns g/^$/d<CR>:noh<CR>
augroup END

let g:dirvish_git_indicators = {
      \ 'Modified'  : '✹',
      \ 'Staged'    : '✚',
      \ 'Untracked' : '✭',
      \ 'Renamed'   : '➜',
      \ 'Unmerged'  : '═',
      \ 'Ignored'   : '☒',
      \ 'Unknown'   : '?'
      \ }

" vim-scala
au BufRead,BufNewFile *.sbt setlocal filetype=scala

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap [g :set nohls<CR>/<<<<<<<<CR>:set hls<CR>
nnoremap ]g :set nohls<CR>?<<<<<<<<CR>:set hls<CR>
nnoremap [= :set nohls<CR>/=======<CR>:set hls<CR>
nnoremap ]= :set nohls<CR>/=======<CR>:set hls<CR>
nnoremap [G :set nohls<CR>?>>>>>>><CR>:set hls<CR>
nnoremap ]G :set nohls<CR>?>>>>>>><CR>:set hls<CR>

" Let's have some fun with the QuickFix window
au BufReadPost quickfix setlocal foldmethod=expr
au BufReadPost quickfix setlocal foldexpr=or(getline(v:lnum)[0:1]=='\|\|')
au BufReadPost quickfix setlocal foldlevel=0

" Resize split easily
augroup ArrowKeys
  au!

  function! s:ToggleArrowKeys() abort
    nn <buffer> <leader>= :execute "wincmd ="<CR>

    " map <expr> <M-+> "<Plug>(expand_region_expand)" " a-+
    " map <expr> <M--> "<Plug>(expand_region_shrink)" " a--
  endfunction

  au BufWinEnter,WinEnter,BufLeave * call s:ToggleArrowKeys()
augroup end

" Wait until idle to run additional "boot" commands.
augroup Idleboot
    au!
    if has('vim_starting')
        au CursorHold,CursorHoldI * call autocmds#idleboot()
    endif
augroup END

augroup lsp
    au!
    au FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc
    au FileType scala,sbt lua require('metals').initialize_or_attach(metals_config)
augroup end

set cursorline                 " Highlight the current line.
set cursorcolumn               " Highlight the current column.

:lua << EOF

  local cmd = vim.cmd
  local g = vim.g
  local fn = vim.fn
  local execute = vim.api.nvim_command

  require('plugins')
  require('setup')

  metals_config = require'metals'.bare_config
  metals_config.settings = {showImplicitArguments = true, excludedPackages = {}}

  metals_config.on_attach = function() require'completion'.on_attach(); end

  metals_config.handlers["textDocument/publishDiagnostics"] =
      vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {virtual_text = {prefix = ''}})
EOF

" Float term
let g:floaterm_keymap_new = '<leader>ft'

" ----------------------------------------------------------------------------
" HL | Find out syntax group
" ----------------------------------------------------------------------------
function! s:hl()
  " ech  synIDattr(synID(line('.'), col('.'), 0), 'name')
  echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), '/')
endfunction
command! HL call <SID>hl()

" Telescope
nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <C-g>/ <cmd>lua require('telescope.builtin').live_grep()<cr>

let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default.dark': {
  \       'transparent_background': 1
  \     }
  \   }
  \ }

" ----------------------------------------------------------------------
"  Local Settings                                                     |
" ----------------------------------------------------------------------

" Load local settings if they exist.
"
" [!] The following needs to remain at the end of this file in
"     order to allow any of the above settings to be overwritten
"     by the local ones.

if filereadable(glob('~/.vimrc.local'))
  source ~/.vimrc.local
endif
