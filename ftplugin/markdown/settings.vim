:setlocal spell modeline wrap
set complete=.,w,b,u,i,k

" Text formatting
:vnoremap <buffer> <leader>i <esc>`>a*<esc>`<i*<esc>
:vnoremap <buffer> <leader>b <esc>`>a**<esc>`<i**<esc>

" Maps
nnoremap <buffer> k gk
nnoremap <buffer> j gj
