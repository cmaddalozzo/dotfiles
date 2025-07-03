-- autoformat.lua
--
-- Use language server to automatically format code on save.
-- Adds additional commands as well to manage the behavior

return {
  'neovim/nvim-lspconfig',
  config = function()
    -- Switch for controlling whether we want autoformatting.
    --  Use :DazzlerFormatToggle to toggle autoformatting on or off
    local format_is_enabled = true
    vim.api.nvim_create_user_command('DazzlerFormatToggle', function()
      format_is_enabled = not format_is_enabled
      print('Setting autoformatting to: ' .. tostring(format_is_enabled))
    end, {})

    -- Create an augroup that is used for managing our formatting autocmds.
    --      We need one augroup per client to make sure that multiple clients
    --      can attach to the same buffer without interfering with each other.
    local _augroups = {} --- @type table<integer, integer>
    --- @param client (vim.lsp.Client) client rpc object
    --- @return integer # Integer id of the created group.
    local get_augroup = function(client)
      if not _augroups[client.id] then
        local group_name = 'dazzler-lsp-format-' .. client.name
        local id = vim.api.nvim_create_augroup(group_name, { clear = true })
        _augroups[client.id] = id
      end

      return _augroups[client.id]
    end

    --- @param client (vim.lsp.Client) client rpc object
    --- @param action (lsp.CodeActionKind) client rpc object
    --- @return boolean # Integer id of the created group.
    local has_code_action = function(client, action)
      if not client.server_capabilities.codeActionProvider then
        return false
      end
      if type(client.server_capabilities.codeActionProvider) ~= "table" then
        return false
      end
      for _, v in pairs(client.server_capabilities.codeActionProvider.codeActionKinds) do
        if v == action then
          return true
        end
      end
      return false
    end

    -- Whenever an LSP attaches to a buffer, we will run this function.
    --
    -- See `:help LspAttach` for more information about this autocmd event.
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('dazzler-lsp-attach-format', { clear = true }),
      -- This is where we attach the autoformatting for reasonable clients
      callback = function(args)
        local client_id = args.data.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        local bufnr = args.buf
        -- Only attach to clients that support document formatting
        if client == nil or not client.server_capabilities.documentFormattingProvider then
          return
        end

        -- Create an autocmd that will run *before* we save the buffer.
        --  Run the formatting command for the LSP that has just attached.
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = get_augroup(client),
          buffer = bufnr,
          callback = function()
            if not format_is_enabled then
              return
            end

            vim.lsp.buf.format {
              async = false,
              filter = function(c)
                return c.id == client.id
              end,
            }

            if has_code_action(client, "source.organizeImports") then
              vim.lsp.buf.code_action {
                apply = true,
                context = { only = { 'source.organizeImports' } },
              }
            end
            require('lint').try_lint()
            require('lint').try_lint("typos")
          end,
        })
      end,
    })
  end,
}
