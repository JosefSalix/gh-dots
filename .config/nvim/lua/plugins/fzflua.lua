return {
    "ibhagwan/fzf-lua",
    -- Zavislost na ikonkach, ktere uz mas diky Oil
    dependencies = { "echasnovski/mini.icons" },
    opts = {},
    keys = {
        { 
            "<leader>ff", 
            function() require('fzf-lua').files() end, 
            desc = "Hledat soubory v projektu" 
        },
        { 
            "<leader>fg", 
            function() require('fzf-lua').live_grep() end, 
            desc = "Hledat text v projektu" 
        },
        { 
            "<leader>fc", 
            function() require('fzf-lua').files({cwd=vim.fn.stdpath("config")}) end, 
            desc = "Hledat v nvim konfiguraci" 
        },
        {
            "<leader>fh",
            function() require("fzf-lua").helptags() end,
            desc = "Hledat v napovede",
        },
        {
            "<leader>fk",
            function() require("fzf-lua").keymaps() end,
            desc = "Hledat klavesove zkratky",
        },
        {
            "<leader>fb",
            function() require("fzf-lua").builtin() end,
            desc = "Vestavene fzf funkce",
        },
        {
            "<leader>fw",
            function() require("fzf-lua").grep_cword() end,
            desc = "Hledat slovo pod kurzorem",
        },
        {
            "<leader>fW",
            function() require("fzf-lua").grep_cWORD() end,
            desc = "Hledat cely retezec pod kurzorem",
        },
        {
            "<leader>fd",
            function() require("fzf-lua").diagnostics_document() end,
            desc = "Hledat chyby v souboru",
        },
        {
            "<leader>fr",
            function() require("fzf-lua").resume() end,
            desc = "Pokracovat v poslednim hledani",
        },
        {
            "<leader>fo",
            function() require("fzf-lua").oldfiles() end,
            desc = "Nedavne soubory",
        },
        {
            "<leader><leader>",
            function() require("fzf-lua").buffers() end,
            desc = "Prepnout otevrene soubory (buffery)",
        },
        {
            "<leader>/",
            function() require("fzf-lua").lgrep_curbuf() end,
            desc = "Hledat text v aktualnim souboru",
        },
    }
}
