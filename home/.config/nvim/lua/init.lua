-- ~/.config/nvim/lua/init.lua

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('HighlightYank', { clear = true }),
	callback = function() vim.hl.on_yank() end,
})

vim.loader.enable()
vim.opt.winborder = "single"
vim.diagnostic.config {
	signs = false,
	float = { solid = true },
}

-- Lazy.nvim ------------------------------------------------------------------

-- For Neovim 0.12 and later, lazy.nvim is no longer needed and we can use the
-- built-in package manager `vim.pack`.

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup {
	spec = {{ import = "plugin" }},
	ui = { border = "single" },
}
