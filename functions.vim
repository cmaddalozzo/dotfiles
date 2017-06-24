function! StrTrim(txt)
  return substitute(a:txt, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
endfunction

function! NpmWhich(cmd)
  let l:npm_bin = system('npm bin')
  let l:local_cmd = StrTrim(l:npm_bin) . '/' . a:cmd
  return executable(l:local_cmd) ? l:local_cmd : StrTrim(system('which ' . a:cmd))
endfunction

function! NpmExecSet(cmd, variable)
  let l:callbacks = {
  \ 'on_stdout': function('s:NpmExecSetHandler'),
  \ 'on_stderr': function('s:NpmExecSetHandler'),
  \ 'on_exit': function('s:NpmExecSetHandler')
  \ }
  let job = jobstart(['npm', 'bin'], extend({'cmd': a:cmd, 'variable': a:variable}, l:callbacks))
endfunction

function! s:NpmExecSetHandler(job_id, data, event) dict
  if a:event == 'stdout'
    let self.result = StrTrim(join(a:data))
  elseif a:event == 'stderr'
    " Lol don't care
  else
    let l:exec = self.result . '/'. self.cmd
    if !executable(l:exec)
      let l:exec = StrTrim(system('which '. self.cmd))
    endif
    let g:{self.variable} = l:exec
  endif
endfunction

function! Decaffeinate()
  let l:fname = expand('%:r')
  exec '!decaffeinate --keep-commonjs --prefer-const ' . @%
  exec 'e ' . l:fname . '.js'
endfunction
