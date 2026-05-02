return {
    -- Hlavni LSP konfigurace
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Mason musi byt nacten pred lspconfig
        { "williamboman/mason.nvim", opts = {} },
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",

        -- Stavove aktualizace (videt, ze LSP pracuje)
        { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
        -- Tato funkce se spusti, kdyz se LSP pripoji k souboru
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or "n"
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                -- SKOKY V KODU (vyuziva fzf-lua pro hezky vyber)
                map("gd", require("fzf-lua").lsp_definitions, "Jdi na definici")
                map("gr", require("fzf-lua").lsp_references, "Najdi reference")
                map("gI", require("fzf-lua").lsp_implementations, "Jdi na implementaci")
                map("<leader>D", require("fzf-lua").lsp_typedefs, "Typova definice")
                map("<leader>ds", require("fzf-lua").lsp_document_symbols, "Symboly v dokumentu")
                map("<leader>ws", require("fzf-lua").lsp_live_workspace_symbols, "Symboly v projektu")

                -- AKCE S KODEM
                map("<leader>cr", vim.lsp.buf.rename, "Prejmenovat")
                map("<leader>ca", vim.lsp.buf.code_action, "Akce kodu", { "n", "x" })
                map("gD", vim.lsp.buf.declaration, "Jdi na deklaraci")

                -- Pomocna funkce pro verzi nvim 0.11
                local function client_supports_method(client, method, bufnr)
                    if vim.fn.has("nvim-0.11") == 1 then
                        return client:supports_method(method, bufnr)
                    else
                        return client.supports_method(method, { bufnr = bufnr })
                    end
                end

                -- Zvyrazneni slov pod kurzorem
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
                    local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })
                end
            end,
        })

        -- Ikonky pro chyby a varovani
        vim.diagnostic.config({
            severity_sort = true,
            float = { border = "rounded", source = "if_many" },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "󰅚 ",
                    [vim.diagnostic.severity.WARN] = "󰀪 ",
                    [vim.diagnostic.severity.INFO] = "󰋽 ",
                    [vim.diagnostic.severity.HINT] = "󰌶 ",
                },
            },
        })

        -- Propojeni LSP s tvym naseptavacem Blink
        local original_capabilities = vim.lsp.protocol.make_client_capabilities()
        local capabilities = require("blink.cmp").get_lsp_capabilities(original_capabilities)

        -- SEZNAM JAZYKU (LSP serveru)
        local servers = {
            bashls = {},    -- Bash
            marksman = {},  -- Markdown
            lua_ls = {      -- Lua
                settings = {
                    Lua = {
                        diagnostics = { disable = { 'missing-fields' } },
                    },
                },
            },
        }

        -- Instalace nastroju skrze Mason
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            "stylua",   -- Formater pro Luu
            "prettierd", -- Formater pro JS/TS
        })
        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        require("mason-lspconfig").setup({
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                    require("lspconfig")[server_name].setup(server)
                end,
            },
        })
    end,
}
