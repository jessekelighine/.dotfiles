-- ~/.config/nvim/lua/plugin/oil.lua

return {
	"stevearc/oil.nvim",
	lazy = false,
	config = function()
		require("oil").setup {
			view_options = { show_hidden = true },
			default_file_explorer = true,
			keymaps = {
				["<C-t>"] = false
			}
		}
		local oil = ":Oil<CR>"
		local newtab = ":" .. table.concat({
			"tabnew",
			"setlocal buftype=nofile",
			"setlocal bufhidden=hide",
			"setlocal noswapfile",
			"setlocal nobuflisted"
		}, " | ") .. "<CR>"
		vim.keymap.set("n", "-", oil, { silent = true })
		vim.keymap.set("n", "<C-N>", newtab .. oil, { silent = true })
	end
}
