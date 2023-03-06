-- Alpha start screen / dashboard
require("alpha").setup(require("alpha.themes.dashboard").config)
require("alpha.themes.dashboard").section.footer.val = require("alpha.fortune")() -- Quotes
