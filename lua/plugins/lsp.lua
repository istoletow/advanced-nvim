return {
    {
        "williamboman/mason.nvim",
        opts = {},
    },

    {
        "williamboman/mason-lspconfig.nvim",

        dependencies = {
            "williamboman/mason.nvim",
        },

        opts = {
            ensure_installed = {
                "clangd",
                "lua_ls",
            },
        },
    },

    {
        "neovim/nvim-lspconfig",

        dependencies = {
            "saghen/blink.cmp",
            "SmiteshP/nvim-navic",
        },

        config = function()
            local capabilities =
                require("blink.cmp")
                .get_lsp_capabilities()

            local navic =
                require("nvim-navic")

            vim.diagnostic.config({
                virtual_text = {
                    spacing = 4,
                    source = "if_many",
                },

                signs = true,

                underline = true,

                update_in_insert = false,

                severity_sort = true,

                float = {
                    border = "rounded",
                    source = "always",
                },
            })

            vim.fn.sign_define(
                "DiagnosticSignError",
                {
                    text = "E ",
                    texthl = "DiagnosticSignError",
                }
            )

            vim.fn.sign_define(
                "DiagnosticSignWarn",
                {
                    text = "W ",
                    texthl = "DiagnosticSignWarn",
                }
            )

            vim.fn.sign_define(
                "DiagnosticSignHint",
                {
                    text = "H ",
                    texthl = "DiagnosticSignHint",
                }
            )

            vim.fn.sign_define(
                "DiagnosticSignInfo",
                {
                    text = "I ",
                    texthl = "DiagnosticSignInfo",
                }
            )

            vim.lsp.handlers["textDocument/hover"] =
                vim.lsp.with(
                    vim.lsp.handlers.hover,
                    {
                        border = "rounded",
                    }
                )

            vim.lsp.config("clangd", {
                capabilities = capabilities,

                on_attach = function(client, bufnr)
                    if client.server_capabilities.documentSymbolProvider then
                        navic.attach(client, bufnr)
                    end
                end,

                cmd = {
                    "clangd",

                    "--background-index",
                    "--clang-tidy",

                    "--completion-style=detailed",

                    "--header-insertion=iwyu",

                    "--function-arg-placeholders",

                    "--fallback-style=llvm",

                    "--all-scopes-completion",

                    "--cross-file-rename",

                    "--pch-storage=memory",
                },
            })

            vim.lsp.config("lua_ls", {
                capabilities = capabilities,

                on_attach = function(client, bufnr)
                    if client.server_capabilities.documentSymbolProvider then
                        navic.attach(client, bufnr)
                    end
                end,
            })

            vim.lsp.enable("clangd")
            vim.lsp.enable("lua_ls")

            vim.lsp.inlay_hint.enable(true)

            local map = vim.keymap.set

            map("n", "gd", vim.lsp.buf.definition)
            map("n", "gD", vim.lsp.buf.declaration)

            map("n", "gr", vim.lsp.buf.references)
            map("n", "gi", vim.lsp.buf.implementation)

            map("n", "K", vim.lsp.buf.hover)

            map("n", "<leader>rn", vim.lsp.buf.rename)
            map("n", "<leader>ca", vim.lsp.buf.code_action)

            map("n", "<leader>f", function()
                vim.lsp.buf.format({
                    async = true,
                })
            end)

            map("n", "<leader>d", vim.diagnostic.open_float)

            map("n", "]d", vim.diagnostic.goto_next)
            map("n", "[d", vim.diagnostic.goto_prev)

            map("n", "<leader>ds", vim.lsp.buf.document_symbol)
            map("n", "<leader>ws", vim.lsp.buf.workspace_symbol)

            map("n", "<leader>ih", function()
                vim.lsp.inlay_hint.enable(
                    not vim.lsp.inlay_hint.is_enabled()
                )
            end)
        end,
    },
}
