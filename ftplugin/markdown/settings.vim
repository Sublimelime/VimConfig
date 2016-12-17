:echom "Editing a markdown file:"
:echom "[Vis] Press <leader>i to italicize some text."
:echom "[Vis] Press <leader>b to bolden some text."
:setlocal spell modeline conceallevel=1

" Text formatting
:vnoremap <buffer> <leader>i <esc>`>a*<esc>`<i*<esc>
:vnoremap <buffer> <leader>b <esc>`>a**<esc>`<i**<esc>

" Maps
nnoremap <buffer> k gk
nnoremap <buffer> j gj

let b:undo_ftplugin = 'set nomodeline conceallevel<'
