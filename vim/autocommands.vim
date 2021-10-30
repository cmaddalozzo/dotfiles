"--------------------------------------------------
" Autocmd
"
if has('autocmd')
    augroup completion
      autocmd BufEnter * lua require'completion'.on_attach()
    augroup END

    augroup vimrc
      autocmd!
        " Auto reload vim after your change it
      autocmd BufWritePost *.vim source $MYVIMRC
    augroup END

    augroup cursor_hold
      autocmd!
      autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
    augroup END

    augroup cursor_restore
      autocmd!
      " Restore cursor position :help last-position-jump
      autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal g'\"" | endif
    augroup END

    augroup show_sign_column
      autocmd!
      " Always show sign column
      autocmd BufRead,BufNewFile * setlocal signcolumn=yes
    augroup END

    augroup detect_filetypes
      autocmd!
      " Set filetypes
      autocmd BufRead,BufNewFile *.js set filetype=javascript
      autocmd BufRead,BufNewFile *.json set filetype=json
      autocmd BufRead,BufNewFile *.json.template set filetype=json

      " Eww
      autocmd BufRead,BufNewFile *.coffee set filetype=coffeescript syntax=coffee

      " use `set filetype` to override default filetype=xml for *.ts files
      autocmd BufNewFile,BufRead *.ts  set filetype=typescript
      " use `setfiletype` to not override any other plugins like ianks/vim-tsx
      autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact

      " Syntax definitions
      autocmd BufRead,BufNewFile *.css set filetype=css syntax=css3

      autocmd BufRead,BufNewFile *.less set filetype=less syntax=less

      autocmd BufRead,BufNewFile *.scss set filetype=sass syntax=sass
      autocmd BufRead,BufNewFile *.scss.liquid set filetype=sass syntax=sass

      autocmd BufRead,BufNewFile *.go set filetype=go syntax=go

      autocmd BufRead,BufNewFile *.md set filetype=markdown syntax=markdown

      autocmd BufRead,BufNewFile Dockerfile* set filetype=dockerfile

      autocmd BufRead,BufNewFile *.config set filetype=yaml syntax=yaml

      " Fold coffee files
      autocmd FileType coffee setlocal foldmethod=indent nofoldenable suffixesadd=.js,.json,.ts

      au BufRead,BufNewFile *.avdl setlocal filetype=avro-idl

      autocmd BufRead,BufNewFile *.html set filetype=html.jinja2

    augroup END

endif
