local M = {}

local function set_terminal_bg(hex)
    local term =
        vim.env.TERM_PROGRAM
        or vim.env.TERM
        or ""

    if not (
        term:match("kitty")
        or term:match("iTerm")
    ) then
        return
    end

    local r =
        tonumber(hex:sub(2, 3), 16)

    local g =
        tonumber(hex:sub(4, 5), 16)

    local b =
        tonumber(hex:sub(6, 7), 16)

    io.write(
        string.format(
            "\27]11;rgb:%02x/%02x/%02x\27\\",
            r,
            g,
            b
        )
    )

    io.flush()
end

local function restore_terminal_bg()
    local term =
        vim.env.TERM_PROGRAM
        or vim.env.TERM
        or ""

    if not (
        term:match("kitty")
        or term:match("iTerm")
    ) then
        return
    end

    io.write("\27]111\27\\")
    io.flush()
end

function M.apply()
    local ok, normal =
        pcall(
            vim.api.nvim_get_hl,
            0,
            {
                name = "Normal",
            }
        )

    if not ok then
        return
    end

    if not normal.bg then
        return
    end

    local hex =
        string.format(
            "#%06x",
            normal.bg
        )

    set_terminal_bg(hex)
end

function M.restore()
    restore_terminal_bg()
end

vim.api.nvim_create_autocmd(
    {
        "VimEnter",
        "ColorScheme",
    },
    {
        callback = M.apply,
    }
)

vim.api.nvim_create_autocmd(
    "VimLeavePre",
    {
        callback = M.restore,
    }
)

return M
