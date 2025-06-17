return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<C-t>", builtin.find_files)
		vim.keymap.set("n", "<C-f>", builtin.live_grep)
		vim.keymap.set("n", "<C-b>", builtin.buffers)
		vim.keymap.set("n", "<C-s>", builtin.spell_suggest)
		require("telescope").setup {
			defaults = {
				mappings = {
					i = {
						["<C-k>"] = "move_selection_previous",
						["<C-j>"] = "move_selection_next",
					}
				}
			}
		}
	end,
}
