" Vimrc for config of (g)vim.

" Global Options -------------------{{{1
set nocompatible

if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

" General options
filetype indent plugin on
set relativenumber nonumber
syntax on
set confirm noshowmode title autoread autoindent ruler hidden lazyredraw showmatch concealcursor=n
set nobackup
set noundofile exrc secure
set noswapfile
set lbr textwidth=0 showcmd scrolloff=1 switchbuf=useopen,usetab nocursorline
set sessionoptions=sesdir,tabpages,folds,buffers,resize,winsize,winpos
set timeoutlen=1500 ttimeout ttimeoutlen=1500 timeout updatetime=7000
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
endfunction
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

" Config for :grep command
if executable("rg") "If ripgrep is installed
    set grepprg=rg
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" Plugin config ------------{{{1

" Lualine
:lua << END
require'lualine'.setup {
    options = {
        theme = 'everforest',
        icons_enabled = false
    }
    }
END

" Treesitter
if g:os != "Windows"
    source ~/.config/nvim/treesitterConfig.lua
endif

" Autopairs
source ~/.config/nvim/autopairsConfig.lua

" LSP config
if g:os != "Windows"
    packadd! nvim-lspconfig
    let g:coq_settings = { 'auto_start': 'shut-up' }
    source ~/.config/nvim/lspconfigConfig.lua
endif

"}}}
" Keybinds {{{1
if g:os == "Windows"
    source $HOME\AppData\Local\nvim\keybinds.vim
else
    source ~/.config/nvim/keybinds.vim
endif

" Autocommand (groups) ----------------{{{1

" Source the autocmd file
if g:os == "Windows"
    source $HOME\AppData\Local\nvim\autocmds.vim
else
    source ~/.config/nvim/autocmds.vim
endif

" Misc filetypes/autocmds not worth dedicating a group to. {{{2
augroup misc
    autocmd!
    autocmd FileType vim :setlocal foldmethod=marker
    autocmd FileType conf :setlocal nowrap foldmethod=marker
    autocmd FileType gitcommit :setlocal nobackup noswapfile
    autocmd FileType help :setlocal nospell
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

if g:os == "Windows"
    source $HOME\AppData\Local\nvim\abbrevs.vim
else
    source ~/.config/nvim/abbrevs.vim
endif

" Graphical Options -------------------{{{1

" Colorscheme
packadd! everforest
if has('termguicolors')
    set termguicolors
endif
set background=light
let g:everforest_background = 'soft'
let g:everforest_better_performance = 1
colorscheme everforest
