" Change that leader.
let mapleader=","

set shell=/bin/bash

"######################################
"#   NeoBundle init
"######################################

" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

" Turn off filetype plugins before bundles init
filetype off

" Call NeoBundle
if has('vim_starting')
    set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand($HOME.'/.vim/bundle/'))

" Determine make or gmake will be used for making additional deps for Bundles
let g:make = 'gmake'
if system('uname -o') =~ '^GNU/'
    let g:make = 'make'
endif

"######################################
"#   Bundles
"######################################

"-------------------------
" NeoBundle
"
" Let NeoNeoBundle manage NeoNeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Install vimrpoc. is uses by unite and neocomplcache
" for async searches and calls
NeoBundle 'Shougo/vimproc', {
\ 'build' : {
\     'mac' : 'make -f make_mac.mak',
\     'unix': g:make
\    },
\ }
" /NeoBundle

"-------------------------
" Unite
"
" plugin for fuzzy file search, most recent files list
" and much more
NeoBundle 'Shougo/unite.vim'

" Set unite window height
let g:unite_winheight = 15

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
    " Use ag (the silver searcher)
    " https://github.com/ggreer/the_silver_searcher
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts =
    \ '-i --vimgrep --hidden --ignore ' .
    \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    let g:unite_source_grep_recursive_opt = ''
    " Use ack for fuzzy file search
    let g:unite_source_rec_async_command = ['ag', '--follow', '--nocolor', '--nogroup', '-g', '']
endif

nnoremap [unite] <Nop>
nmap <space> [unite]
nnoremap <silent> [unite]<space> :<C-u>Unite -buffer-name=files file_rec/async<CR>
" nnoremap <silent> [unite]<space> :<C-u>Unite -toggle -buffer-name=mixed file_rec/async buffer file_mru bookmark<cr><c-u>
nnoremap <silent> [unite]f :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec/async<cr><c-u>
nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<cr>
nnoremap <silent> [unite]l :<C-u>Unite -auto-resize -buffer-name=line line<cr>
nnoremap <silent> [unite]b :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
nnoremap <silent> [unite]/ :<C-u>Unite -buffer-name=search grep:.<cr>
nnoremap <silent> [unite]m :<C-u>Unite -auto-resize -buffer-name=mappings mapping<cr>
nnoremap <silent> [unite]s :<C-u>Unite -quick-match buffer<cr>

" Try to lose reliance on buffergator by remapping to unite buffers
nmap <Leader>b [unite]b

autocmd FileType unite call s:unite_my_settings()

function! s:unite_my_settings()
  imap <buffer> jj      <Plug>(unite_quick_match_default_action)
  imap <buffer> kk      <Plug>(unite_quick_match_default_action)
  imap <buffer> jk      <Plug>(unite_quick_match_choose_action)
  nmap <buffer> Q <plug>(unite_exit)
  nmap <buffer> <esc> <plug>(unite_exit)
  imap <expr><silent><buffer> <C-s> unite#do_action('split')
  imap <expr><silent><buffer> <C-v> unite#do_action('vsplit')
endfunction


"call unite#define_filter(s:filters)
"unlet s:filters

" /Unite
"-------------------------

