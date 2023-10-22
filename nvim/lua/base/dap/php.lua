local M = {}

function M.setup()
    local dap = require("dap")
    -- see https://github.com/xdebug/vscode-php-debug#installation for xdebug installation
    dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath("data") .. "/lazy/vscode-php-debug/out/phpDebug.js" },
    }

    dap.configurations.php = {
        {
            type = "php",
            request = "launch",
            name = "Listen for Xdebug",
            port = 9003,
        },
    }
end

return M
