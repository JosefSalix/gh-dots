-- Nastaveni klavesovych zkratek

-- Otevreni spravce souboru Oil v plovoucim okne
-- Vychozi klavesa je minus
vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Otevrit Oil v plovoucim okne" })

-- Zobrazeni chybove hlasky (diagnostiky) v plovoucim okne
vim.keymap.set("n", "gl", function()
    vim.diagnostic.open_float()
end, { desc = "Zobrazit chybu pod kurzorem" })

-- Formatovani aktualniho souboru (vyzaduje plugin conform.nvim)
vim.keymap.set("n", "<leader>cf", function()
    require("conform").format({
        lsp_format = "fallback",
    })
end, { desc = "Formatovat soubor" })

-- Rychle prepinani mezi projekty (vyzaduje fzf-lua nebo projektovy plugin)
vim.keymap.set("n", "<leader>fp", ":ProjectFzf<CR>", { noremap = true, silent = true, desc = "Vyhledat projekt" })
