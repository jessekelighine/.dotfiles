-- ~/.config/nvim/after/plugin/lspconfig.lua
-- ~/.config/nvim/lua/plugin/lspconfig.lua

local lspconfig = require "lspconfig"

--- R -------------------------------------------------------------------------

lspconfig.r_language_server.setup {
	on_attach = function(client, _)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
	settings = {
		["r_language_server"] = {
			line_length_linter = { enable = false }
		}
	},
}

lspconfig.air.setup {
	on_attach = function(_, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup('AirFormatter', { clear = true }),
			buffer = bufnr,
			callback = function() vim.lsp.buf.format() end,
		})
	end,
}

--- LUA -----------------------------------------------------------------------

lspconfig.lua_ls.setup {
	vim.diagnostic.config {
		signs = true
	},
	settings = {
		Lua = {
			diagnostics = { globals = { "vim", "require", "hs", "spoon" }, },
			-- telemetry = { enable = false, },
			-- runtime = { version = 'LuaJIT', },
			-- workspace = { library = vim.api.nvim_get_runtime_file("", true) },
		},
	},
}

--- PYTHON --------------------------------------------------------------------

lspconfig.pyright.setup {}

--- BASH ----------------------------------------------------------------------

lspconfig.bashls.setup {
	vim.diagnostic.config { signs = true }
}
