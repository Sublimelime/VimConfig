" Create abbreviations for html tags {{{
" Call function example: call MakeTagAbbrevs("code","pre","strong")
" this will make tcode, tpre, tstrong expand into html tags.
function! s:MakeTagAbbrevs(...)
    for tagName in a:000
        execute "inoreabbrev <buffer> t" . tagName . " <" . tagName . "></" . tagName . "><C-o>F<<C-o>i"
    endfor
endfunction

" }}}

:echom "Editing a HTML file:"
:echom "[Vis] Press <leader>c to comment out text."
:echom "[Ins] Type thtml to expand to <html></html>, etc."

:setlocal nowrap
:setlocal foldmethod=indent
:vnoremap <buffer> <leader>c <esc>`>a--><esc>`<i<!--<esc>
:call s:MakeTagAbbrevs("i","p","html","div","strong","code","h1","h2","h3")
