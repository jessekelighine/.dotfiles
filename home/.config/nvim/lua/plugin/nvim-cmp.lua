-- ~/.config/nvim/lua/plugin/nvim-cmp.lua

return {
	"hrsh7th/nvim-cmp",
	config = function()
		local cmp = require "cmp"
		cmp.setup {
			snippet = {
				expand = function(args)
					vim.snippet.expand(args.body)
				end
			},
			sources = {
				{ name = "cmp_r" },
				{ name = "luasnip" },
			},
			mapping = cmp.mapping.preset.insert {
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
		}
	end,
}
