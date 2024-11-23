return {
	'jessekelighine/vindent.vim',
	init = function()
		-- Keybindings for vindent.vim
		vim.g.vindent_motion_OO_prev   = '[=' -- jump to prev block of same indent.
		vim.g.vindent_motion_OO_next   = ']=' -- jump to next block of same indent.
		vim.g.vindent_motion_more_prev = '[+' -- jump to prev line with more indent.
		vim.g.vindent_motion_more_next = ']+' -- jump to next line with more indent.
		vim.g.vindent_motion_less_prev = '[-' -- jump to prev line with less indent.
		vim.g.vindent_motion_less_next = ']-' -- jump to next line with less indent.
		vim.g.vindent_motion_diff_prev = '[;' -- jump to prev line with different indent.
		vim.g.vindent_motion_diff_next = '];' -- jump to next line with different indent.
		vim.g.vindent_motion_XX_ss     = '[p' -- jump to start of the current block scope.
		vim.g.vindent_motion_XX_se     = ']p' -- jump to end of the current block scope.
		vim.g.vindent_object_XX_ii     = 'ii' -- select current block.
		vim.g.vindent_object_XX_ai     = 'ai' -- select current block + one extra line at beginning.
		vim.g.vindent_object_XX_aI     = 'aI' -- select current block + two extra lines at beginning and end.
		vim.g.vindent_jumps            = 1    -- make vindent motion count as a |jump-motion|.
	end,
	config = function()
		-- Additional config if needed
	end
}
