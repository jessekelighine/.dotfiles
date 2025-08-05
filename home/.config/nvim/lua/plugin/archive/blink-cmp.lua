-- ~/.config/nvim/lua/plugin/blink-cmp.lua

return {
	"saghen/blink.cmp",
	dependencies = {{
		-- This is a compatibility layer for using nvim-cmp sources.
		"saghen/blink.compat",
		version = '2.*',
		lazy = true,
		opts = {},
	}},
	opts = {
		keymap = {
			preset = "none",
			["<C-n>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<Tab>"] = { "accept", "fallback" },
			["<CR>"]  = { "accept", "fallback" },
		},
		appearance = { nerd_font_variant = "mono" },
		completion = {
			documentation = {
				window = { border = "single" },
				auto_show = true,
			},
		},
		sources = {
			default = {
				"cmp_r",
			},
			providers = {
				cmp_r = {
					name = "cmp_r",
					module = "blink.compat.source",
				}
			}
		},
		fuzzy = { implementation = "lua" }
	},
	-- opts_extend = { "sources.default" }
}
