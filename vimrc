" Vimrc for config of (g)vim.

" Global Options -------------------{{{

set nocompatible

" Window size
set columns=140 lines=33 

" General options
filetype indent plugin on
set relativenumber nonumber
syntax on
set confirm title ruler nohidden lazyredraw noshowmatch autoindent autoread nobackup
set lbr textwidth=0 showcmd scrolloff=1
set background=dark
set timeoutlen=1500 ttimeout ttimeoutlen=1500 timeout 
set pastetoggle=<F4>
set foldcolumn=1 foldmethod=manual foldlevelstart=0 foldnestmax=7
set nomodeline modelines=1
set tabstop=4 shiftwidth=4 expandtab
set ignorecase smartcase noincsearch
set wildmenu wildignore=.zip,.gz,.exe,.bin,.odt,.ods
set spelllang=en_us nospell encoding=utf-8
set viminfo='10,<20,s20,/5,:10

" }}}
" Variables/User commands/functions ------------- {{{

let mapleader = "-"
let maplocalleader = "\\"

" Generate a scratch tab 
command! Scratch :tabnew | setlocal buftype=nofile bufhidden=hide noswapfile

" Search all open files for a pattern. {{{
function! s:search_open_files(pattern)
    let l:files = map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'fnameescape(bufname(v:val))')
    try
        silent noautocmd execute "vimgrep /" . a:pattern . "/gj " . join(l:files)
    catch /^Vim\%((\a\+)\)\=:E480/
        echomsg "No match found."
    endtry
    bo cwindow
endf
command! -nargs=1 SearchOpen call <sid>search_open_files(<q-args>)
"}}}

" Create abbreviations for html tags {{{
" Call function example: call MakeTagAbbrevs("code","pre","strong")
" this will make tcode, tpre, tstrong expand into html tags.
function! MakeTagAbbrevs(...)
    for tagName in a:000
        execute "inoreabbrev <buffer> t" . tagName . " <" . tagName . "></" . tagName . "><C-o>F<<C-o>i"
    endfor
endfunction

" }}}

" Open the start file readonly, for reference.
command! Start tab sview ~/.vim/start.txt

"}}}
" Plugin config ------------{{{

" Config for autoclose
let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"'}

" Config for Bullets
let g:bullets_enabled_file_types = ['markdown', 'mediawiki'] 

" Config for NeatStatus
let g:NeatStatusLine_color_filetype = 'guifg=#ffffff guibg=#000000 gui=bold ctermfg=15 ctermbg=9 cterm=bold'

" Config for startscreen {{{
function! Start()
    read !echo "Today is" $(date)
    read ~/.vim/start.txt
    :1
endfunction
let g:Startscreen_function = function('Start')
" }}}

"}}}
" Keybinds ------------------{{{

