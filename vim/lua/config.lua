local actions = require('telescope.actions')
local nvim_lsp = require('lspconfig')

require('telescope').setup{
  defaults = {
    prompt_prefix = "🔎 ",
    selection_caret = "> ",
    mappings = {
      i = {
        ["<c-k>"] = actions.move_selection_previous,
        ["<c-j>"] = actions.move_selection_next,
      }
    }
  }
}

nvim_lsp.pyright.setup{}
nvim_lsp.tsserver.setup{}
nvim_lsp.gopls.setup{}
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


require("trouble").setup {}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}

local filetypes = {
  typescript = "eslint",
  typescriptreact = "eslint",
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

nvim_lsp.diagnosticls.setup {
    on_attach = on_attach,
    filetypes = vim.tbl_keys(filetypes),
    init_options = {
        filetypes = filetypes,
        linters = linters,
        formatters = formatters,
        formatFiletypes = formatFiletypes
    }
}
