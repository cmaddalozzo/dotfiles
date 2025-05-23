local M = {}
-- [[ Configure Treesitter ]]
function M.setup()
  -- [[ configure treesitter ]]
  -- see `:help nvim-treesitter`
  require('nvim-treesitter.configs').setup {
    -- add languages to be installed here
    ensure_installed = {
      'c',
      'cpp',
      'go',
      'lua',
      'python',
      'rust',
      'tsx',
      'typescript',
      'help',
      'vim',
      'java',
      'terraform',
      'vimdoc',
      'luadoc',
      'markdown',
    },
    -- autoinstall languages that are not installed.
    auto_install = false,
    ignore_install = { "help" },
    highlight = { enable = true },
    indent = { enable = true, disable = { 'python' } },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<m-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- you can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']m'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[m'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>a'] = '@parameter.inner',
        },
      },
    },
  }
end

return M
