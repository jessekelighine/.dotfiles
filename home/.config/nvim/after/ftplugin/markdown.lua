-- ~/.config/nvim/after/ftplugin/markdown.lua
-- ~/.config/nvim/after/ftplugin/markdown.vim

vim.keymap.set("i", ":c<Tab>", function() vim.snippet.expand("<!-- $0 -->") end, { buffer = true })
vim.keymap.set("i", "``<Tab>", function() vim.snippet.expand("```$1\n$0\n```") end, { buffer = true })
vim.keymap.set("i", "*<Tab>",  function() vim.snippet.expand("*$1* $0") end, { buffer = true })
vim.keymap.set("i", "**<Tab>", function() vim.snippet.expand("**$1** $0") end, { buffer = true })
