" TODO: complete `find` arg names too
" TODO: check escaping is correct
command! -nargs=* -complete=file Find call commands#find(<q-args>)

command! -nargs=* -complete=file -range OpenOnGitHub <line1>,<line2>call commands#open_on_github(<f-args>)

command! Lint call commands#lint()

command! Typecheck call commands#typecheck()

command! Vim call commands#vim()

" Markdown previews.
command! -nargs=? -complete=file Glow call commands#glow(<q-args>)
command! -nargs=* -complete=file Marked call commands#marked(<q-args>)
command! -nargs=* -complete=file Preview call commands#preview(<q-args>)
