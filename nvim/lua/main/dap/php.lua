local M = {}

function M.setup()
  local dap = require "dap"
  dap.adapters.php = {
       type = 'executable',
       command = 'node',
       args = { '/Users/yferlin/.config/nvim/vscode-php-debug/out/phpDebug.js' }
  }

  dap.configurations.php = {
    {
       type = 'php',
       request = 'launch',
       name = 'Listen for Xdebug',
       port = 9003
    }
  }

end

return M