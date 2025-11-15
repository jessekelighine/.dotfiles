-- ~/.config/nvim/after/ftplugin/python.lua
-- ~/.config/nvim/after/ftplugin/python.vim

vim.keymap.set("i", '""<Tab>', function() vim.snippet.expand('"""\n$0\n"""') end, { buffer = true })
vim.keymap.set("i", '""<CR>', function() vim.snippet.expand('"""\n$0\n"""') end, { buffer = true })
