return {
    {
        "ellisonleao/gruvbox.nvim",

        priority = 1000,

        config = function()
            require("gruvbox").setup({
                terminal_colors = true,

                contrast = "hard",

                transparent_mode = false,

                italic = {
                    strings = false,
                    comments = true,
                    operators = false,
                    folds = true,
                },

                overrides = {
                    StatusLine = {
                        fg = "#ebdbb2",
                        bg = "#3c3836",
                        bold = true,
                    },

                    CursorLineNr = {
                        fg = "#fabd2f",
                        bold = true,
                    },

                    DiagnosticVirtualTextError = {
                        fg = "#fb4934",
                    },

                    DiagnosticVirtualTextWarn = {
                        fg = "#fabd2f",
                    },
                },
            })

            vim.cmd.colorscheme("gruvbox")
        end,
    },
}
