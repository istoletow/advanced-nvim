local function set_hl()

    local mode =
        vim.fn.mode()

    local color

    if mode == "n" then
        color = "#98971a"
    elseif mode == "i" then
        color = "#458588"
    elseif mode == "v" then
        color = "#d79921"
    elseif mode == "R" then
        color = "#cc241d"
    else
        color = "#7c6f64"
    end

    vim.api.nvim_set_hl(
        0,
        "StatusLine",
        {
            fg = "#ebdbb2",
            bg = color,
            bold = true,
        }
    )
end

vim.api.nvim_create_autocmd(
    {
        "ModeChanged",
        "VimEnter",
    },
    {
        callback = set_hl,
    }
)
