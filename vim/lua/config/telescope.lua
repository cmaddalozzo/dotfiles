local M = {}
-- [[ Configure Telescope ]]
function M.setup()
  -- See `:help telescope` and `:help telescope.setup()`
  require('telescope').setup {
    defaults = {
      mappings = {
        i = {
          ['<C-u>'] = false,
          ['<C-d>'] = false,
        },
      },
    },
  }

  -- Enable telescope fzf native, if installed
  pcall(require('telescope').load_extension, 'fzf')

  local telescope_leader = '<space>'
  local telescope_builtin = require('telescope.builtin')

  vim.keymap.set('n', telescope_leader .. '<space>', telescope_builtin.find_files,
    { desc = 'Find files' })
  vim.keymap.set('n', telescope_leader .. 'm', telescope_builtin.oldfiles,
    { desc = 'Recent files' })
  vim.keymap.set('n', telescope_leader .. 'b', telescope_builtin.buffers,
    { desc = 'Search [b]uffers' })
  vim.keymap.set('n', telescope_leader .. 'r', function()
    require('telescope').extensions.file_browser.file_browser({
      path = vim.api.nvim_exec("echo expand('%:p:h')", true),
      hidden = true
    })
  end, { desc = 'Search [r]elative' })
  vim.keymap.set('n', telescope_leader .. 'p', function()
    require('fzf-lua').files({
      fd_opts = "-t d -d 1",
      previewer = false,
      actions = {
        enter = function(path)
          telescope_builtin.live_grep({ cwd = require('fzf-lua.path').entry_to_file(path[1]).path })
        end
      }
    })
  end, { desc = 'Search in [p]ath' })
  vim.keymap.set('n', telescope_leader .. '/', telescope_builtin.live_grep,
    { desc = 'Live grep' }
  )
  vim.keymap.set('n', telescope_leader .. '*', telescope_builtin.grep_string,
    { desc = 'Grep string' }
  )
  vim.keymap.set('n', telescope_leader .. 'g', telescope_builtin.git_status,
    { desc = 'Browse [g]it status' }
  )
  vim.keymap.set('n', telescope_leader .. 'k', telescope_builtin.keymaps,
    { desc = 'Search [k]eymaps' }
  )
  vim.keymap.set('n', telescope_leader .. 's', telescope_builtin.lsp_document_symbols,
    { desc = 'Search document [s]ymbols' }
  )
  vim.keymap.set('n', telescope_leader .. 'S', telescope_builtin.lsp_dynamic_workspace_symbols,
    { desc = 'Search workspace [S]ymbols' }
  )
  vim.keymap.set('n', telescope_leader .. 't', telescope_builtin.builtin,
    { desc = 'Search [t]elescope builtins' }
  )
  vim.keymap.set('n', telescope_leader .. ';', telescope_builtin.commands,
    { desc = 'Search commands[;]' }
  )
  vim.keymap.set('n', telescope_leader .. 'h', telescope_builtin.help_tags,
    { desc = 'Get [h]elp' }
  )
  vim.keymap.set('n', telescope_leader .. 'f', require('telescope').extensions.file_browser.file_browser,
    { desc = 'Browse [f]iles' }
  )
  vim.keymap.set('n', '<leader>s', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = 'Fuzzily [s]earch in current buffer' })
  vim.keymap.set('n', telescope_leader .. 'c', function()
    require('telescope.builtin').find_files({ follow = true, search_dirs = { vim.fn.stdpath('config') } })
  end, { desc = 'Search [c]onfig' })
end

return M
