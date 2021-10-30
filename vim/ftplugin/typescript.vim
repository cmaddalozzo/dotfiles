" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

lua require'lspconfig'.tsserver.setup{}

"autocmd BufWritePre *.ts silent! Neoformat prettier

nmap <buffer><silent> <LocalLeader>i :execute "e " . expand('%:p:h') . "/index.ts"<return>
setlocal suffixesadd=.js,.json
setlocal foldmethod=syntax
