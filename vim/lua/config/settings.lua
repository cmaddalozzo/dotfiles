local M = {}

function M.setup()
  -- See `:help vim.o`
  vim.opt.shell = '/bin/zsh'
  vim.opt.exrc = true
  vim.opt.swapfile = false
  -- Disable backups file
  vim.opt.backup = false
  -- Disable vim common sequence for saving.
  -- By default vim writes the buffer to a new file, then deletes the original file
  -- then renames the new file.
  vim.opt.writebackup = false
  -- Add '-' as recognized word symbol. e.g dw delete all 'foo-bar' instead just 'foo'
  vim.opt.iskeyword:append('-')
  -- Do not add eol at the end of file.
  vim.opt.endofline = false
  -- Visual bell
  vim.opt.visualbell = true
  -- Allow switching buffers without saving.
  vim.opt.hidden = true
  -- Grep command
  vim.opt.grepprg = 'rg --vimgrep'
  vim.opt.grepformat = '%f:%l:%c:%m'
  -- Show matching brackets
  vim.opt.showmatch = true
  -- Make < and > match as well
  vim.opt.matchpairs:append('<:>')
  -- Don't highlight the line with the cursor
  vim.opt.cursorline = false

  -- Tar command
  vim.g.tar_cmd = '/usr/local/bin/gtar'

  -- Set highlight on search
  vim.o.hlsearch = true

  -- Make line numbers default
  vim.wo.number = true

  -- Show whitespace characters
  vim.o.list = true

  -- Setup how we display whitespace
  vim.o.listchars = "tab:⇥ ,trail:·,extends:⋯,precedes:⋯,nbsp:~"

  -- Numbers of rows to keep to the left and to the right off the screen
  vim.o.scrolloff = 10
  vim.o.sidescrolloff = 10

  -- Indenting options
  -- Copy indent from previous line
  vim.o.autoindent = true
  -- Add additional indents when necessary
  vim.o.smartindent = true
  -- Replace tabs with spaces
  vim.o.expandtab = true
  -- When you hit tab at start of line, indent added according to shiftwidth value
  vim.o.smarttab = true
  -- Set tabsize
  vim.o.tabstop = 2
  vim.o.shiftwidth = 2
  -- Indentation always multiple of shiftwidth
  -- Applies to  < and > command
  vim.o.shiftround = true

  -- Splits
  -- New verticle splits go right
  vim.o.splitright = true
  -- New horizontal splits go below
  vim.o.splitbelow = true

  -- Enable mouse mode
  vim.o.mouse = 'a'

  -- Sync clipboard between OS and Neovim.
  --  Remove this option if you want your OS clipboard to remain independent.
  --  See `:help 'clipboard'`
  vim.o.clipboard = 'unnamedplus'

  -- Enable break indent
  vim.o.breakindent = true

  -- Save undo history
  vim.o.undofile = true

  -- Case insensitive searching UNLESS /C or capital in search
  vim.o.ignorecase = true
  vim.o.smartcase = true

  -- Keep signcolumn on by default
  vim.wo.signcolumn = 'yes'

  -- Decrease update time
  vim.o.updatetime = 250
  vim.o.timeout = true
  vim.o.timeoutlen = 300

  -- Set completeopt to have a better completion experience
  vim.o.completeopt = 'menuone,noselect'

  vim.o.termguicolors = true
end

return M
