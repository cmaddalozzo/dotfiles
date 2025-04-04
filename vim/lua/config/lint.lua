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
  }
  -- Make args compatible with golangci-lint v2.x
  local args = {
    'run',
    '--output.json.path=stdout',
    '--issues-exit-code=0',
    '--show-stats=false',
    '--output.text.print-issued-lines=false',
    '--output.text.print-linter-name=false',
  }
  -- Use the golangci.yaml file in the git root if it exists
  local config_file = vim.fn.expand('~/.config/golangci-lint/.golangci.yml')
  local stat = vim.loop.fs_stat(config_file)
  if stat then
    table.insert(args, '--config')
    table.insert(args, config_file)
  end
  table.insert(args,
    function()
      return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
    end
  )
  lint.linters.golangcilint.args = args
end

return M
