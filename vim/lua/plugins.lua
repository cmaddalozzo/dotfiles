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
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  'RRethy/vim-illuminate',
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    opts = {},
    init = function()
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
  },
  {
    'leoluz/nvim-dap-go',
    ft = "go",
  },
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
      'RRethy/vim-illuminate',
      'towolf/vim-helm',
      'mfussenegger/nvim-jdtls',
    }
  },
  {
    'mfussenegger/nvim-dap',
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
  },
  {
    'mfussenegger/nvim-lint',
    init = function()
      require('config.lint').setup()
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    }
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    init = function()
      require('config.completion').setup()
    end,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
      'onsails/lspkind.nvim',
    },
  },
  {
    "github/copilot.vim",
    init = function()
      vim.keymap.set('i', '<C-j>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false
      })
      vim.keymap.set('i', '<C-l>', '<Plug>(copilot-accept-word)')
      vim.keymap.set('i', '<C-n>', '<Plug>(copilot-next)')
      vim.keymap.set('i', '<C-p>', '<Plug>(copilot-previous)')
      vim.g.copilot_no_tab_map = true
    end
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
    lazy = false,
    priority = 1000,
    config = function()
      require("onedark").setup({
        style = "warmer"
      })
      require("onedark").load()
    end,
  },
  -- {
  --   -- Theme inspired by Atom
  --   'EdenEast/nightfox.nvim',
  --   priority = 1000,
  --   config = function()
  --     -- vim.cmd.colorscheme 'nightfox'
  --   end,
  -- },

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
    enabled = false,
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
  {
    'stevearc/oil.nvim',
    opts = {},
    config = true,
    dependencies = { 'echasnovski/mini.icons' },
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
  -- Telescope file browser
  {
    'nvim-telescope/telescope-file-browser.nvim',
    version = '*',
    dependencies = { 'nvim-telescope/telescope.nvim' }
  },
  -- Telescope undo
  {
    "debugloop/telescope-undo.nvim",
    dependencies = { -- note how they're inverted to above example
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    keys = {
      { -- lazy style key map
        "<space>u",
        "<cmd>Telescope undo<cr>",
        desc = "Show [u]ndo tree",
      },
    },
    opts = {
      -- don't use `defaults = { }` here, do this in the main telescope spec
      extensions = {
        undo = {
          -- telescope-undo.nvim config, see below
        },
        -- no other extensions here, they can have their own spec too
      },
    },
    config = function(_, opts)
      -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
      -- configs for us. We won't use data, as everything is in it's own namespace (telescope
      -- defaults, as well as each extension).
      require("telescope").setup(opts)
      require("telescope").load_extension("undo")
    end,
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
    keys = {
      { "<leader>g", "<cmd>Neogit<cr>", "neogit" }
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
