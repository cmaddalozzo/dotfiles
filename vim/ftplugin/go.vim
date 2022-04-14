augroup fmtgo
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat gofmt
augroup END
