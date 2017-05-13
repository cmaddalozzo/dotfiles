function! StrTrim(txt)
  return substitute(a:txt, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
endfunction

function! NpmWhich(cmd)
  let l:npm_bin = system('npm bin')
  let l:local_cmd = StrTrim(l:npm_bin) . '/' . a:cmd
  return executable(l:local_cmd) ? l:local_cmd : StrTrim(system('which ' . a:cmd))
endfunction

function! Decaffeinate()
  let l:fname = expand('%:r')
  exec '!decaffeinate --keep-commonjs --prefer-const ' . @%
  exec 'e ' . l:fname . '.js'
endfunction
