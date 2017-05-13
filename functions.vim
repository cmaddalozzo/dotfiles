function! StrTrim(txt)
  return substitute(a:txt, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
endfunction

function! NpmWhich(cmd)
  let npm_bin = system('npm bin')
  let local_cmd = StrTrim(npm_bin) . '/' . a:cmd
  return executable(local_cmd) ? local_cmd : StrTrim(system('which ' . a:cmd))
endfunction

function! Decaffeinate()
  let fname = expand('%:r')
  exec "!decaffeinate --keep-commonjs --prefer-const " . @%
  exec 'e ' . fname . '.js'
endfunction
