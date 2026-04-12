local M = {}

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
  nmap('gr', require('fzf-lua').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gt', vim.lsp.buf.type_definition, '[G]oto [T]ype definition')

  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
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
    disabled = false
  },
  clangd = {},
  gopls = {
    disabled = vim.fn.executable('go') == 0,
    gopls = {
      buildFlags = { '-tags=integration test_extproc' },
    },
  },
  helm_ls = {
    yamlls = {
      path = "yaml-language-server"
    }
  },
  pyright = {},
  rust_analyzer = {},
  terraformls = {},
  -- ts_ls = {},
  jsonls = {},
  yamlls = {},
  -- ruff_lsp = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = {
        globals = { "vim" }
      }
    },
  },
}

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

function M.setup()
  -- Setup neovim lua configuration

  -- Setup mason so it can manage external tooling
  require('mason').setup()

  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
  -- Add fold support
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  local ensure_installed = {}
  for name, config in pairs(servers) do
    if not config['disabled'] then
      table.insert(ensure_installed, name)
      vim.lsp.config(name, {
        settings = config,
        on_attach = on_attach,
        capabilities = capabilities
      })
      vim.lsp.enable(name)
    end
  end

  mason_lspconfig.setup {
    ensure_installed = ensure_installed,
  }
end

return M
