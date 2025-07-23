-- ~/.config/nvim/lua/plugin/lspconfig.lua
-- ~/.config/nvim/after/plugin/lspconfig.lua

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{
						path = "${3rd}/luv/library",
						words = { "vim%.uv" }
					},
				},
			},
		},
	},
	config = function()
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('KickstartLspAttach', { clear = true }),
			desc = "LSP Actions on Attach",
			callback = function(event)
				vim.keymap.set("n", "gdd", vim.diagnostic.open_float, { buffer = event.buf, desc = 'LSP: [D]iagnostics' })
				vim.opt.signcolumn = "yes:1"
			end
		})
		vim.diagnostic.config {
			signs = false,
			float = { solid = true },
		}
	end,
}
