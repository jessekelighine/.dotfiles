return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")
		conform.setup{
			formatters_by_ft = {
				quarto = { "injected" },
				rmd = { "injected" },
				r = { "air" },
			},
		}
		vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
			pattern = { '*.qmd' },
			desc = "Format R code with Air in Quarto",
			group = vim.api.nvim_create_augroup('QuartoAirFormator', { clear = true }),
			callback = function()
				vim.api.nvim_buf_create_user_command(0, "FormatR",
					function() require("conform").format() end,
					{ nargs = 0, range = 2 }
				)
			end,
		})
	end,
}
