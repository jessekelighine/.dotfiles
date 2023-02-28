-- complete.lua

vim.cmd [[packadd nvim-cmp]]

vim.cmd [[packadd cmp-buffer]]
vim.cmd [[packadd cmp-path]]
vim.cmd [[packadd cmp-nvim-lsp]]

local cmp = require 'cmp'

cmp.setup {

	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},

	mapping = {
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
		["<C-o>"] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"]  = cmp.mapping.confirm({ select = true }),
	},

	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'buffer' },
		{ name = 'path' },
	},
}

-- lspconfig ------------------------------------------------------------------

vim.cmd [[packadd nvim-lspconfig]]

local lsp = require 'lspconfig'
local cmp_lsp = require 'cmp_nvim_lsp'

lsp.vimls.setup {
	capabilities =
	cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
}
