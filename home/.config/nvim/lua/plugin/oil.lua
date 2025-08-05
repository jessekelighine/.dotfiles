-- ~/.config/nvim/lua/plugin/oil.lua

return {
	"stevearc/oil.nvim",
	lazy = false,
	config = function()
		local oil = require	"oil"
		oil.setup {
			default_file_explorer = true,
			view_options = { show_hidden = true },
			keymaps = {
				["<C-t>"] = false
			}
		}
		local explore = ":Oil<CR>"
		local newtab = ":" .. table.concat({
			"tabnew",
			"setlocal buftype=nofile",
			"setlocal bufhidden=hide",
			"setlocal noswapfile",
			"setlocal nobuflisted"
		}, " | ") .. "<CR>"
		vim.keymap.set("n", "-", explore, { silent = true })
		vim.keymap.set("n", "<C-N>", newtab .. explore, { silent = true })
	end
}
