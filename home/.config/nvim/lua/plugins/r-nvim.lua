return {
	"R-nvim/R.nvim",
	lazy = false,
	dependencies = { "R-nvim/cmp-r" },
	config = function()
		require("r").setup {
			pdfviewer = "",
			nvimpager = "tab", -- how help pages are viewed
			R_args = { "--quiet", "--no-save" },
			view_df = {
				-- open_app = ":tabnew %s | setlocal ft=csv",
				open_app = "tmux new-window vd",
				csv_sep = "\t",
				n_lines = -1,
			},
			disable_cmds = {
				"RSendLine",
				"RCustomStart",
				"RSPlot",
				"RSaveClose",
			},
			hook = {
				on_filetype = function()
					vim.api.nvim_buf_set_keymap(0, "n", "<leader>d", "<Plug>RDSendLine", {})
					vim.api.nvim_buf_set_keymap(0, "v", "<leader>d", "<Plug>RSendSelection", {})
					-- vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine:noh<CR>", {})
					-- vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
				end
			},
		}
	end,
}
