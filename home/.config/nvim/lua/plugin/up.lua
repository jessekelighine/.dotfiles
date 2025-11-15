-- ~/.config/nvim/lua/plugin/up.lua

return {
	"jessekelighine/up.nvim",
	config = function()
		require("up").map("<C-U>")
		vim.g.up_nvim_action = function(dir) vim.cmd.cd(dir) end
	end,
}
