local M = {}
local nls = require "null-ls"
local nls_utils = require "null-ls.utils"
local b = nls.builtins

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gt', vim.lsp.buf.type_definition, '[G]oto [T]ype definition')

  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  jdtls = {
    disabled = true
  },
  clangd = {},
  gopls = {},
  helm_ls = {
    yamlls = {
      path = "yaml-language-server"
    }
  },
  pyright = {},
  rust_analyzer = {},
  terraformls = {},
  ts_ls = {},
  jsonls = {},
  yamlls = {},
  ruff_lsp = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

local with_diagnostics_code = function(builtin)
  return builtin.with {
    diagnostics_format = "#{m} [#{c}]",
  }
end

local with_root_file = function(builtin, file)
  return builtin.with {
    condition = function(utils)
      return utils.root_has_file(file)
    end,
  }
end

local nls_sources = {
  -- formatting
  b.formatting.prettierd,
  b.formatting.shfmt,
  -- b.formatting.isort,
  with_root_file(b.formatting.stylua, "stylua.toml"),
  -- diagnostics
  -- b.diagnostics.write_good,
  -- b.diagnostics.markdownlint,
  -- b.diagnostics.eslint_d,
  -- code actions
  b.code_actions.gitsigns,
  b.code_actions.gitrebase,

  -- hover
  b.hover.dictionary,
}

vim.g.dazzler_has_black = false
if vim.fn.executable('black') == 1 then
  table.insert(nls_sources, b.formatting.black.with { extra_args = { "--fast" } })
  vim.g.dazzler_has_black = true
end

function M.setup()
  -- Setup neovim lua configuration
  require('neodev').setup()

  -- Setup mason so it can manage external tooling
  require('mason').setup()

  mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
  }

  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  mason_lspconfig.setup_handlers {
    function(server_name)
      if not servers[server_name]['disabled'] then
        require('lspconfig')[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
        }
      end
    end,
  }


  nls.setup {
    -- debug = true,
    debounce = 150,
    save_after_format = false,
    sources = nls_sources,
    on_attach = on_attach,
    root_dir = nls_utils.root_pattern ".git",
  }
end

return M
