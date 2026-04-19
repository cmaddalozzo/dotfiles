local fn = {}

fn.uuid = function()
  local str = string.lower(vim.api.nvim_eval([[system('uuidgen')]]))
  return string.gsub(str, "%s+", "")
end

fn.insert_uuid = function()
  local pos = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()
  local nline = line:sub(0, pos) .. fn.uuid() .. line:sub(pos + 1)
  vim.api.nvim_set_current_line(nline)
end

fn.git_root = function()
  local git_root = vim.fn.system("git rev-parse --show-toplevel")
  if vim.v.shell_error ~= 0 then
    return nil
  end
  return string.gsub(git_root, "%s+", "")
end

fn.paste_xml_block = function()
  local tag = vim.fn.input('XML tag: ')
  if tag == '' then return end
  local clipboard = vim.fn.getreg('+')
  local lines = { '<' .. tag .. '>' }
  for line in clipboard:gmatch('[^\n]+') do
    table.insert(lines, line)
  end
  table.insert(lines, '</' .. tag .. '>')
  vim.api.nvim_put(lines, 'l', false, false)
end

return fn
