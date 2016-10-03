" ----------------------------------------------------------------------
" | General Settings                                                   |
" ----------------------------------------------------------------------

scriptencoding utf-8

set termguicolors

set nocompatible               " Don't make Vim vi-compatibile.

syntax on                      " Enable syntax highlighting.

if has("autocmd")
  filetype plugin indent on
  "           │     │    └──── Enable file type detection.
  "           │     └───────── Enable loading of indent file.
  "           └─────────────── Enable loading of plugin files.
endif

set autoindent                 " Copy indent to the new line.

set backspace=indent           " ┐
set backspace+=eol             " │ Allow `backspace`
set backspace+=start           " ┘ in insert mode.

set backupdir={{ neovim_config_dir }}/tmp/backups   " Set directory for backup files.

set backupskip=/tmp/*          " ┐ Don't create backups
set backupskip+=/private/tmp/* " ┘ for certain files.

set clipboard=unnamed          " ┐
                               " │ Use the system clipboard
if has("unnamedplus")          " │ as the default register.
  set clipboard+=unnamedplus " │
endif                          " ┘

set cpoptions+=$               " When making a change, don't
                               " redisplay the line, and instead,
                               " put a `$` sign at the end of
                               " the changed text.

" set textwidth=80               " automatically hard wrap at 80 columns

" set colorcolumn=80             " Highlight certain column(s).
if exists('+colorcolumn')
  " Highlight up to 255 columns (this is the current Vim max) beyond 'textwidth'
  " let &l:colorcolumn='+'.join(range(0, 254), ',+')
  " let &colorcolumn='80,'.join(range(120,254),',')
  let &l:colorcolumn="80," . join(map(range(40,999), '"+" . v:val'), ',')
endif

set cursorline                 " Highlight the current line.
set directory={{ neovim_config_dir }}/tmp/swaps     " Set directory for swap files.
set encoding=utf-8 nobomb      " Use UTF-8 without BOM.
set history=5000               " Increase command line history.
set hlsearch                   " Enable search highlighting.
set ignorecase                 " Ignore case in search patterns.

set incsearch                  " Highlight search pattern
                               " as it is being typed.

set laststatus=2               " Always show the status line.

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

" set listchars=tab:▸\           " ┐
" set listchars+=trail:·         " │ Use custom symbols to
" set listchars+=eol:¬           " │ represent invisible characters.
" set listchars+=nbsp:_          " ┘

set magic                      " Enable extended regexp.
set mousehide                  " Hide mouse pointer while typing.
set noerrorbells               " Disable error bells.

set nojoinspaces               " When using the join command,
                               " only insert a single space
                               " after a `.`, `?`, or `!`.

set nostartofline              " Kept the cursor on the same column.
set number                     " Show line number.

set numberwidth=5              " Increase the minimal number of
                               " columns used for the `line number`.

set report=0                   " Report the number of lines changed.
set ruler                      " Show cursor position.

set scrolloff=5                " When scrolling, keep the cursor
                               " 5 lines below the top and 5 lines
                               " above the bottom of the screen.

" set sidescrolloff=3            " same as scolloff, but for columns

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

set showcmd                    " Show the command being typed.
set showmode                   " Show current mode.
set spelllang=en_us            " Set the spellchecking language.

set smartcase                  " Override `ignorecase` option
                               " if the search pattern contains
                               " uppercase characters.

set synmaxcol=2500             " Limit syntax highlighting (this
                               " avoids the very slow redrawing
                               " when files contain long lines).

set tabstop=2                  " ┐
set softtabstop=2              " │ Set global <TAB> settings.
set shiftwidth=2               " │
set expandtab                  " ┘

set ttyfast                    " Enable fast terminal connection.
set undodir={{ neovim_config_dir }}/tmp/undos       " Set directory for undo files.
set undofile                   " Automatically save undo history.
set virtualedit=all            " Allow cursor to be anywhere.

set visualbell                 " ┐
set noerrorbells               " │ Disable beeping and window flashing
set t_vb=                      " ┘ https://vim.wikia.com/wiki/Disable_beeping

" set hidden

set wildmenu                   " Enable enhanced command-line
                               " completion (by hitting <TAB> in
                               " command mode, Vim will show the
                               " possible matches just above the
                               " command line with the first
                               " match highlighted).

set wildmode=longest:full,full        " shell-like autocomplete to unambiguous portion

set wildcharm=<C-z>            " substitue for 'wildchar' (<Tab>) in macros

set winminheight=0             " Allow windows to be squashed.

if has('folding')
  if has('windows')
    " set fillchars=vert:┃              " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
  endif
  set foldmethod=indent               " not as cool as syntax, but faster
  set foldlevelstart=99               " start unfolded
endif

if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j                " remove comment leader when joining comment lines
endif

if has('linebreak')
  set linebreak                       " wrap long lines at characters in 'breakat'
endif

" ----------------------------------------------------------------------
" | Plugins                                                            |
" ----------------------------------------------------------------------

" Use Vundle to manage the Vim plugins.
" https://github.com/VundleVim/Vundle.vim

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" Disable file type detection
" (this is required by Vundle).

filetype off

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" Include Vundle in the runtime path.

" set runtimepath+=~/.vim/plugins/Vundle.vim

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" Initialize Vundle and specify the path
" where the plugins should be installed.

" call vundle#begin("~/.vim/plugins")
call plug#begin('{{ neovim_config_dir }}/plugged')
  Plug 'vim-scripts/gitignore'

  Plug  'terryma/vim-expand-region'

  " Plug 'jmanoel7/vim-games'

  Plug 'tpope/vim-unimpaired'


  " Plug 'jparise/vim-graphql'

  Plug 'easymotion/vim-easymotion'
  Plug 'haya14busa/vim-asterisk'

  Plug 'haya14busa/incsearch.vim'
  Plug 'haya14busa/incsearch-easymotion.vim'
  Plug 'haya14busa/incsearch-fuzzy.vim'

  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-entire' " ae, ie
  Plug 'kana/vim-textobj-indent' " ai, ii
  Plug 'kana/vim-textobj-line'   " al, il

  Plug 'pangloss/vim-javascript', { 'for': [ 'javascript', 'javascript.jsx' ] }
  " Plug 'mxw/vim-jsx', { 'for': [ 'javascript', 'javascript.jsx' ] }
  Plug 'maxmellon/vim-jsx-pretty', { 'for': [ 'javascript', 'javascript.jsx' ] }
  Plug 'elzr/vim-json', { 'for': [ 'json' ] }
  Plug 'flazz/vim-colorschemes'
  Plug 'matchit.zip'

  " Ag/Ack for project-wide searching
  Plug 'mileszs/ack.vim'

  " Plug 'altercation/vim-colors-solarized'
  Plug 'ap/vim-css-color'
  " Plug 'chrisbra/unicode.vim'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'godlygeek/tabular'
  " Plug 'jelera/vim-javascript-syntax'
  Plug 'kien/ctrlp.vim'
  Plug 'mattn/emmet-vim', { 'for': [ 'html', 'css', 'javascript', 'javascript.jsx' ] }
  Plug 'mattn/webapi-vim'
  " Plug 'nathanaelkane/vim-indent-guides'
  Plug 'othree/html5.vim'
  Plug 'plasticboy/vim-markdown', { 'for': [ 'markdown' ] }
  Plug 'raimondi/delimitmate'
  Plug 'scrooloose/nerdtree', { 'on': [ 'NERDTreeToggle', 'NERDTreeFind' ] }
  " Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug  'neomake/neomake'
  Plug 'shougo/neosnippet'
  " Plug 'SirVer/ultisnips'
  Plug 'shougo/neosnippet-snippets'
  Plug 'honza/vim-snippets'
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'

  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

  " Plug 'jonathanfilip/lucius'

  Plug 'wakatime/vim-wakatime'

  Plug 'junegunn/vim-easy-align'

  Plug 'derekwyatt/vim-scala', { 'for': [ 'scala' ] }

  Plug 'xolox/vim-notes', { 'for': [ 'markdown' ] }
  Plug 'xolox/vim-misc'
  " Plug 'xolox/vim-easytags'

  " Plug 'elmcast/elm-vim'

  Plug 'vim-scripts/BufOnly.vim'

  Plug 'ervandew/supertab'

  " Plug 'majutsushi/tagbar'

  Plug 'maksimr/vim-jsbeautify', {'for': [ 'javascript', 'javascript.jsx' ]}
  Plug 'ternjs/tern_for_vim', {'for': [ 'javascript', 'javascript.jsx' ]}
  Plug 'carlitux/deoplete-ternjs', {'for': [ 'javascript', 'javascript.jsx' ]}

  Plug 'ryanoasis/vim-webdevicons'

  Plug 'chriskempson/base16-vim'

  " Plug 'wincent/terminus'
  Plug 'wincent/scalpel'

  " Plug 'othree/javascript-libraries-syntax.vim'

  Plug 'qpkorr/vim-bufkill'

  Plug  'pearofducks/ansible-vim', { 'for': [ 'yaml', 'ansible' ] }

  " Plug 'junegunn/goyo.vim'
  " Plug 'junegunn/limelight.vim'

" call vundle#end()
call plug#end()

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" Re-enable file type detection
" (disabling it was required by Vundle).

filetype on


" ----------------------------------------------------------------------
" | Plugins - Emmet                                                    |
" ----------------------------------------------------------------------

" Redefine trigger key for Emmet.
" http://docs.emmet.io/cheat-sheet/

" let g:user_emmet_leader_key="<C-E>"

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" Load custom Emmet snippets.
" http://docs.emmet.io/customization/snippets/

" let g:user_emmet_settings = webapi#json#decode(join(readfile(expand("~/.vim/snippets/emmet.json")), "\n"))


" ----------------------------------------------------------------------
" | Plugins - Indent Guides                                            |
" ----------------------------------------------------------------------

" Set custom indent colors.
" https://github.com/nathanaelkane/vim-indent-guides#setting-custom-indent-colors

" let g:indent_guides_auto_colors = 0
"
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd
"         \ guibg=#00323D
"         \ ctermbg=Magenta
"
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven
"         \ guibg=#073642
"         \ ctermbg=DarkMagenta


" ----------------------------------------------------------------------
" | Plugins - Markdown                                                 |
" ----------------------------------------------------------------------

" Disable Folding.
" https://github.com/plasticboy/vim-markdown#disable-folding

let g:vim_markdown_folding_disabled=1


" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" Make `<TAB>` autocomplete.

" inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
"
" inoremap <silent> <expr> <ESC> (pumvisible() ? "\<C-E>" : "\<ESC>")
" inoremap <silent> <expr> <CR> (pumvisible() ? "\<C-Y>" : "\<CR>")

" ----------------------------------------------------------------------
" | Helper Functions                                                   |
" ----------------------------------------------------------------------

" function! GetGitBranchName()
"
"     let branchName = ""
"
"     if exists("g:loaded_fugitive")
"         let branchName = "[" . fugitive#head() . "]"
"     endif
"
"     return branchName
"
" endfunction

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function! StripTrailingWhitespaces()

    " Save last search and cursor position.

    let searchHistory = @/
    let cursorLine = line(".")
    let cursorColumn = col(".")

    " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    " Strip trailing whitespaces.

    %s/\s\+$//e

    " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    " Restore previous search history and cursor position.

    let @/ = searchHistory
    call cursor(cursorLine, cursorColumn)


endfunction

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" function! ToggleLimits()
"
"     " [51,73]
"     "
"     "   * Git commit message
"     "     http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
"     "
"     " [81]
"     "
"     "   * general use
"
"     if ( &colorcolumn == "73" )
"         set colorcolumn+=51,81
"     else
"         set colorcolumn-=51,81
"     endif
"
" endfunction

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function! ToggleRelativeLineNumbers()

    if ( &relativenumber == 1 )
        set number
    else
        set relativenumber
    endif

endfunction
:call ToggleRelativeLineNumbers()


" ----------------------------------------------------------------------
" | Automatic Commands                                                 |
" ----------------------------------------------------------------------

if has("autocmd")

    " Autocommand Groups.
    " http://learnvimscriptthehardway.stevelosh.com/chapters/14.html

    " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    " Automatically reload the configurations from
    " the `~/.vimrc` file whenever they are changed.

    augroup auto_reload_vim_configs

        autocmd!
        autocmd BufWritePost vimrc source $MYVIMRC

    augroup END

    " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    " Use relative line numbers.
    " http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement/

    augroup relative_line_numbers

        autocmd!

        " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        " Automatically switch to absolute
        " line numbers when Vim loses focus.

        autocmd FocusLost * :set number

        " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        " Automatically switch to relative
        " line numbers when Vim gains focus.

        autocmd FocusGained * :set relativenumber

        " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        " Automatically switch to absolute
        " line numbers when Vim is in insert mode.

        autocmd InsertEnter * :set number

        " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        " Automatically switch to relative
        " line numbers when Vim is in normal mode.

        autocmd InsertLeave * :set relativenumber


    augroup END

    " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

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

        autocmd!
        autocmd BufWritePre * if index(excludedFileTypes, &ft) < 0 | :call StripTrailingWhitespaces()

    augroup END

endif


" ----------------------------------------------------------------------
" | Color Scheme                                                       |
" ----------------------------------------------------------------------

set t_Co=256                   " Enable full-color support.

" set background=dark            " Use colors that look good
                               " on a dark background.

" Set custom configurations for when the
" Solarized theme is used from Vim's Terminal mode.
"
" http://ethanschoonover.com/solarized/vim-colors-solarized#advanced-configuration

" if !has("gui_running")
"     let g:solarized_contrast = "high"
"     let g:solarized_termcolors = 256
"     let g:solarized_termtrans = 1
"     let g:solarized_visibility = "high"
" endif

" colorscheme solarized          " Use custom color scheme.
" colorscheme xoria256
" colorscheme lucius

" if filereadable(expand("{{ ansible_user_dir }}/.vimrc_background"))
"   let base16colorspace=256
"   source ~/.vimrc_background
" endif

function s:CheckColorScheme()
  if !has('termguicolors')
    let g:base16colorspace=256
  endif

  let s:config_file = expand('~/.base16')

  if filereadable(s:config_file)
    let s:config = readfile(s:config_file, '', 2)

    if s:config[1] =~# '^dark\|light$'
      execute 'set background=' . s:config[1]
    else
      echoerr 'Bad background ' . s:config[1] . ' in ' . s:config_file
    endif

    if filereadable(expand('{{ neovim_config_dir }}/plugged/base16-vim/colors/base16-' . s:config[0] . '.vim'))
      execute 'colorscheme base16-' . s:config[0]
    else
      echoerr 'Bad scheme ' . s:config[0] . ' in ' . s:config_file
    endif
  else " default
    set background=dark
    colorscheme base16-ocean
  endif

  " execute 'highlight Comment cterm=italic'

  " Allow for overrides:
  " - `statusline.vim` will re-set User1, User2 etc.
  " - `after/plugin/loupe.vim` will override Search.
  " doautocmd ColorScheme
endfunction

if v:progname !=# 'vi'
  if has('autocmd')
    augroup AmsaykAutocolor
      autocmd!
      autocmd FocusGained * call s:CheckColorScheme()
    augroup END
  endif

  call s:CheckColorScheme()
endif

" ----------------------------------------------------------------------
" | Key Mappings                                                       |
" ----------------------------------------------------------------------

" Use a different mapleader (default is "\").

let mapleader = ","

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,* ] Search and replace the word under the cursor.

nmap <leader>* :%s/\<<C-r><C-w>\>//<Left>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,cc] Toggle code comments.
" https://github.com/tomtom/tcomment_vim

map <leader>cc :TComment<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,cr] Calculate result.
" http://vimcasts.org/e/56

nmap <leader>cr 0yt=A<C-r>=<C-r>"<CR><Esc>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,cs] Clear search.

map <leader>cs <Esc>:noh<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,l ] Toggle `set list`.

" nmap <leader>l :set list!<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,n ] Toggle `set relativenumber`.

" nmap <leader>n :call ToggleRelativeLineNumbers()<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,ss] Strip trailing whitespace.

nmap <leader>ss :call StripTrailingWhitespaces()<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,t ] Toggle NERDTree.

map <leader>n :NERDTreeToggle<CR>
" silent! nmap <c-n> :NERDTreeToggle<CR>

nmap <leader>m :NERDTreeFind<CR>

let NERDTreeShowLineNumbers=0

let NERDTreeIgnore=['dist', 'out', 'logs', '.DS_Store', '.git', '.idea', '.tags', '\~$']

let NERDTreeShowHidden=1

" let NERDTreeRespectWildIgnore=1

" Disable display of '?' text and 'Bookmarks' label.
let g:NERDTreeMinimalUI=1

" Let <leader><leader> (^#) return from NERDTree window.
let g:NERDTreeCreatePrefix='silent keepalt keepjumps'


" The default of 31 is just a little too narrow.
let g:NERDTreeWinSize=40

" Single-click to toggle directory nodes, double-click to open non-directory
" nodes.
let g:NERDTreeMouseMode=2

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,ti] Toggle indent.

" nmap <leader>ti <Plug>IndentGuidesToggle

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,tl] Toggle show limits.

" nmap <leader>tl :call ToggleLimits()<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,ts] Toggle Syntastic.

" nmap <leader>ts :SyntasticToggleMode<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,v ] Make the opening of the `.vimrc` file easier.

" nmap <leader>v :e $MYVIMRC<CR>
" nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>ev :e $MYVIMRC<cr>
nmap <leader>rv :source $MYVIMRC<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,W ] Sudo write.

" map <leader>W :w !sudo tee %<CR>


" ----------------------------------------------------------------------
" | Status Line                                                        |
" ----------------------------------------------------------------------

" Terminal types:
"
"   1) term  (normal terminals, e.g.: vt100, xterm)
"   2) cterm (color terminals, e.g.: MS-DOS console, color-xterm)
"   3) gui   (GUIs)

" highlight ColorColumn
"     \ term=NONE
"     \ cterm=NONE  ctermbg=237    ctermfg=NONE
"     \ gui=NONE    guibg=#073642  guifg=NONE
"
" highlight CursorLine
"     \ term=NONE
"     \ cterm=NONE  ctermbg=235  ctermfg=NONE
"     \ gui=NONE    guibg=#073642  guifg=NONE
"
" highlight CursorLineNr
"     \ term=bold
"     \ cterm=bold  ctermbg=235   ctermfg=178
"     " \ cterm=bold  ctermbg=NONE   ctermfg=178
"     \ gui=bold    guibg=#073642  guifg=Orange

" highlight CursorLineNr
"     \ term=bold
"     \ cterm=bold ctermfg=178
"     " \ cterm=bold  ctermbg=NONE   ctermfg=178
"     " \ gui=bold    guibg=#073642  guifg=Orange

set highlight+=@:ColorColumn          " ~/@ at end of window, 'showbreak'
set highlight+=N:DiffText   " make current line number stand out a little

" highlight LineNr
"     \ term=NONE
"     \ cterm=NONE  ctermfg=241    ctermbg=NONE
"     \ gui=NONE    guifg=#839497  guibg=#073642
"
" highlight User1
"     \ term=NONE
"     \ cterm=NONE  ctermbg=237    ctermfg=Grey
"     \ gui=NONE    guibg=#073642  guifg=#839496

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" set statusline=
" set statusline+=%1*            " User1 highlight
" set statusline+=\ [%n]         " Buffer number
" set statusline+=\ %{GetGitBranchName()}        " Git branch name
" set statusline+=\ [%f]         " File path
" set statusline+=%m             " Modified flag
" set statusline+=%r             " Readonly flag
" set statusline+=%h             " Help file flag
" set statusline+=%w             " Preview window flag
" set statusline+=%y             " File type
" set statusline+=[
" set statusline+=%{&ff}         " File format
" set statusline+=:
" set statusline+=%{strlen(&fenc)?&fenc:'none'}  " File encoding
" set statusline+=]
" set statusline+=%=             " Left/Right separator
" set statusline+=%c             " File encoding
" set statusline+=,
" set statusline+=%l             " Current line number
" set statusline+=/
" set statusline+=%L             " Total number of lines
" set statusline+=\ (%P)\        " Percent through file

" Example result:
"
"  [1] [master] [vim/vimrc][vim][unix:utf-8]            17,238/381 (59%)


" ----------------------------------------------------------------------
" | Local Settings                                                     |
" ----------------------------------------------------------------------

" Load local settings if they exist.
"
" [!] The following needs to remain at the end of this file in
"     order to allow any of the above settings to be overwritten
"     by the local ones.

if filereadable(glob("{{ ansible_user_dir }}/.vimrc.local"))
  source {{ ansible_user_dir }}/.vimrc.local
endif

" Don't continue comment mark after press 'o' when you're on a commented line.
au VimEnter * set formatoptions -=cro
au BufEnter * set formatoptions -=cro

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>).
" au VimEnter * vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

set pastetoggle=

" Powerline setup
set laststatus=2
" set term=xterm-256color
set termencoding=utf-8
" set guifont=Ubuntu\ Mono\ derivative\ Powerline:10
" set guifont=Ubuntu\ Mono
let g:Powerline_symbols = 'fancy'

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" make the highlighting of tabs and other non-text less annoying
highlight SpecialKey ctermbg=none ctermfg=8
highlight NonText ctermfg=8 ctermbg=none

" make comments and HTML attributes italic
highlight Comment cterm=italic
" highlight htmlArg cterm=italic

" toggle invisible characters
" set list
set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮,space:⋅
set showbreak=↪

" Tab control
" set noexpandtab           " insert tabs rather than spaces for <Tab>
set smarttab                " tab respects 'tabstop', 'shiftwidth', and 'softtabstop

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

let g:airline#extensions#whitespace#enabled = 1
" let g:airline_section_error = ''
" let g:airline_section_warning = ''

let g:airline_symbols.maxlinenr = ''

" Use deoplete.
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
" let g:deoplete#enable_refresh_always = 1

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
" let g:deoplete#disable_auto_complete = 1

" tern

" Use deoplete.
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = '0'  " This do disable full signature type on autocomplete

" Use tern_for_vim.
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

" tern
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1
  autocmd FileType javascript setlocal omnifunc=tern#Complete
endif

let g:tern_show_signature_in_pum = 1
" closes terns help windo automatically
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" deoplete tab-complete
" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" imap <expr><Esc> pumvisible() ? deoplete#mappings#close_popup() : "\<Esc>"

" <CR>: close popup and save indent.
" inoremap <silent> <CR> <C-r>=<SID>ClosePUM()<CR>
" function! s:ClosePUM() abort
"   return deoplete#mappings#close_popup() . "\<CR>"
" endfunction

" tern goto defintion
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>

" Airline

" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#show_buffers = 1
" let g:airline#extensions#tabline#show_splits = 0
" let g:airline#extensions#tabline#show_tabs = 1
" let g:airline#extensions#tabline#show_tab_nr = 0
" let g:airline#extensions#tabline#show_tab_type = 1
" let g:airline#extensions#tabline#close_symbol = '×'
" let g:airline#extensions#tabline#show_close_button = 1

" let g:airline_theme='powerlineish'
" let g:airline_section_z=''

let g:ctrlp_custom_ignore = 'node_modules$\|logs$\|\.git$\|out$\|dist$\|\.idea$'

let g:ctrlp_working_path_mode = 0

let g:user_emmet_install_global = 0
autocmd FileType html,css,javascript,javascript.jsx EmmetInstall

" This is used exclusively for React.js. It will replace all occurances of
" class= with className=
function! FixClassNames()
  :%s/\vclass\=/className\=/g
endfunction
command! FixClassNames call FixClassNames()

" neomake
" let g:neomake_verbose = 3
" autocmd BufWritePost,BufEnter * Neomake

" nmap <leader><Space>o :lopen<CR>      " open location window
" nmap <leader><Space>c :lclose<CR>     " close location window
" nmap <leader><Space>, :ll<CR>         " go to current error/warning
" nmap <leader><Space>n :lnext<CR>      " next error/warning
" nmap <leader><Space>p :lprev<CR>      " previous error/warning

let g:neomake_javascript_jshint_maker = {
    \ 'args': [ '--format' ],
    \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
    \ }
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_javascript_eslint_exe = system('PATH=$(npm bin):$PATH && which eslint | tr -d "\n"')


if executable("ag")
  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .DS_Store
      \ --ignore node_modules
      \ --ignore logs
      \ --ignore out
      \ --ignore dist
      \ -g ""'

  let g:ackprg = 'ag --vimgrep --smart-case'
  cnoreabbrev ag Ack

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Easy motion
let g:EasyMotion_do_mapping = 0 " Disable default mappings

map <leader> <Plug>(easymotion-prefix)

" <leader>f{char} to move to {char}
map  <leader>f <Plug>(easymotion-bd-f)
nmap <leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
" nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <leader>L <Plug>(easymotion-bd-jk)
nmap <leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <leader>w <Plug>(easymotion-bd-w)
nmap <leader>w <Plug>(easymotion-overwin-w)

" Incsearch easymotion

" You can use other keymappings like <C-l> instead of <CR> if you want to
" use these mappings as default search and somtimes want to move cursor with
" EasyMotion.
function! s:incsearch_config(...) abort
  return incsearch#util#deepextend(deepcopy({
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {
  \     "\<CR>": '<Over>(easymotion)'
  \   },
  \   'is_expr': 0
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())
noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))

let g:EasyMotion_smartcase = 1

" Incsearch

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" :h g:incsearch#auto_nohlsearch
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)


" Vim askerisk
let g:asterisk#keeppos = 1

map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)

" Incsearch easymotion
function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
        \   'converters': [
        \     incsearch#config#fuzzy#converter(),
        \   ],
        \   'modules': [incsearch#config#easymotion#module()],
        \   'keymap': {"\<CR>": '<Over>(easymotion)'},
        \   'is_expr': 0,
        \   'is_stay': 1
        \ }), get(a:, 1, {}))
endfunction
noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())

" Incsearch fuzzy find
map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-stay)

" Neo snippets

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB>
      \ pumvisible() ? "\<C-n>" :
      \ neosnippet#expandable_or_jumpable() ?
      \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: "\<TAB>"

imap <expr><CR> neosnippet#expandable() ? "\<Plug>(neosnippet_expand)"
            \: "\<C-r>=<SID>EnterClosesPUM()<CR>"
function! s:EnterClosesPUM()
    return pumvisible() ? deoplete#close_popup() : "\<CR>"
endfunction

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=nv " concealcursor=niv
endif

let g:neosnippet#snippets_directory = '{{ neovim_config_dir }}/plugged/vim-snippets/snippets'

" Make splits transparent
" See: http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html

set highlight+=c:LineNr

" hi VertSplit ctermfg=236
" hi VertSplit term=reverse cterm=reverse gui=reverse
" highlight NonText ctermfg=bg guifg=bg

" NERDTree

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Search ⇒

nmap f= :call search('=\\|⇒')<CR>

" Remap digraphs

inoremap <C-q> <C-k>

" Conceal some characters in javascript

let g:javascript_conceal_function       = "ƒ"
let g:javascript_conceal_null           = "ø"
let g:javascript_conceal_this           = "@"
" let g:javascript_conceal_return         = "⇚"
let g:javascript_conceal_undefined      = "¿"
let g:javascript_conceal_NaN            = "ℕ"
" let g:javascript_conceal_prototype      = "¶"
" let g:javascript_conceal_static         = "•"
" let g:javascript_conceal_super          = "Ω"
let g:javascript_conceal_arrow_function = "⇒"

" hi Conceal cterm=NONE ctermbg=NONE

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
" nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
" function! AutoHighlightToggle()
"   let @/ = ''
"   if exists('#auto_highlight')
"     au! auto_highlight
"     augroup! auto_highlight
"     setl updatetime=4000
"     echo 'Highlight current word: off'
"     return 0
"   else
"     augroup auto_highlight
"       au!
"       au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
"     augroup end
"     setl updatetime=500
"     echo 'Highlight current word: ON'
"     return 1
"   endif
" endfunction

" VIM jsx

let g:jsx_ext_required = 0
let g:javascript_plugin_flow = 1

" VIM notes

let g:notes_directories = ['{{ ansible_user_dir }}/Documents/Notes', '{{ ansible_user_dir }}/Dropbox/Shared Notes']

let g:notes_tagsindex = '{{ ansible_user_dir }}/Documents/Notes/tags.txt'
let g:notes_conceal_italic = 0
let g:notes_conceal_bold = 0
let g:notes_conceal_url = 0

nmap <leader>do :Note Todo<CR>

" using command-line-only abbrev to alias Note
cabbrev note Note

" Using the notes file type for git commit messages

autocmd BufNewFile,BufRead */.git/COMMIT_EDITMSG setlocal filetype=notes


