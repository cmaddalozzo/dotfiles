" Set character encoding to use in vim
set encoding=utf-8
scriptencoding utf-8
" Change that leader.
let g:mapleader=','
" Change the local leader.
let g:maplocalleader='\'

set shell=/bin/zsh

set exrc

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

lua <<EOF
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics,
      {
        virtual_text = false,
        signs = true,
        update_in_insert = false,
        underline = true,
      }
    )
EOF
"-------------------------
" Treesitter
"-------------------------

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"-------------------------
" Treesitter context
"-------------------------
"Plug 'romgrk/nvim-treesitter-context'

"-------------------------
" Trouble
"
" A pretty list for showing diagnostics, references, telescope results etc.
"-------------------------
Plug 'folke/trouble.nvim'
"-------------------------
" completion
" https://github.com/nvim-lua/completion-nvim
"-------------------------
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'

inoremap <silent> <C-n> <cmd>lua require'luasnip'.jump(1)<Cr>
inoremap <silent> <C-p> <cmd>lua require'luasnip'.jump(-1)<Cr>

"-------------------------
" lsp-status.nvim
" 
"-------------------------
Plug 'nvim-lua/lsp-status.nvim'

let g:has_neuron = executable('neuron')
"-------------------------
" Neuron
"
if (g:has_neuron)
  echo "HAS NEURON"
  Plug 'oberblastmeister/neuron.nvim', { 'branch': 'unstable' }
endif

"-------------------------
" Telescope
"-------------------------
Plug 'nvim-telescope/telescope.nvim'
" Base plugins
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
" File browser
Plug 'nvim-telescope/telescope-file-browser.nvim'
nnoremap [telescope] <Nop>
nmap <space> [telescope]
nnoremap <silent> [telescope]<space> :<C-u>Telescope find_files<cr>
nnoremap <silent> [telescope]m :<C-u>Telescope oldfiles<cr>
nnoremap <silent> [telescope]b :<C-u>Telescope buffers<cr>
nnoremap <silent> [telescope]r
      \ <cmd>lua require('telescope').extensions.file_browser.file_browser({
      \ path=vim.api.nvim_exec("echo expand('%:p:h')", true),
      \ hidden=true
      \ })<CR>
nnoremap <silent> [telescope]/ :<C-u>Telescope live_grep<cr>
nnoremap <silent> [telescope]* :<C-u>Telescope grep_string<cr>
nnoremap <silent> [telescope]f :<C-u>Telescope file_browser<cr>
nnoremap <silent> [telescope]s :<C-u>Telescope lsp_document_symbols<cr>
nnoremap <silent> [telescope]h :<C-u>Telescope help_tags<cr>
nnoremap <silent> [telescope]c
      \ <cmd>lua require('telescope.builtin').find_files({search_dirs={'~/.config/nvim'}})<CR>

nnoremap <silent> [telescope]z <cmd>lua require'neuron/telescope'.find_zettels()<CR>

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
" neoformat
"
Plug 'sbdchd/neoformat'

let g:neoformat_only_msg_on_error = 1

"-------------------------
" Peekup
"
Plug 'gennaro-tedesco/nvim-peekup'
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
Plug 'NTBBloodbath/galaxyline.nvim' , {'branch': 'main'}
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
nnoremap <leader>gs :Git status<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gd :Git diff<CR>
nnoremap <leader>gw :Git write<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <silent> <leader>gg :Git push<CR>
nnoremap <leader>gpl :Git pull<CR>
nnoremap <leader>gpp :Git push<CR>
nnoremap <leader>gpo :Git pull<CR>

"-------------------------
" nvim-comment
"
Plug 'terrortylor/nvim-comment'

"-------------------------
" Markdown Preview
"
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}



"-------------------------
" Polyglot
"
" A collection of language packs
"
"Plug 'sheerun/vim-polyglot'

"-------------------------
" nuuid.vim
" <Plug>Nuuid mapping to insert a new UUID at your current cursor location. 
" <leader>u in normal and visual modes.
"
"Plug 'kburdett/vim-nuuid'

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
" S3Edit
"
Plug '~/.vim/plugins/s3edit'


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
"Plug 'joshdick/onedark.vim'

"-------------------------
" Neon
"
Plug 'rafamadriz/neon'
let g:neon_style='default'

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

set completeopt=menu,menuone,noselect

lua require('completion')
lua require('lsp')

"######################################
"   Vim settings
"######################################

set background=dark

"colorscheme solarized
" colorscheme molokai
" colorscheme gotham
" colorscheme badwolf
"colorscheme onedark
colorscheme neon

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

" <leader>n gets rid of highlighting
nnoremap <leader>n :noh<return><esc>

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

" Use GNU Tar
let g:tar_cmd="/usr/local/bin/gtar"

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
nnoremap <leader>d :bd<CR>

"" Easy switching to last used buffer.
nnoremap <leader>l :e#<CR>

"" Easy open this.
nnoremap <leader>vrc :e $MYVIMRC<CR>

" w!! sudo opens file and saves it
cmap w!! w !sudo tee % >/dev/null

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" JSON format
vnoremap <leader>jf :'<,'>!jq .<CR>
vnoremap <leader>jc :'<,'>!jq -c .<CR>

" Insert a UUID at the cursor
nnoremap <leader>u i<C-R>=luaeval('require("functions").uuid()')<CR><Esc>
vnoremap <leader>u c<C-R>=luaeval('require("functions").uuid()')<CR><Esc>

nnoremap <silent> <leader>js :silent call Decaffeinate()<CR>

nnoremap <silent> <leader>tf <cmd>Trouble lsp_document_diagnostics <CR>
nnoremap <silent> <leader>ta <cmd>Trouble lsp_workspace_diagnostics <CR>
nnoremap <silent> <leader>tr <cmd>Trouble lsp_references <CR>
nnoremap <silent> <leader>td <cmd>Trouble lsp_definitions <CR>

nnoremap <silent> <leader>a <cmd>lua vim.lsp.buf.code_action()<CR>

" Toggle quickfix/location lists
"nmap <silent> <leader>e :call ToggleList("Location List", 'l')<CR>
nnoremap <silent> <leader>e <cmd>lua vim.diagnostic.open_float()<CR>
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

command! W :w

if isdirectory($PWD .'/node_modules')
    let $PATH = $PWD . '/node_modules/.bin' . ':' . $PATH
endif
