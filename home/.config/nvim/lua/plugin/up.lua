-- ~/.config/nvim/lua/plugin/up.lua

require("up").map "<C-U>"
vim.g.up_nvim_action = function(dir) vim.cmd.cd(dir) end