"-------------------------
" neocomplete
"
" Keyword completion.
"
" 
"NeoBundle 'Shougo/neocomplete.vim'
"
"" Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
"" Use neocomplete.
"let g:neocomplete#enable_at_startup = 1
"" Use smartcase.
"let g:neocomplete#enable_smart_case = 1
"" Set minimum syntax keyword length.
"let g:neocomplete#sources#syntax#min_keyword_length = 3
"let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
"
"" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1
"
"" Define dictionary.
"let g:neocomplete#sources#dictionary#dictionaries = {
"    \ 'default' : '',
"    \ 'vimshell' : $HOME.'/.vimshell_hist',
"    \ 'scheme' : $HOME.'/.gosh_completions'
"        \ }
"
"" Define keyword.
"if !exists('g:neocomplete#keyword_patterns')
"    let g:neocomplete#keyword_patterns = {}
"endif
"let g:neocomplete#keyword_patterns['default'] = '\h\w*'
"
"" Plugin key-mappings.
"inoremap <expr><C-g>     neocomplete#undo_completion()
"inoremap <expr><C-l>     neocomplete#complete_common_string()
"
"" Recommended key-mappings.
"" <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function()
"  "return neocomplete#close_popup() . "\<CR>"
"  " For no inserting <CR> key.
"  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
"endfunction
"" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplete#close_popup()
"inoremap <expr><C-e>  neocomplete#cancel_popup()
"
"" Disable auto popup
"" let g:neocomplcache_disable_auto_complete = 1
"
"" Smart tab Behavior
""function! CleverTab()
""    " If autocomplete window visible then select next item in there
""    if pumvisible()
""        return "\<C-n>"
""    endif
""    " If it's begining of the string then return just tab pressed
""    let substr = strpart(getline('.'), 0, col('.') - 1)
""    let substr = matchstr(substr, '[^ \t]*$')
""    if strlen(substr) == 0
""        " nothing to match on empty string
""        return "\<Tab>"
""    else
""        " If not begining of the string, and autocomplete popup is not visible
""        " Open this popup
""        return "\<C-x>\<C-u>"
""    endif
""endfunction
"" inoremap <expr><TAB> CleverTab()
"
"" Undo autocomplete
"inoremap <expr><C-e> neocomplcache#undo_completion()
"
"
"" disable preview in code complete
"set completeopt-=preview
"
" /neocomplete
"-------------------------

" Most recent files source for unite
"
NeoBundle 'Shougo/neomru.vim'

"-------------------------
" NerdTree
"
" Great file system explorer, it appears when you open dir in vim
" Allow modification of dir, and may other things
" Must have
NeoBundle 'scrooloose/nerdtree'
" Ctrl-t opens NerdTree
nnoremap <C-t> :NERDTreeToggle<CR>

" Tell NERDTree to display hidden files on startup
let NERDTreeShowHidden=1

" Disable bookmarks label, and hint about '?'
let NERDTreeMinimalUI=1

" Display current file in the NERDTree on the left
nmap <silent> <leader>f :NERDTreeFind<CR>

" /NerdTree
"-------------------------

NeoBundle 'Xuyuanp/nerdtree-git-plugin'

"-------------------------
" Syntastic
"
" Add code static check on write
" need to be properly configured.
" I just enable it, with default config,
" many false positive but still usefull
NeoBundle 'scrooloose/syntastic'
" Install jshint and csslint for syntastic
let g:syntastic_jshint_exec = $HOME . '/.vim/node_modules/.bin/jshint'
let g:syntastic_javascript_jshint_exec = $HOME . '/.vim/node_modules/.bin/jshint'
let g:syntastic_javascript_checkers = ['eslint']
if !executable(expand(g:syntastic_jshint_exec))
    silent ! echo 'Installing jshint' && npm --prefix /.vim/ install jshint
endif
" Path to csslint if it not installed globally, then use local installation
if !executable("csslint")
    let g:syntastic_css_csslint_exec='~/.vim/node_modules/.bin/csslint'
    if !executable(expand(g:syntastic_css_csslint_exec))
        silent ! echo 'Installing csslint' && npm --prefix ~/.vim/ install csslint
    endif
endif

let g:syntastic_phpcs_conf=" --standard=Drupal --extensions=php,module,inc,install,test,profile,theme"
" let g:syntastic_javascript_checkers = ['jshint']
" let g:syntastic_javascript_jshint_conf="~/.jshintrc"
" let g:syntastic_javascript_jshint_args = '--config ' . $HOME . '/.jshintrc'

let g:syntastic_html_tidy_ignore_errors = [ 
      \ '<template> is not recognized!' ,
      \ 'discarding unexpected <template>' ,
      \ 'discarding unexpected </template>' ,
      \ 'inserting implicit <ul>' 
\]

let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✠'
let g:syntastic_warning_symbol = '∆'
let g:syntastic_style_warning_symbol = '≈'

