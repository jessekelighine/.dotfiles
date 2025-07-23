-- ~/.config/nvim/lua/plugin/miramare.lua

return {
	"jessekelighine/miramare",
	config = function()
		vim.g.miramare_transparent_background = 1
		vim.g.miramare_disable_italic_comment = 0
		vim.cmd.colorscheme "miramare"
	end,
}