" Commands to toggle spell checking, fix most recent error
nnoremap <F10> <Esc>:setlocal spell!<cr>
inoremap <C-s> <esc>[sz=

" Toggling search word highlighting, toggle with shift-h
nnoremap <silent> <leader>hs :setlocal hls!<cr>

" View word count
nnoremap <leader>wc g<C-g>

" Toggle syntax highlighting {{{
function! ToggleSyntax()
    if exists("g:syntax_on")
        syntax off
    else
        syntax enable
    endif
endfunction
nnoremap <silent> <leader>sy :call ToggleSyntax()<CR>
" }}}

" Quickly edit/source .vimrc file
nnoremap <leader>evf :tabedit $MYVIMRC<CR>
nnoremap <leader>svf :source $MYVIMRC<CR>

" Change function of arrow keys {{{
inoremap <Left> <nop>
inoremap <Right> <nop>

" Bind up to enter ONE normal mode command, ie <c-o>
inoremap <Up> <C-o>

" Bind down to insert an expression into the text, ie <C-r>=
inoremap <Down> <C-r>=

" Bind arrow keys to change/manipulate tabs in normal mode 
nnoremap <silent> <Left> :tabprevious<cr>
nnoremap <silent> <Right> :tabnext<cr>
nnoremap <silent> <C-Right> :tablast<cr>
nnoremap <silent> <C-Left> :tabfirst<cr>
nnoremap <C-Up> :Texplore<cr>
nnoremap <Up> :tabnew<cr>
nnoremap <silent> <Down> :tabclose<cr>
nnoremap <silent> <C-Down> :tabonly<cr>
"}}}

" Make getting into normal mode easier
inoremap jk <esc>l
inoremap <esc> <nop>

" Sort selected text
vnoremap s :sort<cr>

" Misc self-explanatory binds
nnoremap s <C-w>
onoremap p i(
nnoremap Y y$

"}}}
" Autocommand (groups) ----------------{{{

" Misc filetypes not worth dedicating a group to. {{{
augroup misc_filetype
    autocmd!
    autocmd FileType vim :setlocal foldmethod=marker
    autocmd FileType config :setlocal nowrap
    autocmd FileType help :set nospell
augroup END
"}}}

augroup number_toggle
    autocmd!
    autocmd InsertEnter * :setlocal number norelativenumber
    autocmd InsertLeave * :setlocal relativenumber nonumber
augroup END

" Settings for editing HTML files {{{
augroup filetype_html
    autocmd!
    autocmd FileType html :echom "Editing a HTML file:"
    autocmd FileType html :echom "[Vis] Press <leader>c to comment out text."
    autocmd FileType html :echom "[Ins] Type thtml to expand to <html></html>, etc."

    autocmd FileType html :setlocal nowrap
    autocmd FileType html :setlocal foldmethod=indent
    autocmd BufWritePre,BufRead *.html :normal! gg=G
    autocmd FileType html :vnoremap <buffer> <leader>c <esc>`>a--><esc>`<i<!--<esc>
    autocmd FileType html :call MakeTagAbbrevs("i","p","html","div","strong","code")
augroup END
"}}}

" Settings for editing mediawiki files {{{
augroup filetype_mediawiki
    autocmd!

    autocmd FileType mediawiki :echom "Editing a mediawiki file:"
    autocmd FileType mediawiki :echom "[Vis] Press <leader>c to comment out text."
    autocmd FileType mediawiki :echom "[Vis] Press <leader>[ to surround text in double square brackets. [[eg]]"
    autocmd FileType mediawiki :echom "[Vis] Press <leader>{ to surround text in curly brackets. {{eg}}" 
    autocmd FileType mediawiki :echom "[Ins] Press <leader>== to surround a line in equal signs. ==eg=="
    autocmd FileType mediawiki :echom "[Ins] Type tcode to expand to <code></code>, etc."

    " comment text out
    autocmd FileType mediawiki :vnoremap <buffer> <leader>c <esc>`>a--><esc>`<i<!--<esc> 

    " Surround a word in brackets.
    autocmd FileType mediawiki :vnoremap <buffer> <leader>[ <esc>`>a]]<esc>`<i[[<esc> 
    autocmd FileType mediawiki :vnoremap <buffer> <leader>{ <esc>`>a}}<esc>`<i{{<esc> 

    " Surround a line in equal signs
    autocmd FileType mediawiki :inoremap <buffer> <leader>== <esc>I==<esc>A==<esc>o

    autocmd FileType mediawiki setlocal spell textwidth=120

    " Enable folding based on ==sections==
    autocmd FileType mediawiki setlocal foldexpr=getline(v:lnum)=~'^\\(=\\+\\)[^=]\\+\\1\\(\\s*<!--.*-->\\)\\=\\s*$'?\">\".(len(matchstr(getline(v:lnum),'^=\\+'))-1):\"=\"
    autocmd FileType mediawiki setlocal foldmethod=expr

    " Setup Snippets
    autocmd FileType mediawiki :inoreabbrev <buffer> wtable {\|<space>class="wikitable"<cr>\|-<cr>!Option1!!Option2!!Option3<cr>}
    autocmd FileType mediawiki :inoreabbrev <buffer> cate [[Category:]]<left><left>
    autocmd FileType mediawiki :inoreabbrev br <br>
    autocmd FileType mediawiki :inoreabbrev sig --~~~~
    autocmd FileType mediawiki :call MakeTagAbbrevs("nowiki","pre","code","strong","includeonly","noinclude")

augroup END
"}}}

" Settings for editing text files {{{
augroup filetype_text
    autocmd!
    autocmd FileType text :echom "Editing a text file:"
    autocmd FileType text setlocal spell modeline
augroup END
"}}}

" Settings for editing markdown files {{{
augroup filetype_markdown
    autocmd!

    autocmd FileType markdown :echom "Editing a markdown file:"
    autocmd FileType markdown :echom "[Vis] Press <leader>i to italicize some text."
    autocmd FileType markdown :echom "[Vis] Press <leader>b to bolden some text."
    autocmd FileType markdown :setlocal spell modeline

    " Text formatting
    autocmd FileType markdown :vnoremap <buffer> <leader>i <esc>`>a*<esc>`<i*<esc>
    autocmd FileType markdown :vnoremap <buffer> <leader>b <esc>`>a**<esc>`<i**<esc>

augroup END
"}}}

"}}}
" Abbriviations ---------------{{{

" Insert mode
inoreabbrev i I
inoreabbrev recieve receive
inoreabbrev english English
inoreabbrev america America
inoreabbrev tf2 Team Fortress 2
inoreabbrev factorio Factorio
inoreabbrev tm &trade;
inoreabbrev thier their
inoreabbrev youre you're
inoreabbrev cant can't
inoreabbrev wont won't
inoreabbrev dont don't
inoreabbrev havent haven't
inoreabbrev neccesary necessary
inoreabbrev neccessary necessary
inoreabbrev ive I've
inoreabbrev im I'm
inoreabbrev hes he's
inoreabbrev noah Noah
inoreabbrev tset test
inoreabbrev wiki Wiki
inoreabbrev monday Monday
inoreabbrev tuesday Tuesday
inoreabbrev wednesday Wednesday
inoreabbrev thursday Thursday
inoreabbrev friday Friday
inoreabbrev saturday Saturday
inoreabbrev sunday Sunday
inoreabbrev occor occur
inoreabbrev occorring occurring
inoreabbrev didnt didn't
inoreabbrev thats that's
inoreabbrev goverment government
inoreabbrev theyre they're

" Command line
cnoreabbrev man help

"}}}
" GUI Options -------------------{{{

if has("gui_running")
    colorscheme torte
    set mouse=
    set guioptions=mai
    set guifont=Terminus\ (TTF)\ Medium\ 12,Monospace\ 9
endif

"}}}
