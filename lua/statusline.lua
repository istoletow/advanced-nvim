local M = {}

local modes = {
    n = "NORMAL",
    i = "INSERT",
    v = "VISUAL",
    V = "V-LINE",
    ["\22"] = "V-BLOCK",
    c = "COMMAND",
    R = "REPLACE",
    t = "TERMINAL",
}

local function get_mode()
    return modes[vim.fn.mode()] or "UNKNOWN"
end

local function get_git()
    return vim.b.gitsigns_head or "-"
end

local function get_lsp()
    local clients =
        vim.lsp.get_clients({ bufnr = 0 })

    if #clients == 0 then
        return "no-lsp"
    end

    return clients[1].name
end

local function get_diag()
    local err =
        #vim.diagnostic.get(
            0,
            { severity = vim.diagnostic.severity.ERROR }
        )

    local warn =
        #vim.diagnostic.get(
            0,
            { severity = vim.diagnostic.severity.WARN }
        )

    return string.format(
        "E%d W%d",
        err,
        warn
    )
end

local function get_symbol()
    local ok, navic =
        pcall(require, "nvim-navic")

    if not ok then
        return ""
    end

    if not navic.is_available() then
        return ""
    end

    return navic.get_location()
end

function M.render()

    local file =
        vim.fn.expand("%:t")

    if file == "" then
        file = "[No Name]"
    end

    local line =
        vim.fn.line(".")

    local col =
        vim.fn.col(".")

    local percent =
        math.floor(
            line
            /
            vim.fn.line("$")
            * 100
        )

    local left =
        string.format(
            " %s │ %s │ %s ",
            get_mode(),
            file,
            get_git()
        )

    local center =
        get_symbol()

    local right =
        string.format(
            " %s │ %s │ %s │ %s │ %d%% ",
            get_lsp(),
            get_diag(),
            vim.bo.fileencoding ~= ""
                and vim.bo.fileencoding
                or "utf-8",
            vim.bo.filetype,
            percent
        )

    return left
        .. "%="
        .. center
        .. "%="
        .. right
        .. string.format(
            " │ Ln%d:%d ",
            line,
            col
        )
end

_G.Statusline = M

return M
