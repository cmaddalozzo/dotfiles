" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" Format JSON with jq
autocmd FileType json set equalprg=jq\ .
