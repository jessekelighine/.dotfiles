return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		vim.treesitter.language.register("bash", "zsh")
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
				disable = {
					-- "cpp",
					-- "latex",
					-- "markdown",
				},
			},
			indent = {
				enable = true,
				disable = { "cpp" },
			},
			modules = {},
			ignore_install = {},
			auto_install = false,
		}

		--[[ Special handling for Quarto files ]]--
		vim.api.nvim_create_autocmd('FileType', {
			group = vim.api.nvim_create_augroup("HighlightQuartoBlocks", { clear = true }),
			desc = "Highlight Quarto Blocks",
			pattern = "quarto",
			callback = function()
				vim.cmd[[
				syntax match quartoTag /{#.\{-}}/
				syntax match quartoDiv /^:::.*$/
				syntax match quartoCite /@[a-zA-Z0-9-_:]\+/
				highlight def link quartoDiv Todo
				highlight def link quartoTag Todo
				highlight def link quartoCite Label
				]]
			end
		})
	end
}
