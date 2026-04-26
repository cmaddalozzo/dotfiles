local M = {}

local source_icons = {
  LSP = '󰅩',
  Snippets = '',
  Path = '󰱼',
  Buffer = '󰦨',
}

local kind_icon_overrides = {
  Snippet = "",
  Function = "󰊕",
}

local function get_kind_icon(ctx)
  if ctx.source_name == 'Path' then
    local dev_icon, hl = require('nvim-web-devicons').get_icon(ctx.label)
    if dev_icon then return dev_icon, hl end
  end
  local kind_icon, hl, _ = require('mini.icons').get('lsp', ctx.kind)
  if kind_icon_overrides[ctx.kind] then
    kind_icon = kind_icon_overrides[ctx.kind]
  end
  return kind_icon, hl
end

function M.setup()
  require('blink.cmp').setup(
    {
      keymap = {
        preset = 'enter',
        ['<Tab>'] = { function(cmp)
          if cmp.is_active() then
            cmp.select_next()
          elseif cmp.snippet_active() then
            cmp.snippet_forward()
          end
        end, 'fallback' },
        ['<S-Tab>'] = { function(cmp)
          if cmp.is_active() then
            cmp.select_prev()
          elseif cmp.snippet_active() then
            cmp.snippet_backward()
          end
        end, 'fallback' },
        ['<Esc>'] = { function(cmp)
          if cmp.is_active() then
            cmp.cancel()
            return
          end
        end, 'fallback' },
      },
      completion = {
        list = { selection = { preselect = false, auto_insert = true } },
        documentation = { auto_show = true },
        menu = {
          draw = {
            columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'source_icon' } },
            components = {
              kind_icon = {
                text = function(ctx)
                  local icon, _ = get_kind_icon(ctx)
                  return icon
                end,
                highlight = function(ctx)
                  local _, hl = get_kind_icon(ctx)
                  return hl
                end,
              },
              source_icon = {
                text = function(ctx)
                  return source_icons[ctx.source_name] or ctx.source_name
                end,
              },
            },
          },
        },
      },
      signature = { enabled = true },
    })
end

return M
