return {
    "stevearc/oil.nvim",
    -- Volitelne nastaveni pro typovou kontrolu (pro vyvojare)
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        view_options = {
            -- Zobrazovat skryte soubory (ty co zacinaji teckou)
            show_hidden = true,
        },
        float = {
            -- Jednoduchy ramecek pro plovouci okno
            border = "single",
        },
    },
    -- Zavislosti - ikony pro soubory
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- Oil by nemel byt nacitan opozdene (lazy = false)
    lazy = false,
}
