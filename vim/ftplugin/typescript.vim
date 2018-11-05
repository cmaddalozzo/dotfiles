" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1
nmap <buffer><silent> <LocalLeader>r :YcmCompleter GoToReferences<return>
nmap <buffer><silent> <LocalLeader>d :YcmCompleter GetDoc<return>
nmap <buffer> <LocalLeader>n :YcmCompleter RefactorRename 
setlocal suffixesadd=.js,.json
setlocal foldmethod=syntax
let b:ale_linters = ['tslint', 'tsserver']
let b:ale_fixers = ['prettier', 'tslint']
