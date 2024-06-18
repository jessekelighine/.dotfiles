-- ~/.config/nvim/after/plugin/lspconfig.lua

vim.diagnostic.config {
	underline = false,
	virtual_text = false,
	signs = false,
	float = { border = "single" },
}

-- lspconfig ------------------------------------------------------------------

local lspconfig = require("lspconfig")

lspconfig.r_language_server.setup {
	virtual_text = false,
	signs = false,
}
