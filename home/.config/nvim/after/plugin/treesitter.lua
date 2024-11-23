-- ~/.config/nvim/after/plugin/treesitter.lua

require("nvim-treesitter.configs").setup({
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
})

-- Custom Highlights ----------------------------------------------------------

-- R
vim.api.nvim_set_hl(0, "@variable", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@module.r", { link = "Special" })

-- Markdown
vim.api.nvim_set_hl(0, "@markup.italic.markdown_inline", { link = "Todo" })
vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { link = "Type" })
vim.api.nvim_set_hl(0, "@markup.link.label", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@markup.link.url.markdown_inline", { link = "Ignore" })

-- LaTeX
vim.api.nvim_set_hl(0, "@module.latex", { link = "Statement" })
vim.api.nvim_set_hl(0, "@label.latex", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@punctuation.delimiter.latex", { link = "Number" })
vim.api.nvim_set_hl(0, "@function.macro.latex", { link = "Label" })
