return {
	"jessekelighine/vindent.nvim",
	branch = "experimental",
	config = function()
		local vindent = require("vindent")
		local block_opts = {
			strict     = { skip_empty_lines = false, skip_more_indented_lines = false },
			contiguous = { skip_empty_lines = false, skip_more_indented_lines = true  },
			loose      = { skip_empty_lines = true,  skip_more_indented_lines = true  },
		}
		vindent.map.BlockMotion({ prev = "[l", next = "]l" }, block_opts.strict)
		vindent.map.Motion({ prev = "[-", next = "]-" }, "less")
		vindent.map.Motion({ prev = "[=", next = "]=" }, "more")
		vindent.map.BlockEdgeMotion({ prev = "[p", next = "]p" }, block_opts.loose)
		vindent.map.BlockEdgeMotion({ prev = "[P", next = "]P" }, block_opts.contiguous)
		vindent.map.Object("iA", "ii", block_opts.strict)
		vindent.map.Object("iI", "ii", block_opts.contiguous)
		vindent.map.Object("ii", "ii", block_opts.loose)
		vindent.map.Object("ai", "ai", block_opts.loose)
		vindent.map.Object("aI", "aI", block_opts.loose)
		vindent.setup {
			begin = false,
			noisy = true,
		}

		vim.api.nvim_create_user_command(
			"VindentNoisy",
			function(opts)
				if not opts.bang then
					vim.g.vindent_noisy = not vim.g.vindent_noisy
				end
				local status = vim.g.vindent_noisy and "ON" or "OFF"
				local message = "'" .. ( ":VindentNoisy " .. status ) .. "'"
				vim.cmd.echo(message)
			end,
			{ bang = true }
		)

		vim.api.nvim_create_user_command(
			"VindentBegin",
			function(opts)
				if not opts.bang then
					vim.g.vindent_begin = not vim.g.vindent_begin
				end
				local status = vim.g.vindent_begin and "ON" or "OFF"
				local message = "'" .. ( ":VindentBegin " .. status ) .. "'"
				vim.cmd.echo(message)
			end,
			{ bang = true }
		)
	end
}

-- return {
-- 	"jessekelighine/vindent.nvim",
--	branch = "main",
-- 	config = function()
-- 		local map = {
-- 			motion = function(lhs, rhs) vim.keymap.set("", lhs, rhs) end,
-- 			object = function(lhs, rhs) vim.keymap.set({"x", "o"}, lhs, rhs) end,
-- 		}
-- 		map.motion("[l", "<Plug>(VindentBlockMotion_OO_prev)")
-- 		map.motion("]l", "<Plug>(VindentBlockMotion_OO_next)")
-- 		map.motion("[-", "<Plug>(VindentMotion_less_prev)")
-- 		map.motion("]-", "<Plug>(VindentMotion_less_next)")
-- 		map.motion("[=", "<Plug>(VindentMotion_more_prev)")
-- 		map.motion("]=", "<Plug>(VindentMotion_more_next)")
-- 		map.motion("[p", "<Plug>(VindentBlockEdgeMotion_XX_prev)")
-- 		map.motion("]p", "<Plug>(VindentBlockEdgeMotion_XX_next)")
-- 		map.motion("[P", "<Plug>(VindentBlockEdgeMotion_OO_prev)")
-- 		map.motion("]P", "<Plug>(VindentBlockEdgeMotion_OO_next)")
-- 		map.object("iI", "<Plug>(VindentObject_OO_ii)")
-- 		map.object("ii", "<Plug>(VindentObject_XX_ii)")
-- 		map.object("ai", "<Plug>(VindentObject_XX_ai)")
-- 		map.object("aI", "<Plug>(VindentObject_XX_aI)")
-- 		vim.g.vindent_begin = false
-- 	end
-- }
