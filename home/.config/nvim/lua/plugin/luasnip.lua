-- ~/.config/nvim/lua/plugin/luasnip.lua
-- ~/.config/nvim/after/plugin/luasnip.lua
-- ~/.config/nvim/snippets

return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	build = "make install_jsregexp",
	dependencies = { "saadparwaiz1/cmp_luasnip" }
}
