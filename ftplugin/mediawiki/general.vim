" Wikipedia articles often only have line-breaks at the end of each paragraph,
" a situation Vim by default doesn't handle as other text editors.
setlocal wrap linebreak
setlocal textwidth=0

" No auto-wrap at all
setlocal formatoptions-=tc formatoptions+=l
if v:version >= 602 | setlocal formatoptions-=a | endif

" Make navigation more amenable to the long wrapping lines.
nnoremap <buffer> k gk
nnoremap <buffer> j gj
nnoremap <buffer> 0 g0
nnoremap <buffer> ^ g^
nnoremap <buffer> $ g$

" utf-8 should be set if not already done globally
setlocal fileencoding=utf-8

" Treat lists, indented text and tables as comment lines and continue with the
" same formatting in the next line (i.e. insert the comment leader) when hitting
"  or using "o".
setlocal comments=n:#,n:*,n:\:,s:{\|,m:\|,ex:\|}
setlocal formatoptions+=roq
