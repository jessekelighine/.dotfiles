-- ~/.config/nvim/after/plugin/treesitter.lua

require'nvim-treesitter.configs'.setup {

	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	highlight = {
		enable  = true,
		disable = { "c", "latex" },
	},

	-- indent = {
	-- 	enable = true,
	-- },

}
