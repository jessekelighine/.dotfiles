-- ~/.config/nvim/after/plugin/treesitter.lua
-- ~/.config/nvim/lua/plugin/treesitter.lua

vim.api.nvim_set_hl(0, "@variable", { link = "Identifier" })

--- R -------------------------------------------------------------------------

vim.api.nvim_set_hl(0, "@module.r", { link = "Special" })

--- Markdown ------------------------------------------------------------------

vim.api.nvim_set_hl(0, "@markup.italic.markdown_inline", { link = "Todo" })
vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { link = "Type" })
vim.api.nvim_set_hl(0, "@markup.link.label", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@markup.link.url.markdown_inline", { link = "Ignore" })

--- LaTeX ---------------------------------------------------------------------

vim.api.nvim_set_hl(0, "@module.latex", { link = "Statement" })
vim.api.nvim_set_hl(0, "@label.latex", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@punctuation.delimiter.latex", { link = "Number" })
vim.api.nvim_set_hl(0, "@function.macro.latex", { link = "Label" })

--- Quarto --------------------------------------------------------------------

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
