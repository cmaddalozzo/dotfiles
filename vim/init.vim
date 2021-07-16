" Set character encoding to use in vim
set encoding=utf-8
scriptencoding utf-8
" Change that leader.
let g:mapleader=','
" Change the local leader.
let g:maplocalleader='\'

set shell=/bin/zsh

" Point to location of python binary
let g:python3_host_prog = '/usr/local/bin/python3'

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

"-------------------------
" LSP config
" Language servers: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
" Example: https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
"-------------------------
Plug 'neovim/nvim-lspconfig'

nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <silent> <C-]> <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<cr>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>

sign define LspDiagnosticsSignError text=❌ texthl=LspDiagnosticsError linehl= numhl=
sign define LspDiagnosticsSignWarning text=⚠️ texthl=LspDiagnosticsWarning linehl= numhl=
sign define LspDiagnosticsSignInformation text=ℹ️ texthl=LspDiagnosticsInformation linehl= numhl=
sign define LspDiagnosticsSignHint text=💡 texthl=LspDiagnosticsHint linehl= numhl=

"-------------------------
" completion
" https://github.com/nvim-lua/completion-nvim
"-------------------------
Plug 'nvim-lua/completion-nvim'
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

let g:completion_chain_complete_list = [
    \{'complete_items': ['lsp']},
    \{'mode': '<c-p>'},
    \{'mode': '<c-n>'}
\]

"-------------------------
" lsp-status.nvim
" 
"-------------------------
Plug 'nvim-lua/lsp-status.nvim'

"-------------------------
" Telescope
"-------------------------
Plug 'nvim-telescope/telescope.nvim'
" Base plugins
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
nnoremap [telescope] <Nop>
nmap <space> [telescope]
nnoremap <silent> [telescope]<space> :<C-u>Telescope find_files<cr>
nnoremap <silent> [telescope]m :<C-u>Telescope oldfiles<cr>
nnoremap <silent> [telescope]b :<C-u>Telescope buffers<cr>
nnoremap <silent> [telescope]/ :<C-u>Telescope live_grep<cr>
nnoremap <silent> [telescope]* :<C-u>Telescope grep_string<cr>
nnoremap <silent> [telescope]f :<C-u>Telescope file_browser<cr>
nnoremap <silent> [telescope]s :<C-u>Telescope lsp_document_symbols<cr>
nnoremap <silent> [telescope]h :<C-u>Telescope help_tags<cr>
nnoremap <silent> [telescope]c
      \ <cmd>lua require('telescope.builtin').find_files({search_dirs={'~/.config/nvim'}})<CR>

"-------------------------
" Tmux plugin
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
" Neoformat
"
Plug 'sbdchd/neoformat'

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

" CoC
" Use release branch (recommend)
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Install language servers:
" :CocInstall coc-tsserver coc-json coc-python coc-rust-analyzer coc-git coc-prettier coc-pairs

" Use tab for trigger completion with characters ahead and navigate.
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction
"
"" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
"" position. Coc only does snippet and additional edit on confirm.
"if exists('*complete_info')
"  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
"else
"  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"endif
"
"nnoremap <silent> K :call <SID>show_documentation()<CR>
"function! s:show_documentation()
"  if (index(['vim','help'], &filetype) >= 0)
"    execute 'h '.expand('<cword>')
"  else
"    call CocAction('doHover')
"  endif
"endfunction
"
"" mappings
"autocmd CursorHold * silent call CocActionAsync('highlight')
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)
"nmap <leader>rn <Plug>(coc-rename)

"command! -nargs=0 Prettier :CocCommand prettier.formatFile
" /CoC

"-------------------------
" galaxyline.nvim
"
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
" for devicons
Plug 'kyazdani42/nvim-web-devicons' " lua

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
" Auto Pairs
"
Plug 'jiangmiao/auto-pairs'

"-------------------------
" Enable repeating supported plugin maps with '.'
"
Plug 'tpope/vim-repeat'

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
" Polyglot
"
" A collection of language packs
"
Plug 'sheerun/vim-polyglot'

"-------------------------
" nuuid.vim
" <Plug>Nuuid mapping to insert a new UUID at your current cursor location. 
" <Leader>u in normal and visual modes.
"
"Plug 'kburdett/vim-nuuid'

"-------------------------
" Markdown preview
"
" Personal Wiki for Vim
"
"   MarkdownPreview
"     open preview window in markdown buffer
"   MarkdownPreviewStop
"     close the preview window and server
Plug 'iamcco/markdown-preview.vim', { 'for': 'markdown'}

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
let tractable.nested_syntaxes = {'js': 'javascript', 'ts': 'typescript', 'json': 'json', 'sh' : 'sh'}
let tractable.automatic_nested_syntaxes = 1
let tractable.auto_tags = 1

let personal = {}
let personal.path = '/Users/cmadd/Dropbox/Documents/vimwiki/personal/'
let personal.syntax = 'markdown'
let personal.ext = '.md'

let g:vimwiki_list = [tractable, personal]

"-------------------------
" Colour Schemes
"


"-------------------------
" Solarized
"
"Plug 'altercation/vim-colors-solarized'

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

" /Colour Schemes
"-------------------------

" Initialize plugin system
" Automatically executes filetype plugin indent on and syntax enable
call plug#end()

" END plugins

lua require('config')

lua require('evilline')

"######################################
"   Vim settings
"######################################

set background=dark

highlight CocInfoHighlight ctermbg=Yellow ctermfg=Black
highlight CocErrorHighlight ctermbg=DarkRed ctermfg=Black
highlight CocWarningHighlight cterm=underline

"colorscheme solarized
" colorscheme molokai
" colorscheme gotham
" colorscheme badwolf
colorscheme onedark

" Auto reload changed files
set autoread

" Indicates fast terminal connection
set ttyfast

" Let vim know what encoding we use in our terminal
set termencoding=utf-8

" Enable colors
set termguicolors
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

" r -> Automatically insert the current comment leader after hitting
" <Enter> in Insert mode.
" o -> Automatically insert the current comment leader after hitting 'o' or
" 'O' in Normal mode.
set formatoptions+=ro

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
set guifont=SauceCodePro\ Nerd\ Font:h11

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

"-------------------------
" Netrw bindings
"
let g:netrw_liststyle=3         " tree
let g:netrw_banner=0            " no banner
let g:netrw_altv=1              " open files on right
let g:netrw_preview=1           " open previews vertically
let g:netrw_localrmdir='rm -r'

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
nnoremap <Leader>vrc :e $MYVIMRC<CR>

" w!! sudo opens file and saves it
cmap w!! w !sudo tee % >/dev/null

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>

" JSON format
vnoremap <Leader>jf :'<,'>!jq .<CR>
vnoremap <Leader>jc :'<,'>!jq -c .<CR>

" Insert a UUID at the cursor
nnoremap <leader>u i<C-R>=luaeval('require("functions").uuid()')<CR><Esc>
vnoremap <leader>u c<C-R>=luaeval('require("functions").uuid()')<CR><Esc>

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

command! -nargs=1 RelMove execute ":!mv % %:p:h" . "/" . string(<q-args>)

if isdirectory($PWD .'/node_modules')
    let $PATH = $PWD . '/node_modules/.bin' . ':' . $PATH
endif
