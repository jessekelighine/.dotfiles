return {
	{
		"neovim/nvim-lspconfig",

		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},

		config = function()

			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or 'n'
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
					end
					map('<leader>D',  vim.diagnostic.open_float, '[D]iagnostics')
					map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
					if vim.bo.filetype ~= "python" then
						map('<leader>fm', vim.lsp.buf.format, '[F]or[m]at', { "n", "x" })
					else
						vim.cmd [[
						nnoremap <silent><buffer> <leader>fm m':Black<CR>`'
						xnoremap <silent><buffer> <leader>fm   :Black<CR>
						]]
					end
					vim.opt.signcolumn = "yes:1"
				end
			})

			vim.diagnostic.config {
				signs = false,
				-- underline = false,
				-- virtual_text = false,
				float = { solid = true },
			}

			-- starting from the NE corner and proceed clock-wise
			local border = {
				{ "┌", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "┐", "FloatBorder" },
				{ "│", "FloatBorder" },
				{ "┘", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "└", "FloatBorder" },
				{ "│", "FloatBorder" },
			}

			local lspconfig = require("lspconfig")
			local handlers = {
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
			}

			--- [[ Language Specific Configurations ]] ---

			lspconfig.lua_ls.setup {
				vim.diagnostic.config { handlers = handlers, signs = true },
				settings = {
					Lua = {
						diagnostics = { globals = { "vim", "require", "hs", "spoon" }, },
						-- telemetry = { enable = false, },
						-- runtime = { version = 'LuaJIT', },
						-- workspace = { library = vim.api.nvim_get_runtime_file("", true) },
					},
				},
			}

			lspconfig.bashls.setup { vim.diagnostic.config { handlers = handlers, signs = true } }

			lspconfig.r_language_server.setup {
				settings = {
					["r_language_server"] = {
						line_length_linter = { enable = false }
					}
				}
			}

			lspconfig.pyright.setup {}

			--- [[ Overwrite `open_floating_preview` ]] ---

			local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
			---@diagnostic disable-next-line: duplicate-set-field
			function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
				opts = opts or {}
				---@diagnostic disable-next-line: inject-field
				opts.border = opts.border or border
				return orig_util_open_floating_preview(contents, syntax, opts, ...)
			end

		end,
	},
}
