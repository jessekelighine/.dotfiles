-- ~/.config/nvim/lua/plugin/treesitter.lua
-- ~/.config/nvim/after/plugin/treesitter.lua

require("nvim-treesitter").install {
		"c",
		"cpp",
		"bash",
		"lua",
		"vim",
		"vimdoc",
		"query",
		"markdown",
		"markdown_inline",
		"r",
		"python",
		"rnoweb",
		"latex",
		"csv",
		"make",
		"yaml",
		"bibtex",
}

-- require("nvim-treesitter").setup {
-- 	ensure_installed = {
-- 		"c",
-- 		"cpp",
-- 		"bash",
-- 		"lua",
-- 		"vim",
-- 		"vimdoc",
-- 		"query",
-- 		"markdown",
-- 		"markdown_inline",
-- 		"r",
-- 		"python",
-- 		"rnoweb",
-- 		"latex",
-- 		"csv",
-- 		"make",
-- 		"yaml",
-- 		"bibtex",
-- 	},
-- 	sync_install = false,
-- 	highlight = {
-- 		enable  = true,
-- 		additional_vim_regex_highlighting = false,
-- 		disable = {},
-- 	},
-- 	indent = {
-- 		enable = true,
-- 		disable = { "cpp" },
-- 	},
-- 	modules = {},
-- 	ignore_install = {},
-- 	auto_install = false,
-- }
