" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1
nmap <buffer> <LocalLeader>r :YcmCompleter GoToReferences<return>
nmap <buffer> <LocalLeader>tr <Plug>(TsuquyomiRenameSymbol)
nmap <buffer> <LocalLeader>tR <Plug>(TsuquyomiRenameSymbolC)
nmap <buffer> <LocalLeader>ti <Plug>(TsuquyomiImport)
nmap <buffer> <LocalLeader>td <Plug>(TsuquyomiTypeDefinition)
setlocal suffixesadd=.js,.json
let b:ale_linters = ['tslint', 'tsserver']
let b:ale_fixers = ['prettier', 'tslint']
