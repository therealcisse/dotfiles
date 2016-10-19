" " Fix conceal cursor jumps
"
" function! ForwardSkipConceal(count)
"     let cnt=a:count
"     let mvcnt=0
"     let c=col('.')
"     let l=line('.')
"     let lc=col('$')
"     let line=getline('.')
"     while cnt
"         if c>=lc
"             let mvcnt+=cnt
"             break
"         endif
"         if stridx(&concealcursor, 'n')==-1
"             let isconcealed=0
"         else
"             let [isconcealed, cchar, group] = synconcealed(l, c)
"         endif
"         if isconcealed
"             let cnt-=strchars(cchar)
"             let oldc=c
"             let c+=1
"             while c < lc
"               let [isconcealed2, cchar2, group2] = synconcealed(l, c)
"               if !isconcealed2 || cchar2 != cchar
"                   break
"               endif
"               let c+= 1
"             endwhile
"             let mvcnt+=strchars(line[oldc-1:c-2])
"         else
"             let cnt-=1
"             let mvcnt+=1
"             let c+=len(matchstr(line[c-1:], '.'))
"         endif
"     endwhile
"     return ":\<C-u>\e".mvcnt.'l'
" endfunction
"
" function! BackwardSkipConceal(count)
"     let cnt=a:count
"     let mvcnt=0
"     let c=col('.')
"     let l=line('.')
"     let lc=0
"     let line=getline('.')
"     while cnt
"         if c<=1
"             let mvcnt+=cnt
"             break
"         endif
"         if stridx(&concealcursor, 'n')==-1 || c == 0
"             let isconcealed=0
"         else
"             let [isconcealed, cchar, group]=synconcealed(l, c-1)
"         endif
"         if isconcealed
"             let cnt-=strchars(cchar)
"             let oldc=c
"             let c-=1
"             while c>1
"               let [isconcealed2, cchar2, group2] = synconcealed(l, c-1)
"               if !isconcealed2 || cchar2 != cchar
"                   break
"               endif
"               let c-=1
"             endwhile
"             let c = max([c, 1])
"             let mvcnt+=strchars(line[c-1:oldc-2])
"         else
"             let cnt-=1
"             let mvcnt+=1
"             let c-=len(matchstr(line[:c-2], '.$'))
"         endif
"     endwhile
"     return ":\<C-u>\e".mvcnt.'h'
" endfunction
"
" nnoremap <expr> l ForwardSkipConceal(v:count1)
" nnoremap <expr> h BackwardSkipConceal(v:count1)
