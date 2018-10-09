" Set character encoding to use in vim
set encoding=utf-8
scriptencoding utf-8
" Change that leader.
let g:mapleader=','
" Change the local leader.
let g:maplocalleader='\'

set shell=/bin/zsh

let $MYVIMFUNCTIONS = fnamemodify($MYVIMRC, ':h') . '/functions.vim'
let $MYVIMAUTOCOMMANDS   = fnamemodify($MYVIMRC, ':h') . '/autocommands.vim'

""
" Functions
""
source $MYVIMFUNCTIONS

""
" Autocommands
""
source $MYVIMAUTOCOMMANDS

"######################################
"#  vim-plug init
"######################################

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

"######################################
"#   Bundles
"######################################
"

"-------------------------
" vimproc
"
" Interactive command execution in Vim.

Plug 'Shougo/vimproc.vim', { 'do': 'make' }

" Denite.vim
"
" plugin for fuzzy file search, most recent files list
" and much more
" Plug 'Shougo/denite.nvim'

" function! s:denite_config()
"   " If ag exists use it instead of grep
"   if executable('ag')
"     " Use ag (the silver searcher)
"     " https://github.com/ggreer/the_silver_searcher
"     "
"     " Change file_rec command.
"     call denite#custom#var('file_rec', 'command',
"     \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
" 
"    " Change grep source
"     call denite#custom#var('grep', 'command', ['ag'])
"     call denite#custom#var('grep', 'default_opts',
"         \ ['-i', '--vimgrep'])
"     call denite#custom#var('grep', 'recursive_opts', [])
"     call denite#custom#var('grep', 'pattern_opt', [])
"     call denite#custom#var('grep', 'separator', ['--'])
"     call denite#custom#var('grep', 'final_opts', [])
"   endif
" 
"   " Change matchers.
"   call denite#custom#source('file_rec', 'matchers', ['matcher_substring'])
"   call denite#custom#source('buffer', 'matchers', ['matcher_substring'])
"   call denite#custom#source('file_mru', 'matchers', ['matcher_substring', 'matcher_project_files'])
" 	call denite#custom#source('file_mru', 'converters',
" 	      \ ['converter/relative_abbr'])
" 
"   " Change sorters.
"   call denite#custom#source('file_rec', 'sorters', ['sorter_rank'])
"   call denite#custom#source('buffer', 'sorters', ['sorter_mru'])
" 
"   " Always autoresize
"   call denite#custom#option('_', 'auto_resize', v:true)
"   call denite#custom#option('_', 'cursor_wrap', v:true)
"   call denite#custom#option('_', 'highlight_mode_insert', 'IncSearch')
"   " call denite#custom#option('_', 'highlight_mode_normal', 'SpellCap')
"   " call denite#custom#option('_', 'highlight_matched_range', 'Title')
"   " call denite#custom#option('_', 'highlight_matched_char', 'SpellCap')
" 
"   " kk switches to 'normal' mode
"   call denite#custom#map('insert', 'kk', '<C-o>')
"   call denite#custom#map('insert', 'jj', '<C-o>')
"   " a performs default action
"   call denite#custom#map('normal', 'a', '<CR>')
" endfunction

" nnoremap [denite] <Nop>
" nmap <space> [denite]
" nnoremap <silent> [denite]<space> :<C-u>Denite file_rec<CR>
" nnoremap <silent> [denite]g :<C-u>Denite -buffer-name=changes change<cr>
" nnoremap <silent> [denite]b :<C-u>Denite -buffer-name=buffers buffer<cr>
" nnoremap <silent> [denite]m :<C-u>Denite -buffer-name=mru file_mru<cr>
" nnoremap <silent> [denite]p :<C-u>Denite -buffer-name=registers register<cr>
" nnoremap <silent> [denite]/ :<C-u>Denite -buffer-name=search grep<cr>
" nnoremap <silent> [denite]f :<C-u>DeniteCursorWord file_rec<cr>
" nnoremap <silent> [denite]* :<C-u>DeniteCursorWord -buffer-name=searchword grep<cr>
" 
" nmap <silent> [denite]c [denite]g<cr>
" 
" nmap <Leader>b [denite]b


" FZF
" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

