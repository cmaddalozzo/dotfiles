" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1
set shiftwidth=4
let b:ale_linters = ['flake8']

setlocal textwidth=80
