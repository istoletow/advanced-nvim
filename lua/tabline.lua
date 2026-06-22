local M = {}

function M.render()

    local s = ""

    local current =
        vim.api.nvim_get_current_buf()

    for _, buf in ipairs(
        vim.api.nvim_list_bufs()
    ) do

        if vim.fn.buflisted(buf) == 1 then

            local name =
                vim.fn.fnamemodify(
                    vim.api.nvim_buf_get_name(buf),
                    ":t"
                )

            if name == "" then
                name = "[No Name]"
            end

            local modified =
                vim.bo[buf].modified
                    and " ●"
                    or ""

            if buf == current then

                s = s
                    .. "%#TabLineSel#"
                    .. string.format(
                        " [%d:%s%s] ",
                        buf,
                        name,
                        modified
                    )

            else

                s = s
                    .. "%#TabLine#"
                    .. string.format(
                        " %d:%s%s ",
                        buf,
                        name,
                        modified
                    )
            end
        end
    end

    return s
end

_G.Tabline = M

return M
