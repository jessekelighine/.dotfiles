-- ~/.config/nvim/lua/plugin/vindent.lua

return {
	"jessekelighine/vindent.nvim",
	config = function()
		-- MAIN CONFIG:
		local vindent = require "vindent"
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
			begin = true,
			noisy = true,
		}
		-- TOGGLE BEGIN:
		vim.api.nvim_create_user_command("VindentBegin", function(opts)
			if not opts.bang then
				vim.g.vindent_begin = not vim.g.vindent_begin
			end
			local status = vim.g.vindent_begin and "ON" or "OFF"
			local message = ":VindentBegin " .. status
			vim.notify(message, vim.log.levels.INFO)
		end, { bang = true })
		-- TOGGLE NOISY:
		vim.api.nvim_create_user_command("VindentNoisy", function(opts)
			if not opts.bang then
				vim.g.vindent_noisy = not vim.g.vindent_noisy
			end
			local status = vim.g.vindent_noisy and "ON" or "OFF"
			local message = ":VindentNoisy " .. status
			vim.notify(message, vim.log.levels.INFO)
		end, { bang = true })
	end
}
