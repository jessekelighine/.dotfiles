-- window-management.lua

local M = {}

hs.grid.setGrid("2x2")
hs.grid.setMargins({ 5, 5 })
hs.window.animationDuration = 0

M.grid_position = {
	left   = { x = 0, y = 0, w = 1, h = 2 },
	right  = { x = 1, y = 0, w = 1, h = 2 },
	top    = { x = 0, y = 0, w = 2, h = 1 },
	bottom = { x = 0, y = 1, w = 2, h = 1 },
	full   = { x = 0, y = 0, w = 2, h = 2 },
}

M.move_to = function(position)
	local window = hs.window.focusedWindow()
	local screen = window:screen()
	hs.grid.set(window, M.grid_position[position], screen)
end

M.full = function() M.move_to("full") end

M.center = function()
	local window = hs.window.focusedWindow()
	window:centerOnScreen()
end

return M
