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
    local _augroups = {}
    local get_augroup = function(client)
      if not _augroups[client.id] then
        local group_name = 'dazzler-lsp-format-' .. client.name
        local id = vim.api.nvim_create_augroup(group_name, { clear = true })
        _augroups[client.id] = id
      end

      return _augroups[client.id]
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
        if not client.server_capabilities.documentFormattingProvider then
          return
        end

        -- Use black if it's present (i.e. don't attach ruff)
        if client.name == "ruff_lsp" and vim.g.dazzler_has_black then
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
            require('lint').try_lint()

            vim.lsp.buf.format {
              async = false,
              filter = function(c)
                return c.id == client.id
              end,
            }
            -- If ruff, run the organizeImports code action
            if client.name == "ruff_lsp" then
              vim.lsp.buf.code_action {
                apply = true,
                context = { only = { 'source.organizeImports' } },
              }
            end
          end,
        })
      end,
    })
  end,
}
