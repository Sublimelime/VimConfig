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
set noconfirm title ruler hidden lazyredraw noshowmatch autoindent autoread concealcursor=n
set backup writebackup backupdir=~/.vim/backup,.
set noundofile
set swapfile directory=~/.vim/swap,/tmp,.
set lbr textwidth=0 showcmd scrolloff=1 switchbuf=useopen,usetab cursorline
set sessionoptions=curdir,tabpages,folds,buffers,help
set timeoutlen=1500 ttimeout ttimeoutlen=1500 timeout updatetime=7000
set pastetoggle=<F4>
set foldcolumn=1 foldmethod=manual foldlevelstart=0 foldnestmax=7
set nomodeline modelines=1
set tabstop=4 shiftwidth=4 expandtab
set ignorecase smartcase incsearch magic hlsearch
set wildmenu wildignore=.zip,.gz,.exe,.bin,.odt,.ods
set spelllang=en nospell encoding=utf-8
set viminfo='10,<10,s20,/5,:10
set gdefault


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
    :silent! %s/\s\+$//e
    " Trim empty lines from the end of the file
    :silent! %s#\($\n\s*\)\+\%$##

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

" Toggle syntax highlighting
function! s:ToggleSyntax()
    if exists("g:syntax_on")
        syntax off
    else
        syntax enable
    endif
endfunction
nnoremap <silent> <leader>sy :call <sid>ToggleSyntax()<CR>

" Quickly edit/source .vimrc file, and abbrevs file
nnoremap <leader>evf :15split $MYVIMRC<CR>
nnoremap <leader>svf :source $MYVIMRC<CR>
nnoremap <leader>eaf :15split ~/.vim/abbrevs.vim<cr>
nnoremap <leader>saf :source ~/.vim/abbrevs.vim<cr>

" Quickly turn off search highlighting
nnoremap <space> :nohl<cr>

" Insert mode {{{2
" Jump back and fix most recent error
inoremap <C-s> <esc>[sz=

" Make getting into normal mode easier
inoremap jk <esc>l
inoremap <esc> <nop>

" Visual mode {{{2
" Sort selected text
nnoremap s :sort<cr>

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

"Bind left and right to switch between tabs
nnoremap <Left> <nop>
nnoremap <Right> <nop>

"}}}
" Misc self-explanatory binds {{{
nnoremap s <C-w>
onoremap p i(
nnoremap Y y$
nnoremap / /\v
nnoremap ? ?\v

" Rebind uppercase versions of h,l to do 'extreme' movements
nnoremap H ^
nnoremap L $
"}}}

" Autocommand (groups) ----------------{{{1

" Misc filetypes/autocmds not worth dedicating a group to. {{{2
augroup misc
    autocmd!
    autocmd FileType vim :setlocal foldmethod=marker
    autocmd FileType conf :setlocal nowrap
    autocmd FileType gitcommit :setlocal nobackup noswapfile
    autocmd FileType help :set nospell
    " CD into the dir of the opened file
    autocmd BufEnter * execute "cd! ".escape(expand("%:p:h"), ' ')
    " Jump back to the last edited position
    autocmd BufReadPost * if line("'\"") | execute "normal `\"" | endif
    " Exit insert mode automatically after inactivity
    autocmd CursorHoldI * :stopinsert
    autocmd BufWritePre :StripWhitespace
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

set columns=135 lines=33
set mouse=
