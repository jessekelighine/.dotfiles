-- ~/.config/nvim/lua/plugin/luasnip.lua

return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	build = "make install_jsregexp",
	dependencies = { "saadparwaiz1/cmp_luasnip" },
	config = function()

		local luasnip = require "luasnip"
		local snippet_path = "./snippet"
		require("luasnip.loaders.from_vscode").load { paths = { snippet_path } }

		vim.keymap.set({"i", "s"}, "<Tab>", function()
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif vim.snippet.active({ direction = 1 }) then
				vim.snippet.jump(1)
			else
				local tab = vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
				vim.fn.feedkeys(tab, "n")
			end
		end, { silent = true })

		vim.keymap.set({"i", "s"}, "<S-Tab>", function()
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			elseif vim.snippet.active({ direction = -1 }) then
				vim.snippet.jump(-1)
			end
		end, { silent = true })

	end
}
