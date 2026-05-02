-- Bootstrap lazy.nvim (automaticka instalace manageru, pokud chybi)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Chyba pri klonovani lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nStiskni libovolnou klavesu pro ukončení..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
-- Pridani lazy do runtime path, aby o nem nvim vedel
vim.opt.rtp:prepend(lazypath)

-- DULEZITE: Leader klavesy musi byt nastaveny PRED nactenim lazy.nvim
-- Nastavujeme leader na mezernik
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Nacteni tveho zakladniho nastaveni (vypnuti cislovani, taby, atd.)
require("config.options")

-- Samotne nastaveni lazy.nvim
require("lazy").setup({
	spec = {
		-- Tento radek rika lazy, ze ma hledat pluginy ve slozce lua/plugins/
		{ import = "plugins" },
	},
	-- Nastaveni pro instalaci
	install = {
		-- Kanagawa jako zalozni tema pri instalaci (pokud ji budes instalovat)
		colorscheme = { "kanagawa" },
	},
	-- Automaticka kontrola aktualizaci pluginu
	checker = { enabled = true },
})

-- Nacteni klavesovych zkratek (vetsinou zavislych na pluginech)
require("config.keymaps")

-- Tady si vzdy prepises jmeno tematu, ktere chces zrovna pouzivat
vim.cmd.colorscheme("everforest")
