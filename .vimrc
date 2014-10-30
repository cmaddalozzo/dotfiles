"" Change that leader.
let mapleader=","

syntax on
syntax enable

" Show line numbers
set number

" Set tabsize
set tabstop=2
set shiftwidth=2
" <Tab>s are actually spaces
set expandtab
" Auto/smart-indenting
set autoindent
set smartindent

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Splits
set splitright
set splitbelow

"" Escape gets rid of highlighting
nnoremap <silent> <esc> :noh<return><esc>

" Don't highlight line with cursor
set nocursorline

" Visual bell
set vb

"Nice typeface
set guifont=Source\ Code\ Pro:h11

" Don't let vim handle backups
set nobackup
set noswapfile

" Allow switching buffers without saving.
set hidden

" Navigate between splits with Control+<Direction>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Buffer write commands
nmap <Leader>w :w<CR>
nmap <Leader>x :x<CR>

"" Q plays back q macro.
nnoremap Q @q

"" Reselect on Option-v
nnoremap √ gv

"" Close buffer.
nnoremap <Leader>d :bd<CR>

"" Easy switching to last used buffer.
nnoremap <Leader>l :e#<CR>

"" Easy open this.
nnoremap <Leader>vrc :tabe ~/.vimrc-curtis<CR>

" w!! sudo opens file and saves it
cmap w!! w !sudo tee % >/dev/null



" Folding and unfolding
map ,f :set foldmethod=indent<cr>zM<cr>
map ,F :set foldmethod=manual<cr>zR<cr>

"-------------------------
" matchindent.vim
" Try and set the indent style to whatever is in the file being edited.
"
" NeoBundle 'conormcd/matchindent.vim'

" Change dir on open
" cd ~/Sites/stockpools.dev

"-------------------------
" Molokai
"
NeoBundle 'tomasr/molokai'
" colorscheme molokai

"-------------------------
" Greplace
"
NeoBundle 'yegappan/greplace'

"-------------------------
" smartpairs.vim
"
NeoBundle 'gorkunov/smartpairs.vim'

"-------------------------
" Solarized
"
" NeoBundle 'altercation/vim-colors-solarized'
" set background=light
" colorscheme solarized

" Gotham theme
NeoBundle 'whatyouhide/vim-gotham'
colorscheme gotham

"-------------------------
" sudo.vim
"
NeoBundle 'vim-scripts/sudo.vim'

"-------------------------
" Buffergator
"
" Maps <Leader>b to buffer pane
NeoBundle 'jeetsukumaran/vim-buffergator'

"" Make the buffergator window a little bigger
:let g:buffergator_vsplit_size=55

"" Don't show absolute paths for buffers
let g:buffergator_show_full_directory_path = 0

"" Sort by most recently used buffer by default.
let g:buffergator_sort_regime = "mru"

"-------------------------
" UltiSnips
"
NeoBundle 'SirVer/ultisnips'
" Set ultisnips triggers
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
let g:snips_author = 'Curtis Maddalozzo'

"-------------------------
" PHP documenting
"
NeoBundle 'tobyS/pdv'
NeoBundle 'tobyS/vmustache'
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
nnoremap <C-p> :call pdv#DocumentWithSnip()<CR>


inoremap <expr><TAB> CleverTab()
"-------------------------
" Tagbar
"
NeoBundle 'majutsushi/tagbar'
nmap <Leader>/ :TagbarToggle<CR>

"" Nicer Tagbar tags for PHP
NeoBundle 'vim-php/tagbar-phpctags.vim'
let g:tagbar_phpctags_bin= $HOME ."/.vim/bundle/tagbar-phpctags.vim/bin/phpctags"
"let g:tagbar_phpctags_memory_limit = '512M'

"-------------------------
" Greplace
"
NeoBundle 'vim-scripts/Greplace.vim'

"-------------------------
" Plugin to toggle, display and navigate marks
"
NeoBundle 'kshenoy/vim-signature'
nmap <Leader>m :SignatureToggle<CR>

" Less syntax highlighting
NeoBundle 'groenewege/vim-less'
" Better syntax highlighting for CSS3
NeoBundle 'skammer/vim-css-color'
" Vim Twig
NeoBundle 'evidens/vim-twig'

"" Always use regex "magic" mode
""NeoBundle 'coot/EnchantedVim'

" Show indent lines
NeoBundle 'nathanaelkane/vim-indent-guides'

" Mustache plugin
NeoBundle 'mustache/vim-mustache-handlebars'


"-------------------------
" NERDCommenter
"
NeoBundle 'scrooloose/nerdcommenter'

"-------------------------
" Supertab
"
"NeoBundle 'ervandew/supertab'

"-------------------------
" abolish.vim
"
NeoBundle 'tpope/vim-abolish'

"-------------------------
" Vim sneak
"
NeoBundle 'justinmk/vim-sneak'

"-------------------------
" Dash plugin
"
NeoBundle 'rizzatti/funcoo.vim'
NeoBundle 'rizzatti/dash.vim'
" <Leader>a searches Dash for word under cursor
nmap <silent> <Leader>a <Plug>DashSearch

"-------------------------
" Matchit
"
NeoBundle 'tmhedberg/matchit'

"-------------------------
" NERDTree
"
nnoremap <C-t> :NERDTreeToggle<CR>

"-------------------------
" NERDTree
"
"" Use Ag instead of Ack
let g:ackprg = 'ag --nogroup --nocolor --column'
"" Map Ack.vim to Command-Shift-F
nmap <D-F> :Ack<space>

