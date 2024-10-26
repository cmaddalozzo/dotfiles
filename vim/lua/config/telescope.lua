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
  vim.keymap.set('n', telescope_leader .. '/', telescope_builtin.live_grep,
    { desc = 'Live grep' }
  )
  vim.keymap.set('n', telescope_leader .. '*', telescope_builtin.grep_string,
    { desc = 'Grep string' }
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
