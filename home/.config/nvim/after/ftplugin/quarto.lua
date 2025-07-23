-- ~/.config/nvim/after/ftplugin/quarto.lua
-- ~/.config/nvim/after/ftplugin/quarto.vim

vim.keymap.set("i", ":c<Tab>", function() vim.snippet.expand("<!-- $0 -->") end, { buffer = true })
vim.keymap.set("i", "::<Tab>", function() vim.snippet.expand(":::{$1}\n$0\n:::") end, { buffer = true })
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

--- FORMATTING ----------------------------------------------------------------

vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
	pattern = { '*.qmd' },
	desc = "Format R code with Air in Quarto",
	group = vim.api.nvim_create_augroup('QuartoAirFormator', { clear = true }),
	callback = function()
		vim.api.nvim_buf_create_user_command(0, "FormatR", function()
			require("conform").format()
		end, { nargs = 0, range = 2 })
	end,
})

--- NVIM-CMP COMPLETION -------------------------------------------------------

local cmp = require "cmp"
local source = {}

local prepare_item = function(item)
	return {
		label = item.label,
		insertText = item.insertText,
		insertTextFormat = cmp.lsp.InsertTextFormat.Snippet,
		kind = cmp.lsp.CompletionItemKind.Snippet,
	}
end

---@diagnostic disable-next-line: unused-local
function source:complete(params, callback)
	local items = {}
	table.insert(items, prepare_item({ label = 'test', insertText = '($1 -> $2) $0' }))
	callback(items)
end

cmp.register_source("quarto", source)
local config = cmp.get_config()
table.insert(config.sources, { name = "quarto" })
cmp.setup(config)
