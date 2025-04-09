-- [source](https://github.com/jhkuperus/dotfiles)

local M = {}

-- To easily layout windows on the screen, we use hs.grid to create a 4x4 grid.
-- If you want to use a more detailed grid, simply change its dimension here
local grid_size = 4
local half_grid_size = grid_size / 2
local third_grid_size = grid_size / 3

-- Set the grid size and add a few pixels of margin
-- Also, don't animate window changes... That's too slow
hs.grid.setGrid(grid_size .. 'x' .. grid_size)
hs.grid.setMargins {5, 5}
hs.window.animationDuration = 0

-- Defining screen positions
local positions = {
	full         = { x = 0,               y = 0,               w = grid_size,       h     = grid_size       },
	left         = { x = 0,               y = 0,               w = half_grid_size,  h     = grid_size       },
	right        = { x = half_grid_size,  y = 0,               w = half_grid_size,  h     = grid_size       },
	top          = { x = 0,               y = 0,               w = grid_size,       h     = half_grid_size  },
	bottom       = { x = 0,               y = half_grid_size,  w = grid_size,       h     = half_grid_size  },
	left_fat     = { x = 0,               y = 0,               w = 2 * third_grid_size, h = grid_size       },
	right_fat    = { x = third_grid_size, y = 0,               w = 2 * third_grid_size, h = grid_size       },
	top_fat      = { x = 0,               y = 0,               w = grid_size,       h     = 2 * third_grid_size },
	bottom_fat   = { x = 0,               y = third_grid_size, w = grid_size,       h     = 2 * third_grid_size },
	top_left     = { x = 0,               y = 0,               w = half_grid_size,  h     = half_grid_size  },
	top_right    = { x = half_grid_size,  y = 0,               w = half_grid_size,  h     = half_grid_size  },
	bottom_left  = { x = 0,               y = half_grid_size,  w = half_grid_size,  h     = half_grid_size  },
	bottom_right = { x = half_grid_size,  y = half_grid_size,  w = half_grid_size,  h     = half_grid_size  },
}

M.positions = positions

-- This function will move either the specified or the focuesd
-- window to the requested screen position
function M.move_to(cell, window)
	if window == nil then
		window = hs.window.focusedWindow()
	end
	if window then
		local screen = window:screen()
		hs.grid.set(window, cell, screen)
	end
end

-- This function will move either the specified or the focused
-- window to the center of the sreen and let it fill up the
-- entire screen.
function M.maximize(factor, window)
	if window == nil then
			window = hs.window.focusedWindow()
	end
	if window then
			window:maximize()
	end
end

return M
