local nvim_lsp = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

local capabilities = cmp_nvim_lsp.update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

nvim_lsp.pyright.setup{
    capabilities = capabilities
}
nvim_lsp.tsserver.setup{
    capabilities = capabilities
}
nvim_lsp.gopls.setup{
    capabilities = capabilities
}
nvim_lsp.clangd.setup{}
nvim_lsp.jsonls.setup {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
        end
      }
    }
}
nvim_lsp.yamlls.setup{}
nvim_lsp.terraformls.setup{}
nvim_lsp.ansiblels.setup {
  filetypes = { 'yaml.ansible' }
}
nvim_lsp.cssls.setup {
  filetypes = { 'css', 'scss', 'less', 'sass' },
}

local filetypes = {
  typescript = "eslint",
  typescriptreact = "eslint",
}

nvim_lsp.diagnosticls.setup {
    filetypes = vim.tbl_keys(filetypes),
    init_options = {
        filetypes = filetypes,
        linters = linters,
        formatters = formatters,
        formatFiletypes = formatFiletypes
    }
}

local linters = {
  eslint = {
      sourceName = "eslint",
      command = "eslint_d",
      rootPatterns = {".eslintrc.js", "package.json"},
      debounce = 100,
      args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
      parseJson = {
          errorsRoot = "[0].messages",
          line = "line",
          column = "column",
          endLine = "endLine",
          endColumn = "endColumn",
          message = "${message} [${ruleId}]",
          security = "severity"
      },
      securities = {[2] = "error", [1] = "warning"}
  }
}

local formatters = {
  prettier = {command = "prettier", args = {"--stdin-filepath", "%filepath"}}
}

local formatFiletypes = {
  typescript = "prettier",
  typescriptreact = "prettier"
}
