local M = {}

function M.setup()
  vim.filetype.add(({
    filename = {
      ['Jenkinsfile'] = 'lua',
    },
    extension = {
      tf = 'terraform',
    }
  }))
end

return M
