-- ~/.config/nvim/after/ftplugin/markdown.lua
-- ~/.config/nvim/after/ftplugin/markdown.vim

vim.keymap.set("i", "``<Tab>", function() vim.snippet.expand("```$1\n$0\n```") end, { buffer = true })
vim.keymap.set("i", "*<Tab>",  function() vim.snippet.expand("*$1* $0") end, { buffer = true })
vim.keymap.set("i", "**<Tab>", function() vim.snippet.expand("**$1** $0") end, { buffer = true })

-- MATH FONT STYLES -----------------------------------------------------------

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
