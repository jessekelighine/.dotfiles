-- ~/.config/nvim/after/plugin/treesitter.lua
-- ~/.config/nvim/lua/plugin/treesitter.lua

vim.api.nvim_set_hl(0, "@variable", { link = "Identifier" })

-- R --------------------------------------------------------------------------

vim.api.nvim_set_hl(0, "@module.r", { link = "Special" })

-- Markdown -------------------------------------------------------------------

vim.api.nvim_set_hl(0, "@markup.link.url.markdown_inline", { link = "Ignore" })
vim.api.nvim_set_hl(0, "@markup.italic.markdown_inline", { link = "Todo" })
vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { link = "Type" })
vim.api.nvim_set_hl(0, "@markup.link.label", { link = "Identifier" })

-- LaTeX ----------------------------------------------------------------------

vim.api.nvim_set_hl(0, "@punctuation.delimiter.latex", { link = "Number" })
vim.api.nvim_set_hl(0, "@function.macro.latex", { link = "Label" })
vim.api.nvim_set_hl(0, "@module.latex", { link = "Statement" })
vim.api.nvim_set_hl(0, "@label.latex", { link = "Identifier" })

-- Inspect Language -----------------------------------------------------------

vim.api.nvim_create_user_command(
	"InspectLanguage",
	function()
		local ok, parser = pcall(vim.treesitter.get_parser)
		if not ok or parser == nil then
			print("No Treesitter Parser Available")
		else
			local line = vim.fn.line(".")
			local language = parser:language_for_range({line, 0, line, 0}):lang()
			print(language)
		end
	end,
	{ desc = "Inspect the Language of the Current Line based on Treesitter" }
)
