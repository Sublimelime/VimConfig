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
set confirm noshowmode title autoread autoindent ruler hidden lazyredraw showmatch concealcursor=n
set backup writebackup backupdir=~/.vim/backup,.
set noundofile exrc secure
set swapfile directory=~/.vim/swap,/tmp,.
set lbr textwidth=0 showcmd scrolloff=1 switchbuf=useopen,usetab nocursorline
set sessionoptions=sesdir,tabpages,folds,buffers,resize,winsize,winpos
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
set nolist listchars=tab:\|.
set synmaxcol=1000 laststatus=2 diffopt+=iwhiteall


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

" Tab completion {{{
" Commented out to allow using YCM
"function! s:tabOrComplete()
"    if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
"        return "\<C-N>"
"    else
"        return "\<Tab>"
"    endif
"endfunction
":inoremap <Tab> <C-R>=<SID>tabOrComplete()<CR>
" }}}

" Config for :grep command
if executable("rg") "If ripgrep is installed
    set grepprg=rg
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" Plugin config ------------{{{1
" Config for autoclose
let g:AutoPairs = {'(': ')', '`':'`', '{': '}', '[': ']', '"': '"'}

" Config for RainbowParentheses
let g:rainbow_active = 1
let g:rainbow_conf = {
            \	'ctermfgs': ['black', 'darkred', 'blue', 'darkmagenta', 'green']}

" Config for ale
let g:ale_rust_cargo_use_check = 1

" Config for YCM
" Blacklist certain filetypes from activating ycm
let g:ycm_filetype_blacklist = {
      \ 'tagbar': 1,
      \ 'netrw': 1,
      \ 'unite': 1,
      \ 'vimwiki': 1,
      \ 'pandoc': 1,
      \ 'infolog': 1,
      \ 'mail': 1
      \}
let g:ycm_complete_in_comments = 1 " Assists in writing comments
let g:ycm_autoclose_preview_window_after_insertion = 1


"}}}
" Keybinds {{{1

source ~/.vim/keybinds.vim

" Autocommand (groups) ----------------{{{1

" Source the autocmd file
source ~/.vim/autocmds.vim

" Misc filetypes/autocmds not worth dedicating a group to. {{{2
augroup misc
    autocmd!
    autocmd FileType vim :setlocal foldmethod=marker
    autocmd FileType conf :setlocal nowrap foldmethod=marker
    autocmd FileType gitcommit :setlocal nobackup noswapfile
    autocmd FileType help :setlocal nospell
    " Exit insert mode automatically after inactivity
    autocmd CursorHoldI * :stopinsert
    autocmd CursorHold * :nohls
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

" Colorscheme
set background=light
" Enable fancy 24 bit color support if possible
if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
colorscheme lucius

set guioptions=mai
set guifont=Terminus\ (TTF)\ Medium\ 9,Monospace\ 9
set mouse=
