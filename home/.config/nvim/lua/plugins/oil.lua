return {
	'stevearc/oil.nvim',
	lazy = false,
	config = function()
		local oil = require("oil")
		oil.setup {
			-- default_file_explorer = true
		}
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		vim.keymap.set("n", "<C-N>", ":tabnew<CR>:Oil<CR>", { desc = "Open parent directory" })
	end
}
