return {
  -- NOTE: First, some plugins that don't require any configuration
  'tpope/vim-sleuth',
  -- Add useful hotkey for operation with surroundings
  -- cs{what}{towhat} - inside '' or [] or something like this allow
  -- change surroundings symbols to another
  -- and ds{what} - remove them
  'tpope/vim-surround',
  -- Smart matching of pairs e.g vv
  'gorkunov/smartpairs.vim',
  'tmhedberg/matchit',
  'jiangmiao/auto-pairs',
  'christoomey/vim-tmux-navigator',
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    init = function()
      require('config.lsp').setup()
    end,
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },
      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
      'RRethy/vim-illuminate',
      'nvimtools/none-ls.nvim',
      'towolf/vim-helm',
      'mfussenegger/nvim-jdtls',
    }
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    init = function()
      require('config.completion').setup()
    end,
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets' },
  },
  -- collection of snippets
  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    opts = {}
  },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    dependencies = {
      'kyazdani42/nvim-web-devicons',
      'nvim-lua/lsp-status.nvim'
    },
    opts = {
      options = {
        icons_enabled = true,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_x = { 'filetype', "require'lsp-status'.status()" },
      }
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    main = "ibl",
    opts = {
      indent = {
        char = '┊',
      }
    },
  },

  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
  },
  {
    'nvim-tree/nvim-tree.lua',
    keys = {
      { "<leader>f", "<cmd>NvimTreeToggle<cr>", "nvim-tree" }
    },
    opts = {
      on_attach = function(bufnr)
        local api = require "nvim-tree.api"

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        -- default mapping
        api.config.mappings.default_on_attach(bufnr)
        -- custom mappings
        vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
      end
    },
    config = true,
    dependencies = { 'kyazdani42/nvim-web-devicons' },
  },
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    init = function()
      require('config.telescope').setup()
    end,
    version = '*',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
  -- Telescropt file browser
  {
    'nvim-telescope/telescope-file-browser.nvim',
    version = '*',
    dependencies = { 'nvim-telescope/telescope.nvim' }
  },
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    init = function()
      require('config.treesitter').setup()
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      cmd = 'Neogit',
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    config = true
  },
  {
    "FabijanZulj/blame.nvim",
    cmd = 'BlameToggle',
    keys = {
      { "<leader>b", "<cmd>BlameToggle virtual<cr>", "Git Blame" }
    },
    init = function()
      require('blame').setup()
    end,
  },
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && npm install',
    ft = 'markdown'
  },
  {
    import = 'custom.plugins.general'
  },
  {
    import = 'custom.plugins.autoformat'
  },
}
