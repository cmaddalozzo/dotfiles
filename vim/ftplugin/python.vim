" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

augroup fmtpython
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat black
augroup END

let b:did_ftplugin = 1
set shiftwidth=4
setlocal textwidth=80
