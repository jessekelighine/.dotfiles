-- ~/.config/nvim/after/plugin/treesitter.lua

require'nvim-treesitter.configs'.setup {
	ensure_installed = {
		"c", "cpp", "bash", "lua", "vim", "vimdoc", "query",
		"markdown", "markdown_inline", "r", "rnoweb",
	},

	sync_install = false,

	highlight = {
		enable  = true,
	    additional_vim_regex_highlighting = false,
		disable = {
			"c",
			"latex",
			"markdown",
		},
	},

	indent = {
		enable = true,
		disable = { "cpp" },
	},
}

vim.api.nvim_set_hl(0, "@variable", { link = "Identifier" })
