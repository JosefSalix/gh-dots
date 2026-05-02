return {
    "stevearc/conform.nvim",
    opts = {
        -- Definice formatovacu pro jednotlive jazyky
        formatters_by_ft = {
            lua = { "stylua" },
            -- Python pusti dva nastroje po sobe
            python = { "isort", "black" },
            rust = { "rustfmt" },
            -- U JS/TS vybere prvni dostupny (uprednostnuje prettierd)
            javascript = { "prettierd", "prettier", stop_after_first = true },
            typescript = { "prettierd", "prettier", stop_after_first = true },
        },
        -- Automaticke formatovani pri kazdem ulozeni souboru
        format_on_save = {
            timeout_ms = 500, -- Maximalni cas pro formatovani
            lsp_format = "fallback", -- Pokud neni nastroj, zkusit LSP
        },
    },
}
