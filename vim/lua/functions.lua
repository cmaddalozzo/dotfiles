local fn = {}

fn.uuid = function ()
  str = string.lower(vim.api.nvim_eval([[system('uuidgen')]]))
  return string.gsub(str, "%s+", "")
end

return fn