let g:syntastic_mode_map = { 'mode': 'active',
                               \ 'active_filetypes': ['php'],
                               \ 'passive_filetypes': ['less'] }

" Enable autochecks
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1

" For correct works of next/previous error navigation
let g:syntastic_always_populate_loc_list = 1

" /Syntastic
"-------------------------

""-------------------------
"" Airline
""
"" Nice statusline/ruler for vim
"" 
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'

" Colorscheme for airline
let g:airline_theme='base16'

" unicode symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = '»'
" Set custom left separator
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
" Set custom right separator
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

" /Airline
"-------------------------

"-------------------------
" vim-startify
"
" A fancy start screen for Vim.
" NerdTree
"
NeoBundle 'mhinz/vim-startify'
" Automatically persist sessions.
let g:startify_session_persistence = 1
"
" /vim-startify
"-------------------------

"
" Improved PHP omnicompletion
"
NeoBundle 'shawncplus/phpcomplete.vim'

"-------------------------
" smartpairs.vim
"
" 
NeoBundle 'gorkunov/smartpairs.vim'

"-------------------------
" Matchit
"
NeoBundle 'tmhedberg/matchit'

"-------------------------
" delimitMate
"
" Allow autoclose paired characters like [,] or (,),
" and add smart cursor positioning inside it,
"
NeoBundle 'Raimondi/delimitMate'

"-------------------------
" surround.vim
"
" Add usefull hotkey for operation with surroundings
" cs{what}{towhat} - inside '' or [] or something like this allow
" change surroundings symbols to another
" and ds{what} - remove them
"
NeoBundle 'tpope/vim-surround'

"-------------------------
" vim-gitgutter
"
" A Vim plugin which shows a git diff in the 'gutter' (sign column).
"
NeoBundle 'airblade/vim-gitgutter'

nmap <silent> <leader>gg :GitGutterToggle<cr>

"-------------------------
" vim-signature
" smartpairs.vim
"
" Plugin to toggle, display and navigate marks
NeoBundle 'kshenoy/vim-signature'
nmap <Leader>m :SignatureToggle<CR>

"-------------------------
" Twig
" 
NeoBundle 'evidens/vim-twig'

"-------------------------
" vim-javascript v0.10.0
"
" JavaScript bundle for vim, this bundle provides syntax and indent plugins.
" 
NeoBundle 'pangloss/vim-javascript'

"-------------------------
" vim-jsx
"
" Syntax highlighting and indenting for JSX.
"
NeoBundle 'mxw/vim-jsx'
let g:jsx_ext_required = 0

"-------------------------
" Colour Schemes
"

"-------------------------
" Solarized
"
"NeoBundle 'altercation/vim-colors-solarized'

"-------------------------
" Gotham
"
NeoBundle 'whatyouhide/vim-gotham'

"-------------------------
" Molokai
"
" NeoBundle 'tomasr/molokai'

"-------------------------
" Bad Wolf
"
" NeoBundle 'sjl/badwolf'


"-------------------------
" Paper Color (sic)
"
NeoBundle 'NLKNguyen/papercolor-theme'

" /Colour Schemes
"-------------------------

" /Bundles

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
"

call neobundle#end()

" Enable Indent in plugins
filetype plugin indent on

NeoBundleCheck

"######################################
"   Vim settings
"######################################

set background=light
"set t_Co=256
"colorscheme Gotham
colorscheme papercolor
let g:airline_theme='papercolor'

"colorscheme solarized
" colorscheme molokai
" colorscheme gotham
" colorscheme badwolf

" Auto reload changed files
set autoread

" Indicates fast terminal connection
set ttyfast

" Set character encoding to use in vim
set encoding=utf-8

" Let vim know what encoding we use in our terminal
set termencoding=utf-8

" Enable syntax highlighting
syntax on

" Which EOl used. For us it's unix
" Not works with modifiable=no
if &modifiable
    set fileformat=unix
endif

" Use 256 colors in vim
" vim-airline not work without it
set t_Co=256

" Enable Tcl interface. Not shure what is exactly mean.
" set infercase

" Interprete all files like binary and disable many features.
" set binary

