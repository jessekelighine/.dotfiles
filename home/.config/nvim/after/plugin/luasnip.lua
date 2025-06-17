-- ~/.config/nvim/after/plugin/luasnip.lua
-- ~/.config/nvim/lua/plugin/luasnip.lua

local ls = require("luasnip")
local snippets_location = "./snippets"

ls.config.set_config {
	history = true,
	updateevents = "TextChanged,TextChangedI",
	ext_base_prio = 300,
	ext_prio_increase = 1,
	autosnippets = true,
}

vim.keymap.set({"i", "s"}, "<C-]>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

vim.keymap.set({"i", "s"}, "<C-[>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

require("luasnip.loaders.from_vscode").load {
	paths = {
		snippets_location
	}
}
