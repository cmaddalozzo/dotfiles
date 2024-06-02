-- t <comma> as the leader key
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ','
vim.g.maplocalleader = '\\'

-- disable netrw - recommended by nvim-tree/nvim-tree.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins')

require('config.filetypes').setup()

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- [[ Setting options ]]
-- See `:help vim.o`
vim.opt.shell = '/bin/zsh'
vim.opt.exrc = true
vim.opt.swapfile = false
-- Disable backups file
vim.opt.backup = false
-- Disable vim common sequense for saving.
-- By defalut vim write buffer to a new file, then delete original file
-- then rename the new file.
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
vim.opt.grepprg = 'rg'
-- Show matching brackets
vim.opt.showmatch = true
-- Make < and > match as well
vim.opt.matchpairs:append('<:>')
-- Don't highlight the line with the cursor
vim.opt.cursorline = false

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
-- Whe you hit tab at start of line, indent added according to shiftwidth value
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

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


--Go to previous file
vim.keymap.set('n', '<leader>l', '<cmd>e#<cr>')
-- Edit this file
vim.keymap.set('n', '<leader>vrc', '<cmd>e ' .. vim.env.MYVIMRC .. '<cr>')

--Remove highlighting
vim.keymap.set('n', '<leader>n', '<cmd>noh<cr>')

vim.keymap.set('n', '<leader>u', require('functions').insert_uuid)

vim.keymap.set('n', '<leader>g', require('neogit').open)

-- [[ Diagnostics ]]
local signs = { Error = "❌", Warn = "⚠️ ", Hint = "💡", Info = "ℹ️ " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