" Fix conceal cursor jumps

function! ForwardSkipConceal(count)
    let cnt=a:count
    let mvcnt=0
    let c=col('.')
    let l=line('.')
    let lc=col('$')
    let line=getline('.')
    while cnt
        if c>=lc
            let mvcnt+=cnt
            break
        endif
        if stridx(&concealcursor, 'n')==-1
            let isconcealed=0
        else
            let [isconcealed, cchar, group] = synconcealed(l, c)
        endif
        if isconcealed
            let cnt-=strchars(cchar)
            let oldc=c
            let c+=1
            while c < lc
              let [isconcealed2, cchar2, group2] = synconcealed(l, c)
              if !isconcealed2 || cchar2 != cchar
                  break
              endif
              let c+= 1
            endwhile
            let mvcnt+=strchars(line[oldc-1:c-2])
        else
            let cnt-=1
            let mvcnt+=1
            let c+=len(matchstr(line[c-1:], '.'))
        endif
    endwhile
    return ":\<C-u>\e".mvcnt.'l'
endfunction

function! BackwardSkipConceal(count)
    let cnt=a:count
    let mvcnt=0
    let c=col('.')
    let l=line('.')
    let lc=0
    let line=getline('.')
    while cnt
        if c<=1
            let mvcnt+=cnt
            break
        endif
        if stridx(&concealcursor, 'n')==-1 || c == 0
            let isconcealed=0
        else
            let [isconcealed, cchar, group]=synconcealed(l, c-1)
        endif
        if isconcealed
            let cnt-=strchars(cchar)
            let oldc=c
            let c-=1
            while c>1
              let [isconcealed2, cchar2, group2] = synconcealed(l, c-1)
              if !isconcealed2 || cchar2 != cchar
                  break
              endif
              let c-=1
            endwhile
            let c = max([c, 1])
            let mvcnt+=strchars(line[c-1:oldc-2])
        else
            let cnt-=1
            let mvcnt+=1
            let c-=len(matchstr(line[:c-2], '.$'))
        endif
    endwhile
    return ":\<C-u>\e".mvcnt.'h'
