local M = {}

function M.setup()
  -- nvim-cmp setup
  local cmp = require 'cmp'
  local luasnip = require 'luasnip'

  luasnip.config.setup {}

  require("luasnip.loaders.from_vscode").lazy_load()

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<Down>'] = {
        i = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      },
      ['<Up>'] = {
        i = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      },
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete {},
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ['<C-e>'] = {
        i = cmp.mapping.abort(),
      },
      ['<C-a>'] = {
        i = cmp.mapping.complete(),
      },
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'path' }
    },
  }
end

return M
