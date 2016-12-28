" Create abbreviations for html tags {{{
" Call function example: call MakeTagAbbrevs("code","pre","strong")
" this will make tcode, tpre, tstrong expand into html tags.
function! s:MakeTagAbbrevs(...)
    for tagName in a:000
        execute "inoreabbrev <buffer> t" . tagName . " <" . tagName . "></" . tagName . "><C-o>F<<C-o>i"
    endfor
endfunction

" }}}

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

" Intro messages {{{
:echom "Editing a mediawiki file:"
:echom "[Vis] Press <leader>c to comment out text."
:echom "[Vis] Press <leader>[ to surround text in double square brackets. [[eg]]"
:echom "[Vis] Press <leader>{ to surround text in curly brackets. {{eg}}"
:echom "[Ins] Press <leader>== to surround a line in equal signs. ==eg=="
:echom "[Ins] Type tcode to expand to <code></code>, etc."
:echom "[Ins] Type wtable to expand into a MediaWiki table."
:echom "[Ins] Type wcollapse to expand into a collapsible text box."
    "}}}

" comment text out
:vnoremap <buffer> <leader>c <esc>`>a--><esc>`<i<!--<esc>

" Surround some text in brackets.
:vnoremap <buffer> <leader>[ <esc>`>a]]<esc>`<i[[<esc>
:vnoremap <buffer> <leader>{ <esc>`>a}}<esc>`<i{{<esc>

" Surround a line in equal signs
:inoremap <buffer> <leader>== <esc>I==<esc>A==<esc>o

" Surround some text in apostrophes.
:vnoremap <buffer> <leader>' <esc>`>a'<esc>`<i'<esc>

:setlocal spell

" Setup Snippets {{{
:inoreabbrev <buffer> wtable
                \ {<bar><space>class="wikitable"<cr><bar>-<cr>!Option1!!Option2!!Option3<cr><bar>-<cr><bar>Value1<bar><bar>Value2<bar><bar>Value3<cr><bar>-<cr><bar>}

:inoreabbrev <buffer> wcollapse
                \ <div class="toccolours mw-collapsible mw-collapsed"<space>style="width:800px"><cr>Show this<cr>
                \<div class="mw-collapsible-content"><cr>Content here<cr></div></div><cr>

:inoreabbrev <buffer> cate [[Category:]]<left><left>
:inoreabbrev <buffer> br <br>
:inoreabbrev <buffer> sig --~~~~
:call s:MakeTagAbbrevs("nowiki","pre","code","strong","includeonly","noinclude","sup","sub")
"}}}
