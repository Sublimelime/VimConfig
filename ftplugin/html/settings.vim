" Create abbreviations for html tags {{{
" Call function example: call MakeTagAbbrevs("code","pre","strong")
" this will make tcode, tpre, tstrong expand into html tags.
function! s:MakeTagAbbrevs(...)
    for tagName in a:000
        execute "inoreabbrev <buffer> t" . tagName . " <" . tagName . "></" . tagName . "><C-o>F<<C-o>i"
    endfor
endfunction

" }}}
if (&filetype == 'html') "Because of conflicts with the markdown support 
    :call s:MakeTagAbbrevs("i","p","html","div","strong","code","h1","h2","h3")
endif
