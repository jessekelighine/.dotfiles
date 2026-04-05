-- ~/.config/nvim/lua/plugin/telescope.lua

local builtin = require "telescope.builtin"
local telescope = require "telescope"
vim.keymap.set("n", "<C-t>", builtin.find_files)
vim.keymap.set("n", "<C-f>", builtin.live_grep)
vim.keymap.set("n", "<C-b>", builtin.buffers)
vim.keymap.set("n", "<leader>h", builtin.help_tags)
telescope.setup {
	defaults = {
		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		file_ignore_patterns = { "undodir/" },
		mappings = {
			i = {
				["<C-k>"] = "move_selection_previous",
				["<C-j>"] = "move_selection_next",
			}
		},
	},
	-- pickers = {
	-- 	find_files = {
	-- 		find_command = {
	-- 			"fd", "--hidden", "--follow", "--exclude .git"
	-- 		}
	-- 	}
	-- }
}
