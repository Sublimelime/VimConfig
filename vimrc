" Vimrc for config of (g)vim.

" Global Options -------------------{{{1
set nocompatible

" Create missing directories, if any {{{2
if !isdirectory($HOME.'/.vim/swap')
    silent call mkdir($HOME.'/.vim/swap','p')
endif
if !isdirectory($HOME.'/.vim/backup')
    silent call mkdir($HOME.'/.vim/backup','p')
endif
if !isdirectory($HOME.'/.vim/sessions')
    silent call mkdir($HOME.'/.vim/sessions', 'p')
endif

" General options {{{2
filetype indent plugin on
set relativenumber nonumber
syntax on
set confirm noshowmode title autoread autoindent ruler hidden lazyredraw noshowmatch concealcursor=n
set backup writebackup backupdir=~/.vim/backup,.
set noundofile
set swapfile directory=~/.vim/swap,/tmp,.
set lbr textwidth=0 showcmd scrolloff=1 switchbuf=useopen,usetab cursorline
set sessionoptions=curdir,tabpages,folds,buffers,help
set timeoutlen=1500 ttimeout ttimeoutlen=1500 timeout updatetime=7000
set pastetoggle=<F4>
set path+=** "Search down into subdirs
set foldcolumn=1 foldmethod=manual foldlevelstart=0 foldnestmax=7
set nomodeline modelines=1
set tabstop=4 shiftwidth=4 expandtab
set ignorecase infercase smartcase incsearch magic hlsearch gdefault
set wildmenu wildignore=.zip,.gz,.exe,.bin,.odt,.ods
set spelllang=en nospell encoding=utf-8
set viminfo='10,<10,s20,/0,:10
set dictionary=/usr/share/dict/words
set complete=.,w,b,u,i

" Variables/User commands/functions -------------{{{1

let mapleader = "-"
let maplocalleader = "\\"

" Generate a scratch window
command! Scratch :new | setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted

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

" Remove extra whitespace {{{
function! s:StripWhitespace()
    " save last search & cursor position
    let l:search=@/
    let l:l = line(".")
    let l:c = col(".")
    " Remove whitespace from the ends of lines
    :silent! %s:\v\s+$::e
    " Trim empty lines from the end of the file
    :silent! %s:\v($\n\s*)+%$::
    " Trim 3+ blank lines down to 2
    :silent! %s:\v^\n{3,}:\r\r:

    " Return search and cursor pos
    let @/=l:search
    call cursor(l:l, l:c)
    echo "Cleaned whitespace."
endfunction
command! StripWhitespace call <sid>StripWhitespace()
"}}}

" View the difference between the current buffer and it's file on disk.
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

" Force quit vim, no matter what
command! ForceQuit bufdo setlocal nomodified | :q!

" More text objects, creates operator bindings for all the listed chars below, allowing operations between them. {{{
for char in [ '_', '-', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '`' ]
    :silent! execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
    :silent! execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
    :silent! execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
    :silent! execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor
" }}}

" Tab completion {{{
function! s:tabOrComplete()
    if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
        return "\<C-N>"
    else
        return "\<Tab>"
    endif
endfunction
:inoremap <Tab> <C-R>=<SID>tabOrComplete()<CR>
" }}}

" Plugin config ------------{{{1
" Config for autoclose
let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"'}

" Config for RainbowParentheses
let g:rainbow_active = 1

"}}}
" Keybinds ------------------{{{1

" Normal mode {{{2
" Command to toggle spell checking
nnoremap <F10> <Esc>:setlocal spell!<cr>

" View word count
nnoremap <leader>wc g<C-g>

" Toggle syntax highlighting {{{
function! s:ToggleSyntax()
    if exists("g:syntax_on")
        syntax off
    else
        syntax enable
    endif
endfunction
nnoremap <silent> <leader>sy :call <sid>ToggleSyntax()<CR>
"}}}