endfunction

nnoremap <expr> l ForwardSkipConceal(v:count1)
nnoremap <expr> h BackwardSkipConceal(v:count1)

" Arrow keys madness

" noremap <Up> <Nop>
" noremap <Down> <Nop>
" noremap <Left> <Nop>
" noremap <Right> <Nop>

nmap <S-Left> <<
nmap <S-Right> >>

vmap <S-Left> <gv
vmap <S-Right> >gv

nmap <S-Up> [e
nmap <S-Down> ]e
vmap <S-Up> [egv
vmap <S-Down> ]egv


" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
command -nargs=0 -bar Update if &modified
                           \|    if empty(bufname('%'))
                           \|        browse confirm write
                           \|    else
                           \|        confirm write
                           \|    endif
                           \|endif

nnoremap <silent> <C-S> :<C-u>Update<CR>
inoremap <c-s> <c-o>:Update<CR><Esc>
vmap <C-s> <esc>:w<CR>gv


" Quit files easily

noremap <leader>q :q<cr>


" Apply macros with Q

nnoremap Q @q
vnoremap Q :norm @q<cr>

" Align current paragraph

noremap <leader>a =ip

" Clone paragraph with `cp`

noremap cp yap<S-}>p

" You can a more easily accessed key to enter command-line mode to speed your editing, for example:

