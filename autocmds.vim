" A file used to store filetype based settings.

" Lisp {{{1
augroup lispaugroup
    autocmd!
    " Create a command to fetch docs on a lisp symbol.
    autocmd FileType lisp command! -buffer -nargs=1 LispDoc :!sbcl --noinform --quit --eval "(describe <args>)" <bar> more

    " Set makeprg so :make runs the current file
    autocmd FileType lisp setlocal makeprg=sbcl\ --script\ %
augroup END

" Mediawiki {{{1
augroup mediawikiaugroup
    autocmd!
    " Wikipedia articles often only have line-breaks at the end of each paragraph,
    " a situation Vim by default doesn't handle as other text editors.
    autocmd FileType mediawiki setlocal wrap linebreak
    autocmd FileType mediawiki setlocal textwidth=0

    " No auto-wrap at all
    autocmd FileType mediawiki setlocal formatoptions-=tc formatoptions+=l
    autocmd FileType mediawiki setlocal formatoptions-=a

    " Make navigation more amenable to the long wrapping lines.
    autocmd FileType mediawiki nnoremap <buffer> k gk
    autocmd FileType mediawiki nnoremap <buffer> j gj
    autocmd FileType mediawiki nnoremap <buffer> 0 g0
    autocmd FileType mediawiki nnoremap <buffer> ^ g^
    autocmd FileType mediawiki nnoremap <buffer> $ g$

    " utf-8 should be set if not already done globally
    autocmd FileType mediawiki setlocal fileencoding=utf-8

    " comment text out
    autocmd FileType mediawiki :vnoremap <buffer> <leader>c <esc>`>a--><esc>`<i<!--<esc>

    " Surround some text in brackets.
    autocmd FileType mediawiki :vnoremap <buffer> <leader>[ <esc>`>a]]<esc>`<i[[<esc>
    autocmd FileType mediawiki :vnoremap <buffer> <leader>{ <esc>`>a}}<esc>`<i{{<esc>

    " Surround a line in equal signs
    autocmd FileType mediawiki :inoremap <buffer> <leader>== <esc>I==<esc>A==<esc>o

    " Surround some text in apostrophes.
    autocmd FileType mediawiki :vnoremap <buffer> <leader>' <esc>`>a'<esc>`<i'<esc>

    autocmd FileType mediawiki :setlocal spell
    autocmd FileType mediawiki setlocal complete=.,w,b,u,i,k
augroup END

" Markdown {{{1
augroup markdownaugroup
    autocmd!

    autocmd FileType markdown :setlocal spell modeline wrap
    autocmd FileType markdown setlocal complete=.,w,b,u,i,k

    " Text formatting
    autocmd FileType markdown :vnoremap <buffer> <leader>i <esc>`>a*<esc>`<i*<esc>
    autocmd FileType markdown :vnoremap <buffer> <leader>b <esc>`>a**<esc>`<i**<esc>

    " Maps
    autocmd FileType markdown nnoremap <buffer> k gk
    autocmd FileType markdown nnoremap <buffer> j gj
augroup END

" Lua {{{1
augroup luaaugroup
    autocmd!
    autocmd FileType lua setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 foldmethod=indent complete=.,w,b,u,i
    autocmd FileType lua setlocal listchars=tab:\|. list
    " Retab on save
    autocmd BufWritePre *.lua :retab!
augroup END

" Text {{{1
augroup textaugroup
    autocmd!
    autocmd FileType text setlocal spell modeline
    autocmd FileType text nnoremap <buffer> k gk
    autocmd FileType text nnoremap <buffer> j gj
    autocmd FileType text setlocal complete=.,w,b,u,i,k
augroup END

" HTML {{{1
augroup htmlaugroup
    autocmd!
    autocmd FileType html :setlocal nowrap
    autocmd FileType html :setlocal foldmethod=indent
    autocmd FileType html :vnoremap <buffer> <leader>c <esc>`>a--><esc>`<i<!--<esc>
augroup END
" Rust {{{1

augroup rustaugroup
    autocmd!
    autocmd FileType rust setlocal makeprg=cargo\ build
    autocmd FileType rust setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 foldmethod=marker
    autocmd FileType rust setlocal complete=.,w,b,t,u,i nolist suffixesadd=.rs nocindent smarttab
    autocmd FileType rust silent! setlocal formatoptions+=j

    " Configure errorformat {{{
    autocmd FileType rust setlocal errorformat=
                \%f:%l:%c:\ %t%*[^:]:\ %m,
                \%f:%l:%c:\ %*\\d:%*\\d\ %t%*[^:]:\ %m,
                \%-G%f:%l\ %s,
                \%-G%*[\ ]^,
                \%-G%*[\ ]^%*[~],
                \%-G%*[\ ]...

    autocmd FileType rust setlocal errorformat+=
                \%-G,
                \%-Gerror:\ aborting\ %.%#,
                \%-Gerror:\ Could\ not\ compile\ %.%#,
                \%Eerror:\ %m,
                \%Eerror[E%n]:\ %m,
                \%Wwarning:\ %m,
                \%Inote:\ %m,
                \%C\ %#-->\ %f:%l:%c

    autocmd FileType rust setlocal errorformat+=
                \%-G%\\s%#Downloading%.%#,
                \%-G%\\s%#Compiling%.%#,
                \%-G%\\s%#Finished%.%#,
                \%-G%\\s%#error:\ Could\ not\ compile\ %.%#,
                \%-G%\\s%#To\ learn\ more\\,%.%#
    " }}}
    autocmd FileType rust setlocal comments=s0:/*!,m:\ ,ex:*/,s1:/*,mb:*,ex:*/,:///,://!,://
    autocmd FileType rust setlocal commentstring=//%s formatoptions-=t formatoptions+=croqnl
    autocmd FileType rust inoremap <buffer> {; {<CR><BS>}<Esc>ko
augroup END

" Python {{{1

augroup pythonaugroup
    autocmd!
    autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79
    autocmd FileType python setlocal expandtab autoindent fileformat=unix
augroup END