"--------------------------------------------------
" Display options

" Hide showmode
" Showmode is useless with airline
set noshowmode

" Show file name in window title
set title

" Mute error bell
set novisualbell

" Remove all useless messages like intro screen and use abbreviation like RO
" instead readonly and + instead modified
set shortmess=atI

" Enable display whitespace characters
set list

" Setting up how to display whitespace characters
set listchars=tab:⇥\ ,trail:·,extends:⋯,precedes:⋯,nbsp:~

" Numbers of rows to keep to the left and to the right off the screen
set scrolloff=10

" Numbers of columns to keep to the left and to the right off the screen
set sidescrolloff=10

" Vim will move to the previous/next line after reaching first/last char in
" the line with this commnad (you can add 'h' or 'l' here as well)
" <,> stand for arrows in command mode and [,] arrows in visual mode
set whichwrap=b,s,<,>,[,],

" Display command which you typing and other command related stuff
set showcmd

" Indicate that last window have a statusline too
set laststatus=2

" Add a line / column display in the bottom right-hand section of the screen.
" Not needed with airline plugin
"set ruler

" Setting up right-hand section(ruller) format
" Not needed with airline plugin
"set rulerformat=%30(%=\:%y%m%r%w\ %l,%c%V\ %P%)

" The cursor should stay where you leave it, instead of moving to the first non
" blank of the line
set nostartofline

" Disable wrapping long string
set nowrap
set formatoptions-=t

" Display Line numbers
set number

" Highlight line with cursor
set cursorline

" maximum text length at 80 symbols, dictates where colour column shows.
set textwidth=80

" highlight column right after max textwidth
set colorcolumn=+1

" Use OS X clipboard
" set clipboard=unnamed


"--------------------------------------------------
" Tab options

" Copy indent from previous line
set autoindent

" Enable smart indent. it add additional indents whe necessary
set smartindent

" Replace tabs with spaces
set expandtab

" Whe you hit tab at start of line, indent added according to shiftwidth value
set smarttab


" Show line numbers
set number

" Set tabsize
set tabstop=2
set shiftwidth=2

" Indentation always be multiple of shiftwidth
" Applies to  < and > command
set shiftround

"--------------------------------------------------
" Search options

" Add the g flag to search/replace by default
set gdefault

" Highlight search results
set hlsearch

" Ignore case in search patterns
set ignorecase

" Override the 'ignorecase' option if the search patter ncontains upper case characters
set smartcase

" Live search. While typing a search command, show where the pattern
set incsearch

"" Splits
set splitright

set splitbelow

"" Escape gets rid of highlighting
nnoremap <silent> <esc> :noh<return><esc>

" Disable higlighting search result on Enter key
nnoremap <silent> <cr> :nohlsearch<cr><cr>

" Show matching brackets
set showmatch

" Make < and > match as well
set matchpairs+=<:>

" Don't highlight line with cursor
set nocursorline

"--------------------------------------------------
" Wildmenu

" Extended autocmpletion for commands
set wildmenu

" Autocmpletion hotkey
set wildcharm=<TAB>

"--------------------------------------------------
" Folding

" Enable syntax folding in javascript
let javaScript_fold=1

" No fold closed at open file
set foldlevelstart=99
set nofoldenable

" Keymap to toggle folds with space
"nmap <space> za

"--------------------------------------------------
" Edit

" Allow backspace to remove indents, newlines and old text
set backspace=indent,eol,start

" toggle paste mode on \p
set pastetoggle=<leader>p

" Add '-' as recognized word symbol. e.g dw delete all 'foo-bar' instead just 'foo'
set iskeyword+=-

" Disable backups file
set nobackup

" Disable vim common sequense for saving.
" By defalut vim write buffer to a new file, then delete original file
" then rename the new file.
set nowritebackup

" Disable swp files
set noswapfile

" Do not add eol at the end of file.
set noeol

" Visual bell
set vb

"Nice typeface
set guifont=Source\ Code\ Pro:h11

" Allow switching buffers without saving.
set hidden

" Grep options
set grepprg=ag

