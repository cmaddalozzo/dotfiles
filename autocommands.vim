"--------------------------------------------------
" Autocmd
"
if has("autocmd")
    " Define group of commands,
    " Commands defined in .vimrc don't bind twice if .vimrc is re-sourced
    augroup vimrc
    " Delete any previosly defined autocommands
    au!
        " Neomake on save
        autocmd! BufReadPost,BufWritePost * Neomake

        " Auto reload vim after your change it
        autocmd BufWritePost *.vim source $MYVIMRC | AirlineRefresh
        autocmd BufWritePost .vimrc source $MYVIMRC | AirlineRefresh

        " Restore cursor position :help last-position-jump
        autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
          \| exe "normal g'\"" | endif

        " Set filetypes
        autocmd BufRead,BufNewFile *.js set ft=javascript
        autocmd BufRead,BufNewFile *.json set ft=json

        " Eww
        autocmd BufRead,BufNewFile *.coffee set ft=coffeescript syntax=coffee

        " use `set filetype` to override default filetype=xml for *.ts files
        autocmd BufNewFile,BufRead *.ts  set filetype=typescript
        " use `setfiletype` to not override any other plugins like ianks/vim-tsx
        autocmd BufNewFile,BufRead *.tsx setfiletype typescript

        " Syntax definitions
        autocmd BufRead,BufNewFile *.css set ft=css syntax=css3

        autocmd BufRead,BufNewFile *.less set ft=less syntax=less

        autocmd BufRead,BufNewFile *.scss set ft=sass syntax=sass
        autocmd BufRead,BufNewFile *.scss.liquid set ft=sass syntax=sass

        autocmd BufRead,BufNewFile *.go set ft=go syntax=go



        " Disable vertical line at max string length in NERDTree
        autocmd FileType * setlocal colorcolumn=+1
        " autocmd FileType nerdtree setlocal colorcolumn=""

        " Format JSON with jq
        autocmd FileType json set equalprg=jq\ .

        " Fold coffee files
        autocmd FileType coffee setl foldmethod=indent nofoldenable

        " Typescript
        autocmd FileType typescript call s:typescript_local_config()

        " Javascript
        autocmd FileType javascript let b:neomake_javascript_eslint_exe = NpmWhich('eslint')

    " Group end
    augroup END
    augroup my_neomake_signs
      au!
      autocmd ColorScheme *
            \ hi NeomakeError ctermfg=red
    augroup END
    augroup unite_settings
      au!
      autocmd FileType unite call s:unite_my_settings()
    augroup END
endif

function! s:unite_my_settings()
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
  " let b:neomake_typescript_tsc_exe = NpmWhich('tsc')
  " let b:neomake_typescript_tslint_exe = NpmWhich('tslint')
endfunction
