" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

nmap <buffer> <LocalLeader>tD  :TernDoc<return>
nmap <buffer> <LocalLeader>tb  :TernDocBrowse<return>
nmap <buffer> <LocalLeader>tt  :TernType<return>
nmap <buffer> <LocalLeader>td  :TernDef<return>
nmap <buffer> <LocalLeader>tg  :TernDef<return>
nmap <buffer> <LocalLeader>tpd :TernDefPreview<return>
nmap <buffer> <LocalLeader>tsd :TernDefSplit<return>
nmap <buffer> <LocalLeader>ttd :TernDefTab<return>
nmap <buffer> <LocalLeader>tr  :TernRefs<return>
nmap <buffer> <LocalLeader>tR  :TernRename<return>
nmap <buffer> <Leader>t :te npm run test %<return>
"let g:neomake_javascript_enabled_makers = ['eslint']
let l:eslint_exe = NpmWhich('eslint')
"let b:neomake_javascript_eslint_exe = l:eslint_exe
setlocal formatprg=prettier\ --stdin
setlocal suffixesadd=.js,.json,.coffee