let g:grep_cmd_opts = '--line-numbers --noheading'

"--------------------------------------------------
" Diff Options

" Display filler
set diffopt=filler

" Open diff in horizontal buffer
set diffopt+=horizontal

" Ignore changes in whitespaces characters
set diffopt+=iwhite

" Navigate between splits with Control+<Direction>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" H goes to beginnning of line
nnoremap H ^
" L goes to end of line
nnoremap L $

" Delete current file with Ctrl-Delete
nnoremap <C-Del> :call delete(expand('%'))<CR>

" map jk in insert mode to escape 
inoremap jk <esc>

" map escape to no-op to burn the jk mapping into my brain
" inoremap <esc> <nop>

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
nnoremap <Leader>vrc :tabe ~/.vimrc<CR>

" w!! sudo opens file and saves it
cmap w!! w !sudo tee % >/dev/null


" Golang syntax highlighting
filetype off
filetype plugin indent off
set runtimepath+=/usr/local/go/misc/vim
filetype plugin indent on
syntax on


"--------------------------------------------------
" Autocmd

" It executes specific command when specific events occured
" like reading or writing file, or open or close buffer
if has("autocmd")
    " Define group of commands,
    " Commands defined in .vimrc don't bind twice if .vimrc will reload
    augroup vimrc
    " Delete any previosly defined autocommands
    au!
        " Auto reload vim after your change it
        au BufWritePost *.vim source $MYVIMRC | AirlineRefresh
        au BufWritePost .vimrc source $MYVIMRC | AirlineRefresh

        " Restore cursor position :help last-position-jump
        au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
          \| exe "normal g'\"" | endif

        " Set filetypes aliases
        au FileType htmldjango set ft=html.htmldjango
        au FileType scss set ft=scss.css
        au FileType less set ft=less.css
        au BufWinEnter * if line2byte(line("$") + 1) > 100000 | syntax clear | endif
        au BufRead,BufNewFile *.js set ft=javascript.javascript-jquery
        au BufRead,BufNewFile *.json set ft=javascript
        " Execute python \ -mjson.tool for autoformatting *.json
        au BufRead,BufNewFile *.json set equalprg=python\ -mjson.tool
        au BufRead,BufNewFile *.bemhtml set ft=javascript
        au BufRead,BufNewFile *.xjst set ft=javascript
        au BufRead,BufNewFile *.tt2 set ft=tt2
        au BufRead,BufNewFile *.plaintex set ft=plaintex.tex

        " Syntax definitions
        au BufRead,BufNewFile *.css set ft=css syntax=css3
        au BufRead,BufNewFile *.less set ft=less syntax=less
        au BufRead,BufNewFile *.scss set ft=sass syntax=sass
        au BufRead,BufNewFile *.go set ft=go syntax=go
        " au BufNewFile,BufRead *.ini, *.info, */.hgrc,*/.hg/hgrc setf ini

        " Auto close preview window, it uses with tags,
        " I don't use it
        autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
        autocmd InsertLeave * if pumvisible() == 0|pclose|endif

        " Disable vertical line at max string length in NERDTree
        autocmd FileType * setlocal colorcolumn=+1
        autocmd FileType nerdtree setlocal colorcolumn=""

        " Omnicomplete definitions
        autocmd FileType python set omnifunc=pythoncomplete#Complete
        autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
        autocmd FileType css set omnifunc=csscomplete#CompleteCSS
        autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
        autocmd FileType php set omnifunc=phpcomplete#CompletePHP
        autocmd FileType c set omnifunc=ccomplete#Complete

        " Enable omni completion.
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

        " Enable Folding, uses plugin vim-javascript-syntax
        "" au FileType javascript* call JavaScriptFold()

    " Group end
    augroup END

endif

" Visual star
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction


"hi ColorColumn guibg=grey7
hi MatchParen      guifg=#000000 guibg=#FD971F gui=bold

"" Somebody is turning on gdefault. We don't want that.
set nogdefault

noremap <Leader>sp :cd ~/Sites/stockpools.dev<return>