nnoremap [fzf] <Nop>
nmap <space> [fzf]
nnoremap <silent> [fzf]<space> :<C-u>Files<CR>
nnoremap <silent> [fzf]g :<C-u>Gfiles?<cr>
nnoremap <silent> [fzf]b :<C-u>Buffer<cr>
"nnoremap <silent> [fzf]m :<C-u>Denite -buffer-name=mru file_mru<cr>
"nnoremap <silent> [fzf]p :<C-u>Denite -buffer-name=registers register<cr>
nnoremap <silent> [fzf]/ :<C-u>Ag<cr>
"nnoremap <silent> [fzf]f :<C-u>DeniteCursorWord file_rec<cr>
"nnoremap <silent> [fzf]* :<C-u>DeniteCursorWord -buffer-name=searchword grep<cr>
"nmap <silent> [denite]c [denite]g<cr>

nmap <Leader>b [fzf]b


" cpsm
"
" A CtrlP matcher, specialized for paths.
"
" Plug 'nixprime/cpsm'

"
" Most recent files source for unite
"
"Plug 'Shougo/neomru.vim'

" Plug '~/.local/share/nvim/site/denite_buffer_mru'

"-------------------------
" Tmux plugins
"
" Add proper support for focus events
" Plug 'tmux-plugins/vim-tmux-focus-events'
" Allow seemless navigation between tmux splits
" <C-H>       * :TmuxNavigateLeft<CR>
" <C-J>       * :TmuxNavigateDown<CR>
" <C-K>       * :TmuxNavigateUp<CR>
" <C-L>       * :TmuxNavigateRight<CR>
" <C-\>       * :TmuxNavigatePrevious<CR>
Plug 'christoomey/vim-tmux-navigator'

"-------------------------
" vinegar.vim
"
" Great file system explorer, it appears when you open dir in vim
" Allow modification of dir, and may other things
" Must have
"" Plug 'tpope/vim-vinegar'
" Ctrl-t opens NerdTree
" nnoremap <C-t> :Explore<CR>
" /vinegar.vim
"-------------------------

"-------------------------
" Netrw bindings
"
let g:netrw_liststyle=3         " tree
let g:netrw_banner=0            " no banner
let g:netrw_altv=1              " open files on right
let g:netrw_preview=1           " open previews vertically
let g:netrw_localrmdir='rm -r'

"-------------------------
" ALE
" Asynchronous Lint Engine
"
Plug 'w0rp/ale'
let g:ale_sign_error = '✠'

"-------------------------
" Neomake

" /Neomake
"
" Plug 'neomake/neomake'
" let g:neomake_error_sign = {'text': '✗', 'texthl': 'NeomakeErrorSign'}

"-------------------------
" Neoformat
"
Plug 'sbdchd/neoformat'

let g:neoformat_enabled_python = ['autopep8']
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_javascript = ['prettier']

let prettier_formatter = {
    \ 'exe': 'prettier',
    \ 'args': ['--config', '~/.prettierrc', '--stdin', '--stdin-filepath', '%:p'],
    \ 'stdin': 1,
    \ }

let g:neoformat_javascript_prettier = prettier_formatter
let g:neoformat_typescript_prettier = prettier_formatter

nmap <Leader>f :Neoformat<CR>

"-------------------------
" YouCompleteMe
"
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
set shortmess+=c
let g:ycm_show_diagnostics_ui=0
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_error_symbol = '✗'
let g:ycm_warning_symbol = '⚠'
highlight link YcmErrorSign SpellBad
highlight link YcmWarningSign SpellCap

"-------------------------
" Tsuquyomi
"
" Make your Vim a TypeScript IDE.
"
" Plug 'Quramy/tsuquyomi'
let g:tsuquyomi_use_dev_node_module=2
let g:tsuquyomi_disable_quickfix = 1
"let g:syntastic_typescript_checkers = ['tslint']
let g:tsuquyomi_shortest_import_path = 1
let g:tsuquyomi_disable_default_mappings = 1

call NpmExecSet('tsserver', 'tsuquyomi_tsserver_path')
call NpmExecSet('tsc', 'neomake_typescript_tsc_exe')
call NpmExecSet('tslint', 'neomake_typescript_tslint_exe')

let g:neomake_coffee_enabled_makers = []
"let g:neomake_typescript_enabled_makers = ['tslint']

"-------------------------
" Tern for Vim
"
" Tern-based JavaScript editing support
"Plug 'ternjs/tern_for_vim'
"let g:tern_map_keys=0

"-------------------------
" UltiSnips with snippets
"
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

let g:UltiSnipsSnippetsDir = fnamemodify($MYVIMRC, ':h') . '/snippets'

let g:UltiSnipsExpandTrigger="<f2>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsListSnippets="<c-e>"

nmap <Leader>es :UltiSnipsEdit<return>

