-- ~/.config/nvim/lua/plugin/conform.lua

return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require "conform"
		conform.setup {
			formatters_by_ft = {
				quarto = { "injected" },
				rmd = { "injected" },
				r = { "air" },
			},
		}
	end,
}
