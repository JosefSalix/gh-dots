return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      -- Tato cast zajisti, ze se plugin natvrdo prida do cest Neovimu
      -- i kdyby ho lazy.nvim z nejakeho duvodu "zapomnel"
      local path = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter"
      vim.opt.runtimepath:prepend(path)

      -- Ted zkusime bezpecne nacist konfiguraci
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if not ok then
        -- Pokud to porad nejde, aspon nam to neshodi cely start Neovimu
        return
      end

      configs.setup({
        ensure_installed = { 
          "c", "lua", "vim", "vimdoc", "query", "javascript", "html", "markdown" 
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
            },
          },
        },
      })
    end,
  },
}