" nnoremap <Space> :

" Copy & paste to system clipboard with <Space>p and <Space>y:

vmap <leader>y "+y
vmap <leader>d "+d
nmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>p "+p
vmap <leader>P "+P

" Use region expansion

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" " Buffers

nmap <leader>ls :ls<CR>
nmap <leader>bp :bp<CR>
nmap <leader>bn :bn<CR>
nmap <leader>bw :bw<CR>
nmap <leader>bb :b#<CR>
nmap <leader>b# :b#<CR>

" Elm

let g:elm_jump_to_error = 0
let g:elm_make_output_file = "elm.js"
let g:elm_make_show_warnings = 0
let g:elm_syntastic_show_warnings = 0
let g:elm_browser_command = ""
let g:elm_detailed_complete = 0
let g:elm_format_autosave = 1
let g:elm_format_fail_silently = 0
let g:elm_setup_keybindings = 0

" Tags

" Let Vim walk up directory hierarchy from CWD to root looking for tags file
" set tags=tags;/
set tags=./.tags;,{{ ansible_user_dir }}/.vimtags

" Tell EasyTags to use the tags file found by Vim
let g:easytags_dynamic_files = 1

let g:easytags_events = ['BufWritePost']

let g:easytags_async = 1

let g:easytags_on_cursorhold = 0

