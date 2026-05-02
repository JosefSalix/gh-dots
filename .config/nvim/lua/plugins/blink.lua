return {
    -- Pomocny plugin pro kompatibilitu se starsimi zdroji
    {
        "saghen/blink.compat",
        version = "*",
        lazy = true,
        opts = {},
    },
    {
        "saghen/blink.cmp",
        -- Zdroje pro naseptavani (snippets, emoji, sql)
        dependencies = {
            "rafamadriz/friendly-snippets",
            "moyiz/blink-emoji.nvim",
            "ray-x/cmp-sql",
        },

        version = "1.*",

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- Nastaveni klaves pro naseptavac
            keymap = {
                preset = "default",
                -- Potvrzeni vyberu pomoci Ctrl + y
                ["<C-y>"] = { "accept", "fallback" },
            },

            appearance = {
                -- Nastaveni ikon (vyuziva Nerd Font)
                nerd_font_variant = "mono",
            },

            -- Automaticky ukázat dokumentaci k vybrané funkci
            completion = { documentation = { auto_show = true } },
            
            -- Napoveda pro argumenty funkci (signature help)
            signature = { enabled = true },

            -- Odkud ma Blink brat data
            sources = {
                default = { "lsp", "path", "snippets", "buffer", "emoji", "sql" },
                providers = {
                    emoji = {
                        module = "blink-emoji",
                        name = "Emoji",
                        score_offset = 15,
                        opts = { insert = true },
                        should_show_items = function()
                            -- Emoji jen v gitu a markdownu
                            return vim.tbl_contains({ "gitcommit", "markdown" }, vim.o.filetype)
                        end,
                    },
                    sql = {
                        name = "sql",
                        module = "blink.compat.source",
                        score_offset = -3,
                        should_show_items = function()
                            return vim.tbl_contains({ "sql" }, vim.o.filetype)
                        end,
                    },
                },
            },

            -- Rychle vyhledavani v navrzich (preferuje Rust implementaci)
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },
}
