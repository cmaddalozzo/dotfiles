local M = {}

function M.setup()
  -- nvim-cmp setup
  local cmp = require 'cmp'
  local luasnip = require 'luasnip'
  local lspkind = require 'lspkind'
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')

  require('lazydev').setup()

  luasnip.config.setup {}

  require("luasnip.loaders.from_vscode").lazy_load()

  local source_to_menu = {
    nvim_lsp = '',
    luasnip = '',
    path = '󰱼',
    buffer = '󰦨',
  }

  local lsp_kind_format = lspkind.cmp_format({
    mode = 'symbol',
  })
  cmp.setup {
    formatting = {
      format = function(entry, vim_item)
        vim_item.menu = (source_to_menu[entry.source.name] ~= nil and source_to_menu[entry.source.name]
          or entry.source.name)
        return lsp_kind_format(entry, vim_item)
      end,
    },
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
      { name = 'path' },
      { name = 'buffer' },
      { name = 'lazydev', group_index = 0 },
    },
  }
  -- Add `(` after selecting a function or method
  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
  )
end

return M
