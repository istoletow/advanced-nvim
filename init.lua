
-- require("config.dap")
require("statusline")
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
-- require("config.statusline_colors")
require("tabline")
require("config.terminal_bg")

vim.o.showtabline = 2
vim.o.tabline =
    "%!v:lua.Tabline.render()"


vim.o.statusline =
"%!v:lua.Statusline.render()"


