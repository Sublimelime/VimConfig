" Create a command to fetch docs on a lisp symbol.
command! -buffer -nargs=1 LispDoc :!gcl -batch -eval "(describe <args>)" <bar> more

" Set makeprg so :make runs the current file
setlocal makeprg=gcl\ -batch\ -load\ %