" Quickly edit/source .vimrc file, and abbrevs file
nnoremap <leader>evf :15split $MYVIMRC<CR>
nnoremap <leader>svf :source $MYVIMRC<CR>
nnoremap <leader>eaf :15split ~/.vim/abbrevs.vim<cr>
nnoremap <leader>saf :source ~/.vim/abbrevs.vim<cr>

" Quickly turn off search highlighting
nnoremap <space> :nohl<cr>

" Quickly reindent file
nnoremap <leader>i mzgg=G`z

" Quick switch buffer
nnoremap <leader>b :ls<CR>:buf<Space>

" Insert mode {{{2
" Jump back and fix most recent error
inoremap <C-s> <esc>[sz=

" Make getting into normal mode easier
inoremap jk <esc>l
inoremap <esc> <nop>

" Make c-return start a new line in insert mode
inoremap <C-Return> <esc>o

" Make c-backspace delete a word
inoremap <C-BS> <esc>bcw

" Visual mode {{{2
" Sort selected text
vnoremap s :sort<cr>

" Move highlighted text up and down in visual mode
vnoremap <Down> :m '>+1<CR>gv=gv
vnoremap <Up> :m '<-2<CR>gv=gv

"}}}2
" Change function of arrow keys {{{
inoremap <Left> <nop>
inoremap <Right> <nop>

" Bind up to enter ONE normal mode command, ie <c-o>
inoremap <Up> <C-o>

" Bind down to insert an expression into the text, ie <C-r>=
inoremap <Down> <C-r>=

" Left and right switch tab
nnoremap <Left> :tabprevious<cr>
nnoremap <Right> :tabn<cr>

" Increase and decrease numbers easily
nnoremap <Up> <C-a>
nnoremap <Down> <C-x>

"}}}
" Misc binds {{{
nnoremap s <C-w>
" Disables diff with :only
nnoremap <silent> <C-w>o :diffoff!<bar>only<cr>
nnoremap Y y$
nnoremap / /\v
nnoremap ? ?\v
onoremap / /\v
onoremap ? ?\v
" Disables Ex mode
nnoremap Q <nop>

" Rebind uppercase versions of h,l to do 'extreme' movements
nnoremap H ^
nnoremap L $

" Sudo save
cnoremap w!! w !sudo tee %

"}}}

" Autocommand (groups) ----------------{{{1

" Source the autocmd file
source ~/.vim/autocmds.vim

" Misc filetypes/autocmds not worth dedicating a group to. {{{2
augroup misc
    autocmd!
    autocmd FileType vim :setlocal foldmethod=marker
    autocmd FileType conf :setlocal nowrap
    autocmd FileType gitcommit :setlocal nobackup noswapfile
    autocmd FileType help :setlocal nospell
    " Exit insert mode automatically after inactivity
    autocmd CursorHoldI * :stopinsert
    " Clean buffer on save
    autocmd BufWritePre * :StripWhitespace
augroup END

" Toggle type of number display between modes {{{2
augroup number_toggle
    autocmd!
    autocmd InsertEnter * :setlocal number norelativenumber
    autocmd InsertLeave * :setlocal relativenumber nonumber
    autocmd WinLeave * :setlocal number norelativenumber
    autocmd WinEnter * :setlocal relativenumber nonumber
augroup END

" Abbriviations ---------------{{{1

source ~/.vim/abbrevs.vim

" Graphical Options -------------------{{{1

set mouse=
colorscheme tango
set guioptions=mai
set guifont=Terminus\ (TTF)\ Medium\ 9,Monospace\ 9

" Statusline config {{{2
set laststatus=2
set statusline=
set statusline+=\ #%n\ %F%m\ %a%< " Number of buffer, file name, modified flag, argument num
set statusline+=\ \ <%{mode()}> " Show current mode in statusline
set statusline+=%=%r\ %h\ %w%{&ff}    " Buffer status info like RO, file format
set statusline+=%y                " file type in brackets
set statusline+=\ \ (%l/%L)\ %p%% " Line position
