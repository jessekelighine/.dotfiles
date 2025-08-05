-- ~/.config/nvim/lua/plugin/up.lua

return {
	"jessekelighine/up.nvim",
	config = function() require("up").map "<C-U>" end
}
