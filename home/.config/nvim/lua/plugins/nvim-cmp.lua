return {
	"hrsh7th/nvim-cmp",
	config = function()
		local cmp = require("cmp")
		cmp.setup {
			sources = {{ name = "cmp_r" }},
			mapping = cmp.mapping.preset.insert {
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end, { "i", "s" }),
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
		}
		require("cmp_r").setup {}
	end,
}
