-- window-management.lua

local M = {}

M.grid_size = 8
M.margin_size = 5

hs.grid.setGrid(M.grid_size .. "x" .. M.grid_size)
hs.grid.setMargins({ M.margin_size, M.margin_size })
hs.window.animationDuration = 0

M.grid_position = {
	left   = { x = 0,             y = 0,             w = M.grid_size/2, h = M.grid_size   },
	right  = { x = M.grid_size/2, y = 0,             w = M.grid_size/2, h = M.grid_size   },
	top    = { x = 0,             y = 0,             w = M.grid_size,   h = M.grid_size/2 },
	bottom = { x = 0,             y = M.grid_size/2, w = M.grid_size,   h = M.grid_size/2 },
	full   = { x = 0,             y = 0,             w = M.grid_size,   h = M.grid_size   },
}

M.move_to = function(position)
	local window = hs.window.focusedWindow()
	local screen = window:screen()
	hs.grid.set(window, M.grid_position[position], screen)
end

M.full = function()
	M.move_to("full")
end

M.center = function()
	local window = hs.window.focusedWindow()
	window:centerOnScreen()
end

return M
