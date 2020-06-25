" Normal mode {{{1

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

" Quickly edit/source .vimrc file, keybinds, and abbrevs file
nnoremap <leader>evf :15split $MYVIMRC<CR>
nnoremap <leader>svf :source $MYVIMRC<CR>
nnoremap <leader>eaf :15split ~/.vim/abbrevs.vim<cr>
nnoremap <leader>saf :source ~/.vim/abbrevs.vim<cr>
nnoremap <leader>ekf :15split ~/.vim/keybinds.vim<cr>
nnoremap <leader>skf :source ~/.vim/keybinds.vim<cr>

" Quickly turn off search highlighting
nnoremap <space> :nohl<cr>

" Quickly reindent file
nnoremap <leader>i mzgg=G`z

" Quick switch buffer
nnoremap gb :ls<CR>:buf<Space>

" Copy text left of cursor and start new line
nnoremap <leader>o v^yo<C-r>"

" Copy current buffer to clipboard and exit vim

" Insert mode {{{1
" Jump back and fix most recent error
inoremap <C-s> <esc>[sz=

" Make getting into normal mode easier
inoremap jk <esc>

" Make c-return start a new line in insert mode
inoremap <C-Return> <esc>o

" Make c-backspace delete a word
inoremap <C-BS> <esc>bcw

" Visual mode {{{1
" Sort selected text
vnoremap s :sort<cr>

" Move highlighted text up and down in visual mode
vnoremap <Down> :m '>+1<CR>gv=gv
vnoremap <Up> :m '<-2<CR>gv=gv

" Change function of arrow keys {{{1
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

" Misc binds {{{1
nnoremap s <C-w>
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

" More text objects, creates operator bindings for all the listed chars below, allowing operations between them. {{{
for char in [ '_', '-', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '`' ]
    :silent! execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
    :silent! execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
    :silent! execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
    :silent! execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor
" }}}