" let g:easytags_auto_highlight = 0

" If it hangs: pkill -KILL ctags

augroup AmsaykAutocmds
  let g:AmsaykColorColumnBlacklist = ['diff', 'undotree', 'nerdtree', 'qf']

  " Disable paste mode on leaving insert mode.
  autocmd InsertLeave * set nopaste

  function! s:should_colorcolumn() abort
    return index(g:AmsaykColorColumnBlacklist, &filetype) == -1
  endfunction

  " Make current window more obvious by turning off/adjusting some features in non-current
  " windows.
  if exists('+colorcolumn')
    autocmd BufEnter,FocusGained,VimEnter,WinEnter * if s:should_colorcolumn() | let &l:colorcolumn='80,'.join(map(range(40,999), '"+" . v:val'), ',') | endif
    autocmd FocusLost,WinLeave * if s:should_colorcolumn() | let &l:colorcolumn=join(range(1, 999), ',') | endif
  endif

augroup end

"
" Command mode mappings.
"

cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" `<Tab>`/`<S-Tab>` to move between matches without leaving incremental search.
" Note dependency on `'wildcharm'` being set to `<C-z>` in order for this to
" work.
cnoremap <expr> <Tab> getcmdtype() == '/' \|\| getcmdtype() == '?' ? '<CR>/<C-r>/' : '<C-z>'
cnoremap <expr> <S-Tab> getcmdtype() == '/' \|\| getcmdtype() == '?' ? '<CR>?<C-r>/' : '<S-Tab>'

