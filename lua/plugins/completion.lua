return {

    {
        "saghen/blink.cmp",

        dependencies = {
            "rafamadriz/friendly-snippets",
        },

        version = "*",

        opts = {

            keymap = {
                preset = "default",

                ["<CR>"] = {
                    "accept",
                    "fallback",
                },

                ["<Tab>"] = {
                    "select_next",
                    "fallback",
                },

                ["<S-Tab>"] = {
                    "select_prev",
                    "fallback",
                },
            },

            appearance = {
                nerd_font_variant = "mono",
            },

            completion = {
                documentation = {
                    auto_show = true,
                },
            },

            sources = {
                default = {
                    "lsp",
                    "path",
                    "snippets",
                    "buffer",
                },
            },
        },
    },
}
