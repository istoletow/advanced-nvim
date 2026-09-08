return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,

        config = function()
            local theme_file = vim.fn.stdpath("data") .. "/last_colorscheme"

            local file = io.open(theme_file, "r")
            if file then
                local theme = file:read("*l")
                file:close()

                if theme and theme ~= "" then
                    pcall(vim.cmd.colorscheme, theme)
                end
            end

            vim.api.nvim_create_autocmd("ColorScheme", {
                callback = function()
                    local current = vim.g.colors_name

                    if current then
                        local f = io.open(theme_file, "w")
                        if f then
                            f:write(current)
                            f:close()
                        end
                    end
                end,
            })
        end,
    },
}
