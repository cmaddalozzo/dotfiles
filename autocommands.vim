"--------------------------------------------------
" Autocmd
"
if has('autocmd')

    augroup vimrc
      autocmd!
        " Auto reload vim after your change it
      autocmd BufWritePost *.vim source $MYVIMRC | AirlineRefresh
      autocmd BufWritePost .vimrc source $MYVIMRC | AirlineRefresh
    augroup END

    augroup cursor_restore
      autocmd!
      " Restore cursor position :help last-position-jump
      autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal g'\"" | endif
    augroup END

    augroup detect_filetypes
      autocmd!
      " Set filetypes
      autocmd BufRead,BufNewFile *.js set filetype=javascript
      autocmd BufRead,BufNewFile *.json set filetype=json

      " Eww
      autocmd BufRead,BufNewFile *.coffee set filetype=coffeescript syntax=coffee

      " use `set filetype` to override default filetype=xml for *.ts files
      autocmd BufNewFile,BufRead *.ts  set filetype=typescript
      " use `setfiletype` to not override any other plugins like ianks/vim-tsx
      autocmd BufNewFile,BufRead *.tsx setfiletype typescript

      " Syntax definitions
      autocmd BufRead,BufNewFile *.css set filetype=css syntax=css3

      autocmd BufRead,BufNewFile *.less set filetype=less syntax=less

      autocmd BufRead,BufNewFile *.scss set filetype=sass syntax=sass
      autocmd BufRead,BufNewFile *.scss.liquid set filetype=sass syntax=sass

      autocmd BufRead,BufNewFile *.go set filetype=go syntax=go

      " Format JSON with jq
      autocmd FileType json set equalprg=jq\ .

      " Fold coffee files
      autocmd FileType coffee setlocal foldmethod=indent nofoldenable suffixesadd=.js,.json,.ts

      " Typescript
      autocmd FileType typescript call s:typescript_local_config()

      " Javascript
      autocmd FileType javascript call s:javascript_local_config()
    augroup END

    augroup neomake_config
      autocmd!
      " Neomake on save
      autocmd! BufReadPost,BufWritePost * Neomake
      autocmd ColorScheme * call s:neomake_config()
    augroup END

    augroup unite_config
      autocmd!
      autocmd FileType unite call s:unite_config()
    augroup END
endif

function! s:unite_config()
  imap <buffer> jj      <Plug>(unite_quick_match_default_action)
  imap <buffer> kk      <Plug>(unite_quick_match_default_action)
  imap <buffer> jk      <Plug>(unite_quick_match_choose_action)
  nmap <buffer> Q <plug>(unite_exit)
  nmap <buffer> <esc> <plug>(unite_exit)
  imap <expr><silent><buffer> <C-s> unite#do_action('split')
  imap <expr><silent><buffer> <C-v> unite#do_action('vsplit')
endfunction

function! s:typescript_local_config()
  nmap <buffer> <LocalLeader>tr <Plug>(TsuquyomiRenameSymbol)
  nmap <buffer> <LocalLeader>tR <Plug>(TsuquyomiRenameSymbolC)
  nmap <buffer> <LocalLeader>ti <Plug>(TsuquyomiImport)
  nmap <buffer> <LocalLeader>tg <Plug>(TsuquyomiDefinition)
  nmap <buffer> <LocalLeader>td <Plug>(TsuquyomiDefinition)
  setlocal suffixesadd=.js,.json,.coffee
  " let b:neomake_typescript_tsc_exe = NpmWhich('tsc')
  " let b:neomake_typescript_tslint_exe = NpmWhich('tslint')
endfunction

function! s:javascript_local_config()
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
  let b:neomake_javascript_eslint_exe = NpmWhich('eslint')
  setlocal suffixesadd=.js,.json,.coffee
endfunction

function! s:neomake_config()
  hi NeomakeError ctermfg=red
endfunction

