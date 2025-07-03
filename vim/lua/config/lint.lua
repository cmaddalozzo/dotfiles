local M = {}

function M.setup()
  local lint = require('lint')
  lint.linters_by_ft = {
    go = { 'golangcilint' },
    python = { 'flake8', 'mypy', 'pylint' },
    javascript = { 'eslint_d' },
    typescript = { 'eslint_d' },
    lua = { 'luacheck' },
    rust = { 'cargo' },
    sh = { 'shellcheck' },
    json = { 'jsonlint' },
    yaml = { 'yamllint' },
    markdown = { 'vale' },
  }
end

return M
