-- ~/.config/nvim/lua/init.lua

vim.loader.enable()
vim.opt.winborder = "single"
vim.diagnostic.config {
	signs = false,
	float = { solid = true },
}

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('HighlightYank', { clear = true }),
	callback = function() vim.hl.on_yank() end,
})

-- VIM.PACK -------------------------------------------------------------------

vim.pack.add({
	{ src = "https://github.com/R-nvim/R.nvim" },
	{ src = "https://github.com/folke/lazydev.nvim" },
	{ src = "https://github.com/github/copilot.vim" },
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/jessekelighine/miramare" },
	{ src = "https://github.com/jessekelighine/up.nvim" },
	{ src = "https://github.com/jessekelighine/vindent.nvim" },
	{ src = "https://github.com/junegunn/vim-easy-align" },
	{ src = "https://github.com/mbbill/undotree" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/tpope/vim-surround" },
	{ src = "https://github.com/tpope/vim-repeat" },
	{ src = "https://github.com/unblevable/quick-scope" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
})

vim.pack.add({
	{ src = "https://github.com/jessekelighine/vim-bunttex" },
}, { load = false })

require "plugin.cmp"
require "plugin.copilot"
require "plugin.lazydev"
require "plugin.lspconfig"
require "plugin.miramare"
require "plugin.oil"
require "plugin.quick-scope"
require "plugin.r-nvim"
require "plugin.telescope"
require "plugin.treesitter"
require "plugin.undotree"
require "plugin.up"
require "plugin.vim-bunttex"
require "plugin.vim-easy-align"
require "plugin.vim-surround"
require "plugin.vindent"
