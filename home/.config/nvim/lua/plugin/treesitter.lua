-- ~/.config/nvim/lua/plugin/treesitter.lua
-- ~/.config/nvim/after/plugin/treesitter.lua

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup {
			ensure_installed = {
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
			},
			sync_install = false,
			highlight = {
				enable  = true,
				additional_vim_regex_highlighting = false,
				disable = {},
			},
			indent = {
				enable = true,
				disable = { "cpp" },
			},
			modules = {},
			ignore_install = {},
			auto_install = false,
		}
	end
}
