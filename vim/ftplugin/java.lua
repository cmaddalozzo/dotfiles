-- vim.lsp.set_log_level('TRACE')
local mason_registry = require('mason-registry')
local config = {
  cmd = {
    mason_registry.get_package('jdtls'):get_install_path() .. '/bin/jdtls',
    '--data',
    vim.loop.os_homedir() .. '/.cache/jdtls/workspace',
  },
  root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
}
require('jdtls').start_or_attach(config)
require('jdtls').start_or_attach(config)
