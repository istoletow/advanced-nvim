vim.g.mapleader = " "

local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.termguicolors = true

opt.mouse = "a"

opt.clipboard = "unnamedplus"

opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

opt.smartindent = true

opt.wrap = false

opt.cursorline = true

opt.splitbelow = true
opt.splitright = true

opt.ignorecase = true
opt.smartcase = true

opt.scrolloff = 10

opt.updatetime = 100

-- opt.signcolumn = "yes"

opt.completeopt = {
    "menu",
    "menuone",
    "noselect",
}

opt.list = true

opt.listchars = {
    tab = "→ ",
    trail = "·",
    nbsp = "␣",
    extends = "»",
    precedes = "«",
    eol = "↲",
}

opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

vim.opt.termguicolors = true

vim.opt.cursorline = true

vim.opt.number = true
vim.opt.relativenumber = true

-- vim.opt.signcolumn = "yes"

vim.opt.colorcolumn = "100"

vim.api.nvim_set_hl(
    0,
    "ColorColumn",
    {
        bg = "#32302f",
    }
)
