return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  -- Zmeneno na "BufReadPost", aby mel Neovim cas rozpoznat typ souboru
  event = {
    "BufReadPost " .. vim.fn.expand("~") .. "/markdownNotes/**.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/markdownNotes/**.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>od", "<cmd>ObsidianToday<cr>", desc = "Obsidian: Dnesni denik" },
    { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "Obsidian: Nova poznamka" },
    { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Obsidian: Hledat v poznamkach" },
  },
  opts = {
    workspaces = {
      {
        name = "poznamky",
        path = "~/markdownNotes",
      },
    },
    daily_notes = {
      folder = "denik",
      date_format = "%Y-%m-%d",
    },
    
    -- UI NASTAVENI
    ui = {
      enable = true,
      header_indices = true,
      checkboxes = {
        -- Pouzivame Unicode kody, aby byla jistota, ze je font najde
        [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        ["x"] = { char = "", hl_group = "ObsidianDone" },
      },
      bullets = { char = "•", hl_group = "ObsidianBullet" },
      external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
    },

    note_id_func = function(title)
      if title ~= nil then
        return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        return tostring(os.time())
      end
    end,
  },
}
