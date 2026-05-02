return {
  -- Plugin pro vizualni napovedu klavesovych zkratek
  "folke/which-key.nvim",
  -- Nacte se az chvili po startu (nebrzdi spousteni)
  event = "VeryLazy",
  opts = {
    -- Ponechano prazdne pro vychozi nastaveni
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Zobrazit mistni klavesove zkratky",
    },
  },
}
