-- ~/.config/nvim/after/plugin/luasnip.lua
-- ~/.config/nvim/lua/plugin/luasnip.lua
-- ~/.config/nvim/snippets

local luasnip = require "luasnip"
local snippets_path = "./snippets"

require("luasnip.loaders.from_vscode").load { paths = { snippets_path } }

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
