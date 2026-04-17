local M = {}

local gh = function(repo)
  return 'https://github.com/' .. repo
end

local plugins = {
  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    function()
      require("onedark").setup({
        style = "warmer"
      })
      require("onedark").load()
    end,
  },
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    {
      'nvim-tree/nvim-web-devicons',
    },
    function()
      require('lualine').setup({
        options = {
          icons_enabled = true,
          theme = 'onedark',
          component_separators = '|',
          section_separators = '',
        },
        sections = {
          lualine_c = { { 'filename', path = 3 } },
          lualine_x = { 'filetype', {
            'lsp_status',
            ignore_lsp = { 'GitHub Copilot' },
          }
          },
        }
      })
    end
  },
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  -- Add useful hotkey for operation with surroundings
  -- cs{what}{towhat} - inside '' or [] or something like this allow
  -- change surroundings symbols to another
  -- and ds{what} - remove them
  'tpope/vim-surround',
  -- Smart matching of pairs e.g vv
  'gorkunov/smartpairs.vim',
  {
    -- Auto-close brackets, quotes, and other pairs
    'windwp/nvim-autopairs',
    function()
      require("nvim-autopairs").setup({})
    end
  },
  {
    -- Display indent guides
    'lukas-reineke/indent-blankline.nvim',
    function()
      require('ibl').setup()
    end
  },
  -- Highlight other uses of the word under cursor
  'RRethy/vim-illuminate',
  {
    -- File explorer as a buffer
    'stevearc/oil.nvim',
    { 'echasnovski/mini.icons' },
    function()
      require('oil').setup({
        keymaps = {
          ["q"] = "actions.close",
        }
      })
    end
  },
  -- Seamless navigation between vim and tmux panes
  'christoomey/vim-tmux-navigator',
  {
    -- Lua LSP setup for Neovim config development
    'folke/lazydev.nvim',
    function()
      require('lazydev').setup({})
    end
  },
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    function()
      require('config.treesitter').setup()
    end,
  },
  {
    -- LSP configuration and setup
    'neovim/nvim-lspconfig',
    function()
      require('config.lsp').setup()
      require('config.autoformat').setup()
    end,
    {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      -- Useful status updates for LSP
      'j-hui/fidget.nvim',
      'RRethy/vim-illuminate',
      'towolf/vim-helm',
      'mfussenegger/nvim-jdtls',
    }
  },
  {
    -- Code formatting on demand
    'mhartington/formatter.nvim',
    function()
      require("formatter").setup({
        -- All formatter configurations are opt-in
        filetype = {
          -- Formatter configurations for filetype "lua" go here
          -- and will be executed in order
          markdown = {
            require("formatter.filetypes.markdown").prettier,
          },
        },
      })
    end,
  },
  {
    -- Debug Adapter Protocol client
    'mfussenegger/nvim-dap',
    {
      "theHamsta/nvim-dap-virtual-text",
    },
    function()
      local dap = require('dap')
      dap.listeners.before['event_initialized']['dazzler'] = function(_)
        require("nvim-dap-virtual-text").setup({})
        local dapui = require("dapui")
        dapui.open()
        vim.keymap.set('n', '<localleader>d', dapui.toggle, {
          desc = "Open [d]ebug UI"
        })
      end
      dap.listeners.before['event_terminate']['dazzler'] = function(_)
        local dapui = require("dapui")
        dapui.close()
      end
    end,
  },
  {
    -- UI for nvim-dap with Go support
    "rcarriga/nvim-dap-ui",
    {
      "nvim-neotest/nvim-nio",
      "leoluz/nvim-dap-go",
    },
    function()
      require("dapui").setup()
      require("dap-go").setup()
    end
  },
  {
    -- GitHub Copilot inline suggestions
    "github/copilot.vim",
    function()
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
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    function()
      require('config.completion').setup()
    end,
    {
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
    -- Async linting engine
    'mfussenegger/nvim-lint',
    function()
      require('config.lint').setup()
    end,
  },
  {
    -- Inline git blame
    "FabijanZulj/blame.nvim",
    function()
      require('blame').setup {}
      vim.keymap.set('n', '<leader>b', '<cmd>BlameToggle virtual<cr>', {
        desc = 'Git Blame'
      })
    end,
  },
  {
    -- Magit-style git interface
    "NeogitOrg/neogit",
    {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    function()
      require('neogit').setup {}
      vim.keymap.set('n', '<leader>g', "<cmd>Neogit<cr>", {
        desc = 'neogit'
      })
    end,
  },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    function()
      require('gitsigns').setup({
        -- See `:help gitsigns.txt`
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
      })
    end,
  },
  {
    -- Fuzzy finder powered by fzf
    "ibhagwan/fzf-lua",
    {
      "nvim-tree/nvim-web-devicons"
    },
    require('config.fuzzyfinder').setup
  },
  {
    -- Display available keybindings in a popup
    'folke/which-key.nvim',
    function()
      require('which-key').setup({})
    end
  },
}

function M.setup()
  local inits_fns = {}
  local pack_plugins = {}

  vim.iter(plugins):flatten(99):each(function(x)
    if vim.is_callable(x) then
      table.insert(inits_fns, x)
    else
      table.insert(pack_plugins, gh(x))
    end
  end)
  vim.pack.add(pack_plugins)
  vim.iter(inits_fns):each(function(f) f() end)
end

return M
