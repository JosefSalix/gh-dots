return {
	"windwp/nvim-autopairs",
	-- Nacte se hned, jakmile zacnes psat (v Insert modu)
	event = "InsertEnter",
	config = function()
		require("nvim-autopairs").setup({
			-- Automaticky uzavira zavorky: (), [], {}, "", ''
			check_ts = true, -- Vyuziva Treesitter pro chytrejsi chovani
			ts_config = {
				lua = { "string" }, -- V lua nebude doplnovat pary uvnitr stringu
				javascript = { "template_string" },
			},
		})

		-- Pokud pouzivas naseptavac (nvim-cmp), tohle propojeni zaridi,
		-- ze kdyz vyberes funkci ze seznamu, automaticky to doplni i zavorky ()
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local ok, cmp = pcall(require, "cmp")
		if ok then
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end
	end,
}
