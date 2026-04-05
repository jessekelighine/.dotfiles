-- ~/.config/nvim/lua/plugin/mini-pick.lua

return {
	'echasnovski/mini.pick',
	version = '*',
	config = function()
		local pick = require('mini.pick')
		pick.setup {}
	end,
}