" Tagbar


" for tagbar
nmap <F8> :TagbarToggle<CR>

autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
autocmd FileType javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>
autocmd FileType html vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>


" SuperTab

let g:SuperTabDefaultCompletionType="<c-n>"

" Neovim enhancements

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Vim expand region

" let g:expand_region_use_select_mode = 1

" the amount of space to use after the glyph character (default ' ')
let g:WebDevIconsNerdTreeAfterGlyphPadding = ''

" Store relative line number jumps in the jumplist if they exceed a threshold.
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : '') . 'j'

" Toggle fold at current position.
nnoremap <Tab> za

" Js libraries
" autocmd BufReadPre *.js let b:javascript_lib_use_react = 1

" Make the jk behave

nnoremap j gj
nnoremap k gk

nnoremap ; :

" au FocusLost * :wa

nnoremap <leader>v V`]

" let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Delete current buffer
map <C-c> :BD<cr>

" Tabularize
"
" if exists(':Tabularize')
"   nmap <leader>t= :Tabularize /=<CR>
"   vmap <leader>t= :Tabularize /=<CR>
"   nmap <leader>t: :Tabularize /:\zs<CR>
"   vmap <leader>t: :Tabularize /:\zs<CR>
" endif
"
" inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
"
" function! s:align()
"   let p = '^\s*|\s.*\s|\s*$'
"   if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
"     let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
"     let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
"     Tabularize/|/l1
"     normal! 0
"     call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
"   endif
" endfunction

" Goyo & Limelight

" function! s:goyo_enter()
"   silent !tmux set status off
"   silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
"   set noshowmode
"   set noshowcmd
"   " set scrolloff=999
"   Limelight
"   " ...
" endfunction
"
" function! s:goyo_leave()
"   silent !tmux set status on
"   silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
"   set showmode
"   set showcmd
"   " set scrolloff=5
"   Limelight!
"   " ...
" endfunction
"
" autocmd! User GoyoEnter nested call <SID>goyo_enter()
" autocmd! User GoyoLeave nested call <SID>goyo_leave()
"
" map <leader>z :Goyo<cr>
"
" let g:goyo_width='100%-10%'
"
" let g:goyo_linenr=1


" augroup VimJsxPretty
"   autocmd!
"   autocmd VimEnter *.js,*.jsx highlight jsNoise ctermfg=197 cterm=bold guifg=#F92672 gui=bold
"   autocmd VimEnter *.js,*.jsx highlight jsArrowFunction ctermfg=197 cterm=bold guifg=#F92672 gui=bold
"   autocmd VimEnter *.js,*.jsx highlight jsObjectBraces ctermfg=197 cterm=bold guifg=#F92672 gui=bold
"   autocmd VimEnter *.js,*.jsx highlight jsFuncBraces ctermfg=118 guifg=#A6E22E
"   autocmd VimEnter *.js,*.jsx highlight jsFuncCall ctermfg=228 guifg=#A6A5AE
"   autocmd VimEnter *.js,*.jsx highlight jsBrackets cterm=bold gui=bold
" augroup END

