local M = {}

local languages = {
  'c', 'cpp', 'go', 'lua', 'python', 'rust',
  'tsx', 'typescript', 'vim', 'java', 'terraform',
  'vimdoc', 'luadoc', 'markdown', 'html'
}

local no_indent = { python = true }

function M.setup()
  local ts = require('nvim-treesitter')
  ts.install(languages)

  vim.api.nvim_create_autocmd('FileType', {
    pattern = languages,
    callback = function(ev)
      vim.treesitter.start()
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo.foldmethod = 'expr'
      if not no_indent[ev.match] then
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end,
  })
end

return M
