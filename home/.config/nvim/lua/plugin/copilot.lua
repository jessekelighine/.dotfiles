return {
	"github/copilot.vim",
	config = function()
		vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
		vim.keymap.set('i', '<C-W>', 'copilot#AcceptWord()', { expr = true, replace_keycodes = false })
		-- vim.keymap.set('i', '<C-Y>', 'copilot#Next()', { expr = true, replace_keycodes = false })
		-- vim.keymap.set('i', '<C-E>', 'copilot#Previous()', { expr = true, replace_keycodes = false })
		-- vim.keymap.set('i', '<C-U>', 'copilot#Suggest()', { expr = true, replace_keycodes = false })
		vim.g.copilot_no_tab_map = true
	end
}
