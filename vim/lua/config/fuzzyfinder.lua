local M = {}
-- [[ Configure Telescope ]]
function M.setup()
  local fuzzy_leader = '<space>'
  local fzf = require("fzf-lua")

  fzf.setup({
    keymap = {
      fzf = {
        ["ctrl-a"] = "toggle-all",
        ["ctrl-q"] = "select-all+accept",
      }
    },
    actions = {
      files = {
        true,
      }
    }
  })

  fzf.register_ui_select()

  vim.keymap.set('n', fuzzy_leader .. '<space>', fzf.global,
    { desc = 'Find files' })
  vim.keymap.set('n', fuzzy_leader .. 'm', function() fzf.oldfiles({ cwd = vim.fn.getcwd() }) end,
    { desc = 'Recent files' })
  vim.keymap.set('n', fuzzy_leader .. 'b', fzf.buffers,
    { desc = 'Search [b]uffers' })
  vim.keymap.set('n', fuzzy_leader .. 'r', function()
    require('oil').open(vim.fn.expand('%:p:h'))
  end, { desc = 'Find [r]elative' })
  vim.keymap.set('n', fuzzy_leader .. 'p', function()
    require('fzf-lua').files({
      fd_opts = "-t d -d 1",
      previewer = false,
      hidden = true,
      actions = {
        enter = function(paths)
          local search_dirs = {}
          local pathlib = require('fzf-lua.path')
          for _, p in pairs(paths) do
            table.insert(search_dirs, pathlib.entry_to_file(p).path)
          end
          fzf.live_grep({ search_paths = search_dirs })
        end
      }
    })
  end, { desc = 'Search in [p]ath' })
  vim.keymap.set('n', fuzzy_leader .. '/', fzf.live_grep,
    { desc = 'Live grep' }
  )
  vim.keymap.set('n', fuzzy_leader .. '*', fzf.grep_cword,
    { desc = 'Grep string' }
  )
  vim.keymap.set('n', fuzzy_leader .. 'g', fzf.git_status,
    { desc = 'Browse [g]it status' }
  )
  vim.keymap.set('n', fuzzy_leader .. 'k', fzf.keymaps,
    { desc = 'Search [k]eymaps' }
  )
  vim.keymap.set('n', fuzzy_leader .. 's', fzf.lsp_document_symbols,
    { desc = 'Search document [s]ymbols' }
  )
  vim.keymap.set('n', fuzzy_leader .. 'S', fzf.lsp_live_workspace_symbols,
    { desc = 'Search workspace [S]ymbols' }
  )
  vim.keymap.set('n', fuzzy_leader .. 't', fzf.builtin,
    { desc = 'Search [t]elescope builtins' }
  )
  vim.keymap.set('n', fuzzy_leader .. ';', fzf.commands,
    { desc = 'Search commands[;]' }
  )
  vim.keymap.set('n', fuzzy_leader .. '"', fzf.registers,
    { desc = 'Search registers["]' }
  )
  vim.keymap.set('n', fuzzy_leader .. 'h', fzf.helptags,
    { desc = 'Get [h]elp' }
  )
  vim.keymap.set('n', fuzzy_leader .. 'c', function()
    fzf.files({ cwd = vim.fn.stdpath('config'), follow = true })
  end, { desc = 'Search [c]onfig' })
  vim.keymap.set('n', fuzzy_leader .. 'q', fzf.quickfix, { desc = 'Search [q]uickfix' })
  vim.keymap.set('n', fuzzy_leader .. 'Q', fzf.quickfix_stack, { desc = 'Search [Q]uickfix stack' })
end

return M
