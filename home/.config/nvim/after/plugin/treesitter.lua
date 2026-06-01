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
vim.api.nvim_set_hl(0, "texDelimiter", { link = "Ignore" })

-- VIM ------------------------------------------------------------------------

vim.api.nvim_set_hl(0, "vimVar", { link = "Identifier" })
vim.api.nvim_set_hl(0, "vimVarScope", { link = "Label" })
vim.api.nvim_set_hl(0, "vimFunctionName", { link = "Function" })

-- Inspect Language -----------------------------------------------------------

vim.api.nvim_create_user_command(
	"InspectLanguage",
	function()
		local parser, err = vim.treesitter.get_parser(0)
		if not parser then
			vim.notify(err or "No Treesitter parser available", vim.log.levels.WARN)
		else
			local cursor = vim.api.nvim_win_get_cursor(0)
			local line = cursor[1] - 1
			local col = cursor[2]
			local lang_tree = parser:language_for_range({ line, col, line, col })
			print(lang_tree:lang())
		end
	end,
	{ desc = "Inspect the language at the cursor based on Treesitter" }
)