"-------------------------
" YankRing.vim
"
"slow-Plug 'vim-scripts/YankRing.vim'

"-------------------------
" Airline
"
" Nice statusline/ruler for vim
"
Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

" unicode symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" Set custom left separator
let g:airline_left_sep = '▶'
" Set custom right separator
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'

" Use MacVim's tabs
let g:airline#extensions#tabline#enabled = 0

" Don't display encoding
let g:airline_section_y = ''

" Don't display filetype
let g:airline_section_x = ''

" /Airline
"-------------------------


"-------------------------
" smartpairs.vim
"
" 
Plug 'gorkunov/smartpairs.vim'

"-------------------------
" Matchit
"
Plug 'tmhedberg/matchit'

"-------------------------
" delimitMate
"
" Allow autoclose paired characters like [,] or (,),
" and add smart cursor positioning inside it,
"
Plug 'Raimondi/delimitMate'

"-------------------------
" surround.vim
"
" Enable repeating supported plugin maps with '.'
"
Plug 'tpope/vim-repeat'

"-------------------------
" abolish.vim
"
" Easily search for, substitute, and abbreviate multiple variants of a word
"
Plug 'tpope/vim-abolish'

"-------------------------
" surround.vim
"
" Add usefull hotkey for operation with surroundings
" cs{what}{towhat} - inside '' or [] or something like this allow
" change surroundings symbols to another
" and ds{what} - remove them
"
Plug 'tpope/vim-surround'

"-------------------------
" ack.vim
"
" Plug 'mileszs/ack.vim'

" let g:ackprg = 'ag --vimgrep'

"-------------------------
" vim-gitgutter
"
" A Vim plugin which shows a git diff in the 'gutter' (sign column).
"
Plug 'airblade/vim-gitgutter'

nmap <silent> <leader>gg :GitGutterToggle<cr>

"-------------------------
" vim-fugitive
"
" git wrapper
"
Plug 'tpope/vim-fugitive'
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <silent> <Leader>gg :Gpush<CR>
nnoremap <Leader>gpl :Gpull<CR>
nnoremap <Leader>gpp :Gpush<CR>
nnoremap <Leader>gpo :Gpull<CR>

"-------------------------
" vim-signature
" smartpairs.vim
"
" Plugin to toggle, display and navigate marks
Plug 'kshenoy/vim-signature'
nmap <Leader>m :SignatureToggle<CR>

"-------------------------
" Polyglot
"
" A collection of language packs
"
Plug 'sheerun/vim-polyglot'

"-------------------------
" Avro syntax
"
Plug 'dln/avro-vim'

"-------------------------
" nuuid.vim
" <Plug>Nuuid mapping to insert a new UUID at your current cursor location. 
" <Leader>u in normal and visual modes.
"
Plug 'kburdett/vim-nuuid'

"-------------------------
" Colorizer
" color hex codes and color names
"
Plug 'chrisbra/Colorizer'

"-------------------------
" Markdown preview
"
" Personal Wiki for Vim
"
"   MarkdownPreview
"     open preview window in markdown buffer
"   MarkdownPreviewStop
"     close the preview window and server
Plug 'iamcco/markdown-preview.vim'

"-------------------------
" Markdown TOC generator
let g:vmt_link_prefix = 'markdown-header-'
Plug '~/Code/vim-markdown-toc'

"-------------------------
" Vimwiki
"
" Personal Wiki for Vim
"
Plug 'vimwiki/vimwiki'

let tractable = {}
let tractable.path = '/Users/cmadd/Dropbox/Documents/vimwiki/tractable/'
let tractable.syntax = 'markdown'
let tractable.ext = '.md'
let tractable.nested_syntaxes = {'js': 'javascript', 'ts': 'typescript', 'cql' : 'cql', 'json': 'json', 'sh' : 'sh'}
let tractable.automatic_nested_syntaxes = 1
let tractable.auto_tags = 1

let personal = {}
let personal.path = '/Users/cmadd/Dropbox/Documents/vimwiki/personal/'
let personal.syntax = 'markdown'
let personal.ext = '.md'

let leisure = {}
let leisure.path = '/Users/cmadd/Dropbox/Documents/vimwiki/leisure/'
let leisure.syntax = 'markdown'
let leisure.ext = '.md'

let g:vimwiki_list = [tractable, leisure, personal]

"-------------------------
" Colour Schemes
"


"-------------------------
" Solarized
"
"Plug 'altercation/vim-colors-solarized'

