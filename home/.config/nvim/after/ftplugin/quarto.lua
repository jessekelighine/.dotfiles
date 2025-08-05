-- ~/.config/nvim/after/ftplugin/quarto.lua
-- ~/.config/nvim/after/ftplugin/quarto.vim

vim.keymap.set("i", "``<Tab>", function() vim.snippet.expand("```{r}\n$0\n```") end, { buffer = true })
vim.keymap.set("i", "*<Tab>",  function() vim.snippet.expand("*$1* $0") end, { buffer = true })
vim.keymap.set("i", "**<Tab>", function() vim.snippet.expand("**$1** $0") end, { buffer = true })

vim.keymap.set("i", "\\t<Tab>", function() vim.snippet.expand("\\text{$1}$0") end, { buffer  = true })
vim.keymap.set("i", "\\mb<Tab>", function() vim.snippet.expand("\\mathbf{$1}$0") end, { buffer  = true })
vim.keymap.set("i", "\\mf<Tab>", function() vim.snippet.expand("\\mathsf{$1}$0") end, { buffer  = true })
vim.keymap.set("i", "\\mt<Tab>", function() vim.snippet.expand("\\mathtt{$1}$0") end, { buffer  = true })
vim.keymap.set("i", "\\mr<Tab>", function() vim.snippet.expand("\\mathrm{$1}$0") end, { buffer  = true })
vim.keymap.set("i", "\\bb<Tab>", function() vim.snippet.expand("\\mathbb{$1}$0") end, { buffer  = true })
vim.keymap.set("i", "\\mc<Tab>", function() vim.snippet.expand("\\mathcal{$1}$0") end, { buffer  = true })
vim.keymap.set("i", "\\ms<Tab>", function() vim.snippet.expand("\\mathscr{$1}$0") end, { buffer  = true })
vim.keymap.set("i", "\\mk<Tab>", function() vim.snippet.expand("\\mathfrak{$1}$0") end, { buffer  = true })
vim.keymap.set("i", "\\bs<Tab>", function() vim.snippet.expand("\\boldsymbol{$1}$0") end, { buffer  = true })

vim.keymap.set("i", "_<Tab>", function() vim.snippet.expand("_{$1}$0") end, { buffer = true })
vim.keymap.set("i", "^<Tab>", function() vim.snippet.expand("^{$1}$0") end, { buffer = true })
vim.keymap.set("i", "$<Tab>", function() vim.snippet.expand("\\$$0\\$") end, { buffer = true })
vim.keymap.set("i", "\\f<Tab>", function() vim.snippet.expand("\\frac{$1}{$2}$0") end, { buffer  = true })
vim.keymap.set("i", "\\sum<Tab>", function() vim.snippet.expand("\\sum_{${1:i=1}}^{${2:n}} $0") end, { buffer  = true })
vim.keymap.set("i", "\\prod<Tab>", function() vim.snippet.expand("\\prod_{${1:i=1}}^{${2:n}} $0") end, { buffer  = true })

-- HIGHLIGHT BLOCK ------------------------------------------------------------

vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
	pattern = { '*.qmd' },
	desc = "Highlight Quarto Blocks",
	group = vim.api.nvim_create_augroup("HighlightQuartoBlocks", { clear = true }),
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