"-------------------------
" Syntastic
"
let g:syntastic_phpcs_conf=" --standard=Drupal --extensions=php,module,inc,install,test,profile,theme"
" let g:syntastic_javascript_checkers = ['jshint']
" let g:syntastic_javascript_jshint_conf="~/.jshintrc"
" let g:syntastic_javascript_jshint_args = '--config /Users/cmadd/.jshintrc'

let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✠'
let g:syntastic_warning_symbol = '∆'
let g:syntastic_style_warning_symbol = '≈'

let g:syntastic_mode_map = { 'mode': 'active',
                               \ 'active_filetypes': ['php'],
                               \ 'passive_filetypes': ['less'] }

" Golang syntax highlighting
filetype off
filetype plugin indent off
set runtimepath+=/usr/local/go/misc/vim
filetype plugin indent on
syntax on

" Syntax definitions
au BufRead,BufNewFile *.css set ft=css syntax=css3
au BufRead,BufNewFile *.less set ft=less syntax=less
au BufRead,BufNewFile *.scss set ft=sass syntax=sass
au BufRead,BufNewFile *.go set ft=go syntax=go
au BufNewFile,BufRead *.ini, *.info, */.hgrc,*/.hg/hgrc setf ini

" Omnicomplete definitions
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete


"-------------------------
" JS Beautify
"
function! BeautifyAndResetCursor ()
    let cursor_pos = getpos('.')
    %!js-beautify --quite --indent-size 2 --preserve-newlines  --brace-style=end-expand --file -
    call setpos('.', cursor_pos)
endfunction

"augroup Beautify
"    autocmd!
"    autocmd InsertLeave *.js  :call BeautifyAndResetCursor()
"augroup END


"-------------------------
" Delimitmate

" Delimitmate place cursor correctly n multiline objects e.g.
" if you press enter in {} cursor still be
" in the middle line instead of the last
let delimitMate_expand_cr = 1

" Delimitmate place cursor correctly in singleline pairs e.g.
" if x - cursor if you press space in {x} result will be { x } instead of { x}
let delimitMate_expand_space = 1

"-------------------------
" vim-airline

" Colorscheme for airline
let g:airline_theme='base16'

" unicode symbols
let g:airline_symbols = {}
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" Use MacVim's tabs
let g:airline#extensions#tabline#enabled = 0

" Don't display encoding
let g:airline_section_y = ''

" Don't display filetype
let g:airline_section_x = ''

" Don't show whitespace warning
let g:airline_section_warning = 'syntastic'

"-------------------------
" Unite

" Set unite window height
let g:unite_winheight = 10

" Start unite in insert mode by default
let g:unite_enable_start_insert = 1

" Display unite on the bottom (or bottom right) part of the screen
let g:unite_split_rule = 'botright'

" Set short limit for max most recent files count.
" It less unrelative recent files this way
let g:unite_source_file_mru_limit = 100

" Enable history for yanks
let g:unite_source_history_yank_enable = 1

" Make samll limit for yank history,
let g:unite_source_history_yank_limit = 40

" Grep options Default for unite + supress error messages
let g:unite_source_grep_default_opts = '-iRHns'

let g:unite_source_rec_max_cache_files = 99999

" If ag exists use it instead of grep
if executable('ag')
    " Use ack-grep
    let g:unite_source_grep_command = 'ag'
    " Set up ack options
    let g:unite_source_grep_default_opts = '--nogroup --nocolor -S -C4'
    let g:unite_source_grep_recursive_opt = ''
    " Use ack for fuzzy file search
    let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
endif

nnoremap [unite] <Nop>
nmap <space> [unite]
nnoremap <silent> [unite]<space> :<C-u>Unite -buffer-name=files file_rec/async<CR>
" nnoremap <silent> [unite]<space> :<C-u>Unite -toggle -buffer-name=mixed file_rec/async buffer file_mru bookmark<cr><c-u>
nnoremap <silent> [unite]f :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec/async<cr><c-u>
nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<cr>
nnoremap <silent> [unite]l :<C-u>Unite -auto-resize -buffer-name=line line<cr>
nnoremap <silent> [unite]b :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
nnoremap <silent> [unite]/ :<C-u>Unite -no-quit -buffer-name=search grep:.<cr>
nnoremap <silent> [unite]m :<C-u>Unite -auto-resize -buffer-name=mappings mapping<cr>
nnoremap <silent> [unite]s :<C-u>Unite -quick-match buffer<cr>

autocmd FileType unite call s:unite_my_settings()

function! s:unite_my_settings()
  imap <buffer> jj      <Plug>(unite_insert_leave)
  imap <buffer> kk      <Plug>(unite_insert_leave)
  nmap <buffer> Q <plug>(unite_exit)
  nmap <buffer> <esc> <plug>(unite_exit)
  imap <expr><silent><buffer> <C-s> unite#do_action('split')
  imap <expr><silent><buffer> <C-v> unite#do_action('vsplit')
endfunction

"-------------------------
" Fugitive

" Blame on current line
nmap <silent> <leader>gb :.Gblame<cr>
" Blame on all selected lines in visual mode
vmap <silent> <leader>gb :Gblame<cr>
" Git status
nmap <silent> <leader>gst :Gstatus<cr>
" like git add
nmap <silent> <leader>gw :Gwrite<cr>
" git diff
nmap <silent> <leader>gd :Gdiff<cr>
" git commit
nmap <silent> <leader>gc :Gcommit<cr>
" git commit all
nmap <silent> <leader>gca :Gcommit -a<cr>
" git fixup previous commit
nmap <silent> <leader>gcf :Gcommit -a --amend<cr>

highlight ColorColumn guibg=grey7
"" Somebody is turning on gdefault. We don't want that.
set nogdefault

noremap <Leader>sp :cd ~/Sites/stockpools.dev<return>
