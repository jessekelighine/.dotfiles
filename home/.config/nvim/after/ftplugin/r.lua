-- ~/.config/nvim/after/ftplugin/r.lua
-- ~/.config/nvim/after/ftplugin/r.vim

-- R MACROS -------------------------------------------------------------------

vim.keymap.set("i", "%<Tab>", function() vim.snippet.expand("%$1%$0") end, { buffer = true })
vim.keymap.set("i", "^<Tab>", function() vim.snippet.expand("^($1)$0") end, { buffer = true })
