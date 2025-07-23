-- ~/.config/nvim/lua/plugin/copilot.lua

return {
	"github/copilot.vim",
	init = function()
		vim.g.copilot_no_maps = true
		vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
		vim.keymap.set('i', '<C-W>', 'copilot#AcceptWord()', { expr = true, replace_keycodes = false })
		-- vim.keymap.set('i', '<C-Y>', 'copilot#Next()', { expr = true, replace_keycodes = false })
		-- vim.keymap.set('i', '<C-E>', 'copilot#Previous()', { expr = true, replace_keycodes = false })
		-- vim.keymap.set('i', '<C-U>', 'copilot#Suggest()', { expr = true, replace_keycodes = false })
	end
}
