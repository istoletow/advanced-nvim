local dap = require("dap")

dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = { "--interpreter=dap", "--quiet" },
}

dap.configurations.cpp = {
    {
        name = "Launch",

        type = "gdb",

        request = "launch",

        program = function()
            return vim.fn.input(
                "Executable: ",
                vim.fn.getcwd() .. "/",
                "file"
            )
        end,

        cwd = "${workspaceFolder}",

        stopOnEntry = false,
    },
}

dap.configurations.c =
    dap.configurations.cpp
