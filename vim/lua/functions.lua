local fn = {}


fn.uuid = function()
  str = string.lower(vim.api.nvim_eval([[system('uuidgen')]]))
  return string.gsub(str, "%s+", "")
end

fn.insert_uuid = function()
  local pos = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()
  local nline = line:sub(0, pos) .. fn.uuid() .. line:sub(pos + 1)
  vim.api.nvim_set_current_line(nline)
end

return fn
