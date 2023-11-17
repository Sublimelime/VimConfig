" Insert mode

function! s:mediawikiAbbrevs() " {{{
    inoreabbrev <buffer> factorio Factorio
    inoreabbrev <buffer> ingame in-game
    inoreabbrev <buffer> lua Lua
    inoreabbrev <buffer> wube Wube
    :inoreabbrev <buffer> wtable
                \ {<bar><space>class="wikitable"<cr><bar>-<cr>!Option1!!Option2!!Option3<cr><bar>-<cr><bar>Value1<bar><bar>Value2<bar><bar>Value3<cr><bar>-<cr><bar>}

    :inoreabbrev <buffer> wcollapse
                \ <div class="toccolours mw-collapsible mw-collapsed"<space>style="width:800px"><cr>Show this<cr>
                \<div class="mw-collapsible-content"><cr>Content here<cr></div></div><cr>

    :inoreabbrev <buffer> cate [[Category:]]<left><left>
    :inoreabbrev <buffer> br <br>
    :inoreabbrev <buffer> sig --~~~~
    :inoreabbrev <buffer> wcolor <span style="color:"></span>
    :inoreabbrev <buffer> whistory {{History<bar>0.1.0<bar><cr>*<space>Introduced}}
endfunc
" }}}

function! s:luaAbbrevs() " {{{
    inoreabbrev <buffer> def defines
    inoreabbrev <buffer> func function
    inoreabbrev <buffer> g global
    inoreabbrev <buffer> l local
    inoreabbrev <buffer> sonev script.on_event(defines.events.
    inoreabbrev <buffer> sonin script.on_init(
    inoreabbrev <buffer> soncfg script.on_configuration_changed(
    inoreabbrev <buffer> neq name =
    inoreabbrev <buffer> teq type =
    inoreabbrev <buffer> fori for index, something in pairs() do<esc>2Fs
    inoreabbrev <buffer> gp game.print()<left>
endfunc
" }}}

function! s:textAbbrevs() " {{{
    inoreabbrev <buffer> acessed accessed
    inoreabbrev <buffer> america America
    inoreabbrev <buffer> api API
    inoreabbrev <buffer> appriciated appreciated
    inoreabbrev <buffer> bernoulli Bernoulli
    inoreabbrev <buffer> canada Canada
    inoreabbrev <buffer> cant can't
    inoreabbrev <buffer> carreer career
    inoreabbrev <buffer> celcius Celsius
    inoreabbrev <buffer> centripedal centripetal
    inoreabbrev <buffer> consistant consistent
    inoreabbrev <buffer> continous continuous
    inoreabbrev <buffer> darwin Darwin
    inoreabbrev <buffer> dependant dependent
    inoreabbrev <buffer> didnt didn't
    inoreabbrev <buffer> disterbance disturbance
    inoreabbrev <buffer> disterbence disturbance
    inoreabbrev <buffer> dont don't
    inoreabbrev <buffer> eachother each other
    inoreabbrev <buffer> english English
    inoreabbrev <buffer> friday Friday
    inoreabbrev <buffer> german German
    inoreabbrev <buffer> goverment government
    inoreabbrev <buffer> grey gray
    inoreabbrev <buffer> greyscale grayscale
    inoreabbrev <buffer> gurantee guarantee
    inoreabbrev <buffer> gurantees guarantees
    inoreabbrev <buffer> havent havent
    inoreabbrev <buffer> hes he's
    inoreabbrev <buffer> i I
    inoreabbrev <buffer> idk I don't know
    inoreabbrev <buffer> im I'm
    inoreabbrev <buffer> independant independent
    inoreabbrev <buffer> isnt isn't
    inoreabbrev <buffer> isostacy isostasy
    inoreabbrev <buffer> ive I've
    inoreabbrev <buffer> iwth with
    inoreabbrev <buffer> judgement judgment
    inoreabbrev <buffer> jurassic Jurassic
    inoreabbrev <buffer> licence license
    inoreabbrev <buffer> maintenence maintenance
    inoreabbrev <buffer> maximising maximizing
    inoreabbrev <buffer> monday Monday
    inoreabbrev <buffer> neccesary necessary
    inoreabbrev <buffer> neccessary necessary
    inoreabbrev <buffer> noah Noah
    inoreabbrev <buffer> noticeible noticeable
    inoreabbrev <buffer> occor occur
    inoreabbrev <buffer> occored occurred
    inoreabbrev <buffer> occorring occurring
    inoreabbrev <buffer> occured occurred
    inoreabbrev <buffer> occurence occurrence
    inoreabbrev <buffer> occuring occurring
    inoreabbrev <buffer> oppertunities opportunities
    inoreabbrev <buffer> oppertunity opportunity
    inoreabbrev <buffer> optimise optimize
    inoreabbrev <buffer> paralell parallel
    inoreabbrev <buffer> percieve perceive
    inoreabbrev <buffer> personell personnel
    inoreabbrev <buffer> probablity probability
    inoreabbrev <buffer> protien protein
    inoreabbrev <buffer> protiens proteins
    inoreabbrev <buffer> reccomended recommended
    inoreabbrev <buffer> recieve receive
    inoreabbrev <buffer> recieved received
    inoreabbrev <buffer> recieving receiving
    inoreabbrev <buffer> rememver remember
    inoreabbrev <buffer> sattelite satellite
    inoreabbrev <buffer> sattellite satellite
    inoreabbrev <buffer> saturday Saturday
    inoreabbrev <buffer> seperate separate
    inoreabbrev <buffer> seperated separated
    inoreabbrev <buffer> seperating separating
    inoreabbrev <buffer> seperation separation
    inoreabbrev <buffer> sofware software
    inoreabbrev <buffer> sophmore sophomore
    inoreabbrev <buffer> sunday Sunday
    inoreabbrev <buffer> suprised surprised
    inoreabbrev <buffer> suprized surprised
    inoreabbrev <buffer> teh the
    inoreabbrev <buffer> tf2 Team Fortress 2
    inoreabbrev <buffer> tge the
    inoreabbrev <buffer> thats that's
    inoreabbrev <buffer> theyd they'd
    inoreabbrev <buffer> theyre theyre
    inoreabbrev <buffer> thier their
    inoreabbrev <buffer> thursday Thursday
    inoreabbrev <buffer> troph trough
    inoreabbrev <buffer> tset test
    inoreabbrev <buffer> tuesday Tuesday
    inoreabbrev <buffer> unlicence unlicense
    inoreabbrev <buffer> varience variance
    inoreabbrev <buffer> wasnt wasn't
    inoreabbrev <buffer> wednesday Wednesday
    inoreabbrev <buffer> weve we've
    inoreabbrev <buffer> wiki Wiki
    inoreabbrev <buffer> wont won't
    inoreabbrev <buffer> wouldve would've
    inoreabbrev <buffer> youre you're

endfunc
" }}}

function! s:rustAbbrevs() " {{{
    inoreabbrev <buffer> sout println!("{}");<left><left><left>
    inoreabbrev <buffer> lm let mut
    inoreabbrev <buffer> refmut &mut
    inoreabbrev <buffer> fori for i in xxx {<cr>}
endfunc
" }}}

augroup abbrevsaugroup
    autocmd!
    autocmd FileType lua :call <SID>luaAbbrevs()
    autocmd FileType mediawiki :call <SID>mediawikiAbbrevs()
    autocmd FileType text,mediawiki,markdown :call <SID>textAbbrevs()
    autocmd FileType rust :call <SID>rustAbbrevs()
augroup END
