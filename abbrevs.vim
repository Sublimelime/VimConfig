" Insert mode

augroup mediawikiabbrevs
    autocmd!
    autocmd FileType mediawiki inoreabbrev <buffer> factorio Factorio
    autocmd FileType mediawiki inoreabbrev <buffer> ingame in-game
    autocmd FileType mediawiki inoreabbrev <buffer> lua Lua
augroup END

function! s:luaAbbrevs()
    inoreabbrev <buffer> def defines
    inoreabbrev <buffer> func function
    inoreabbrev <buffer> g global
    inoreabbrev <buffer> l local
    inoreabbrev <buffer> sonev script
endfunc

augroup luaabbrevs
    autocmd!
    autocmd FileType lua :call s:luaAbbrevs()
augroup END

function! s:textAbbrevs()
    inoreabbrev <buffer> america America
    inoreabbrev <buffer> api API
    inoreabbrev <buffer> cant can't
    inoreabbrev <buffer> carreer career
    inoreabbrev <buffer> didnt didn't
    inoreabbrev <buffer> dont don't
    inoreabbrev <buffer> eachother each other
    inoreabbrev <buffer> english English
    inoreabbrev <buffer> friday Friday
    inoreabbrev <buffer> german German
    inoreabbrev <buffer> goverment government
    inoreabbrev <buffer> havent havent
    inoreabbrev <buffer> hes he's
    inoreabbrev <buffer> i I
    inoreabbrev <buffer> idk I don't know
    inoreabbrev <buffer> im I'm
    inoreabbrev <buffer> isnt isn't
    inoreabbrev <buffer> ive I've
    inoreabbrev <buffer> iwth with
    inoreabbrev <buffer> licence license
    inoreabbrev <buffer> maintenence maintenance
    inoreabbrev <buffer> monday Monday
    inoreabbrev <buffer> neccesary necessary
    inoreabbrev <buffer> neccessary necessary
    inoreabbrev <buffer> noah Noah
    inoreabbrev <buffer> noticeible noticeable
    inoreabbrev <buffer> occor occur
    inoreabbrev <buffer> occorring occurring
    inoreabbrev <buffer> paralell parallel
    inoreabbrev <buffer> reccomended recommended
    inoreabbrev <buffer> recieve receive
    inoreabbrev <buffer> recieved received
    inoreabbrev <buffer> rememver remember
    inoreabbrev <buffer> saturday Saturday
    inoreabbrev <buffer> seperate separate
    inoreabbrev <buffer> sophmore sophomore
    inoreabbrev <buffer> sunday Sunday
    inoreabbrev <buffer> teh the
    inoreabbrev <buffer> tf2 Team Fortress 2
    inoreabbrev <buffer> tge the
    inoreabbrev <buffer> thats that's
    inoreabbrev <buffer> theyd they'd
    inoreabbrev <buffer> theyre theyre
    inoreabbrev <buffer> thier their
    inoreabbrev <buffer> thursday Thursday
    inoreabbrev <buffer> tm &trade;
    inoreabbrev <buffer> tset test
    inoreabbrev <buffer> tuesday Tuesday
    inoreabbrev <buffer> unlicence unlicense
    inoreabbrev <buffer> wednesday Wednesday
    inoreabbrev <buffer> weve we've
    inoreabbrev <buffer> wiki Wiki
    inoreabbrev <buffer> wont won't
    inoreabbrev <buffer> wouldve would've
    inoreabbrev <buffer> ymmv your mileage may vary
    inoreabbrev <buffer> youre you're"
endfunc

augroup textabbrevs
    autocmd!
    autocmd FileType text,mediawiki,markdown :call s:textAbbrevs()
augroup END
