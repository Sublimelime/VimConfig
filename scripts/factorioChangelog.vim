" This is a simple script that converts factorio changelogs into wiki-friendly
" format. Simply source it on a buffer to convert it.

" Remove divider lines
:%s:-----------\+::

" Change version headers
:%s/\vVersion: (\d.\d\d.\d\d?)/== \1 ==/

" Change minor headers
:%s/\v^\s+(Balancing|(Minor|Major|Small) [fF]eatures|Changes|Sound|Circuit [nN]etwork|Modding|Scripting|Bug[fF]ixes):/=== \1 ===/
:%s/\v^\s+(Graphics|Optimi[zs]ations|Configuration|Command line interface):/=== \1 ===/

" Fix bullet points
:%s/\v^\s+-/*/

" Fix indents
:%s/\v\C\n\s+([a-z])/ \1/
:%s/\v\C^\s+([A-Z])/** \1/

" Fix forum links
:%s#\v\((https?:\/\/forums.factorio.com\/\d+)\)#([\1 more])#