"-------------------------
" iceberg.vim
"
Plug 'cocopon/iceberg.vim'

"
"-------------------------
" Gotham
"
"Plug 'whatyouhide/vim-gotham'

"-------------------------
" Molokai
" Plug 'tomasr/molokai'

"-------------------------
" Afterglow
" Plug 'danilo-augusto/vim-afterglow'

"-------------------------
" Bad Wolf
"
" Plug 'sjl/badwolf'

"-------------------------
" Onedark
"
Plug 'joshdick/onedark.vim'

"-------------------------
" Paper Color (sic)
"
" Plug 'NLKNguyen/papercolor-theme'
"
"-------------------------
" Moonfly
"
Plug 'bluz71/vim-moonfly-colors'

" /Colour Schemes
"-------------------------

" /Bundles
"
" Initialize plugin system
" Automatically executes filetype plugin indent on and syntax enable
call plug#end()

" call s:denite_config()

"######################################
"   Vim settings
"######################################

set background=light
colorscheme iceberg
let g:airline_theme='onedark'

"colorscheme solarized
" colorscheme molokai
" colorscheme gotham
" colorscheme badwolf

" Auto reload changed files
set autoread

" Indicates fast terminal connection
set ttyfast

" Let vim know what encoding we use in our terminal
set termencoding=utf-8

"--------------------------------------------------
" Display options

" Hide showmode
" Showmode is useless with airline
set noshowmode

" Show file name in window title
set title

" Remove all useless messages like intro screen and use abbreviation like RO
" instead readonly and + instead modified
set shortmess=atI

" Allow scrolling in tmux vim
set mouse=a

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

" The cursor should stay where you leave it, instead of moving to the first non
" blank of the line
set nostartofline

" Disable wrapping long string
set nowrap
set formatoptions-=t

" Display Line numbers
set number

" maximum text length at N symbols, dictates where colour column shows.
set textwidth=96

" highlight column right after max textwidth
set colorcolumn=+1

" set ballooneval

" Use OS X clipboard
set clipboard=unnamedplus

"--------------------------------------------------
" Tab options

" Copy indent from previous line
set autoindent

" Add additional indents when necessary
set smartindent

" Replace tabs with spaces
set expandtab

" Whe you hit tab at start of line, indent added according to shiftwidth value
set smarttab

" Set tabsize
set tabstop=2
set shiftwidth=2

" Indentation always multiple of shiftwidth
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

" Override the 'ignorecase' option if the search pattern contains upper case characters
set smartcase

" Live search. While typing a search command, show matches
set incsearch

" New verticle splits go right
set splitright

" New horizontal splits go below
set splitbelow

" <Leader>n gets rid of highlighting
nnoremap <Leader>n :noh<return><esc>

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
let g:javaScript_fold=1

" Folds open by default 
set foldlevelstart=99
set nofoldenable

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
set noendofline

" Visual bell
set visualbell

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
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

" H goes to beginnning of line
nnoremap H ^
" L goes to end of line
nnoremap L $

" Delete current file with Ctrl-Delete
nnoremap <C-Del> :call delete(expand('%'))<CR>

" map jk in insert mode to escape 
inoremap jk <esc>

"" Q plays back q macro.
nnoremap Q @q

"" Reselect on Option-v
nnoremap √ gv

"" Close buffer.
nnoremap <Leader>d :bd<CR>

"" Easy switching to last used buffer.
nnoremap <Leader>l :e#<CR>

"" Easy open this.
nnoremap <Leader>vrc :tabe $MYVIMRC<CR>

" w!! sudo opens file and saves it
cmap w!! w !sudo tee % >/dev/null

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>

" JSON format
vnoremap <Leader>jf :'<,'>!jq .<CR>
vnoremap <Leader>jc :'<,'>!jq -c .<CR>

nnoremap <silent> <Leader>js :silent call Decaffeinate()<CR>

" Toggle quickfix/location lists
nmap <silent> <leader>e :call ToggleList("Location List", 'l')<CR>
nmap <silent> <leader>c :call ToggleList("Quickfix List", 'c')<CR>


" Visual star
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch()
  let l:temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = l:temp
endfunction

inoremap \fn <C-R>=substitute(expand("%:p"), getcwd(), '', '')<CR>

"" Somebody is turning on gdefault. We don't want that.
set nogdefault

" Commands

" Edit filetype plugin
command! EditFtPlugin execute ':e ~/.config/nvim/ftplugin/' . split(&filetype, '\.')[0] . '.vim'