-- ~/.config/nvim/after/plugin/lspconfig.lua
-- ~/.config/nvim/lua/plugin/lspconfig.lua

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('LspAttach', { clear = true }),
	desc = "LSP Actions on Attach",
	callback = function()
		vim.opt.signcolumn = "yes:1"
	end
})

-- R --------------------------------------------------------------------------

vim.lsp.config("r_language_server", {
	on_attach = function(client, _)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
	settings = {
		["r_language_server"] = {
			line_length_linter = { enable = false }
		}
	},
})

vim.lsp.config("air", {
	on_attach = function(_, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup('AirFormatter', { clear = true }),
			buffer = bufnr,
			callback = function() vim.lsp.buf.format() end,
		})
	end,
})

vim.lsp.enable("r_language_server")
vim.lsp.enable("air")

-- LUA ------------------------------------------------------------------------

vim.lsp.config("lua_ls", {
	vim.diagnostic.config { signs = true },
	settings = {
		Lua = {
			diagnostics = { globals = { "vim", "require", "hs", "spoon" }, },
			-- telemetry = { enable = false, },
			-- runtime = { version = 'LuaJIT', },
			-- workspace = { library = vim.api.nvim_get_runtime_file("", true) },
		},
	},
})

vim.lsp.enable("lua_ls")

-- PYTHON ---------------------------------------------------------------------

vim.lsp.enable("pyright")

-- BASH -----------------------------------------------------------------------

vim.lsp.config("bashls", { vim.diagnostic.config { signs = true } })
vim.lsp.enable("bashls")

-- JULIA ----------------------------------------------------------------------

vim.lsp.enable("julials")
