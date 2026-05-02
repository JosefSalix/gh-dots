return {
    "rebelot/kanagawa.nvim",
    branch = "master",
    config = function()
        require('kanagawa').setup({
            transparent = true,
            overrides = function(colors)
                return {
                    -- Tady vypneme pozadi pro vsechny casti leveho sloupce
                    SignColumn = { bg = "none" },    -- Sloupec pro ikony
                    LineNr = { bg = "none" },        -- Samotna cisla radku
                    CursorLineNr = { bg = "none" },  -- Cislo radku pod kurzorem

                    -- Tvoje nastaveni pro Markdown
                    ["@markup.link.url.markdown_inline"] = { link = "Special" },
                    ["@markup.link.label.markdown_inline"] = { link = "WarningMsg" },
                    ["@markup.italic.markdown_inline"] = { link = "Exception" },
                    ["@markup.raw.markdown_inline"] = { link = "String" },
                    ["@markup.list.markdown"] = { link = "Function" },
                    ["@markup.quote.markdown"] = { link = "Error" },
                    ["@markup.list.checked.markdown"] = { link = "WarningMsg" }
                }
            end
        })
    end,
}
