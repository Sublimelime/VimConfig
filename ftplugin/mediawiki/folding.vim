"Mediawiki folding plugin
"Allows folding based on ==sections== and <!-- Comments. -->

let b:undo_ftplugin = 'setlocal foldmethod< foldexpr<'

setlocal foldexpr=getline(v:lnum)=~'^\\(=\\+\\)[^=]\\+\\1\\(\\s*<!--.*-->\\)\\=\\s*$'?\">\".(len(matchstr(getline(v:lnum),'^=\\+'))-1):\"=\"
setlocal foldmethod=expr

