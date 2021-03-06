" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1
nmap <buffer><silent> <LocalLeader>r :YcmCompleter GoToReferences<return>
nmap <buffer><silent> <LocalLeader>d :YcmCompleter GetDoc<return>
nmap <buffer><silent> <LocalLeader>t :YcmCompleter GetType<return>
nmap <buffer> <LocalLeader>n :YcmCompleter RefactorRename 
nmap <buffer><silent> <LocalLeader>i :execute "e " . expand('%:p:h') . "/index.ts"<return>
setlocal suffixesadd=.js,.json
setlocal foldmethod=syntax
if !empty(glob(".eslint*"))
  let b:ale_linters = ['eslint', 'tsserver']
  let b:ale_fixers = ['prettier', 'eslint']
else
  let b:ale_linters = ['tsserver', 'tslint']
  let b:ale_fixers = ['prettier', 'tslint']
endif
