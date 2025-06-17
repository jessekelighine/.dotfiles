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
					map('gdd', vim.diagnostic.open_float, '[D]iagnostics')
					vim.opt.signcolumn = "yes:1"
					-- if vim.bo.filetype ~= "python" then
					-- 	map('<leader>fm', vim.lsp.buf.format, '[F]or[m]at', { "n", "x" })
					-- else
					-- 	vim.cmd [[
					-- 	nnoremap <silent><buffer> <leader>fm m':Black<CR>`'
					-- 	xnoremap <silent><buffer> <leader>fm   :Black<CR>
					-- 	]]
					-- end
				end
			})

			vim.diagnostic.config {
				signs = false,
				-- underline = false,
				-- virtual_text = false,
				float = { solid = true },
			}

			--- [[ Language Specific Configurations ]] ---

			local lspconfig = require("lspconfig")

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

			lspconfig.bashls.setup {
				vim.diagnostic.config { signs = true }
			}

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

			lspconfig.pyright.setup {}

			--[[ Border for Every Float ]]--

			local open_floating_preview_original = vim.lsp.util.open_floating_preview
			---@diagnostic disable-next-line: duplicate-set-field
			vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
				opts = opts or {}
				-- Force a Boarder
				opts.border = opts.border or {
					{ "┌", "FloatBorder" },
					{ "─", "FloatBorder" },
					{ "┐", "FloatBorder" },
					{ "│", "FloatBorder" },
					{ "┘", "FloatBorder" },
					{ "─", "FloatBorder" },
					{ "└", "FloatBorder" },
					{ "│", "FloatBorder" },
				}
				return open_floating_preview_original(contents, syntax, opts, ...)
			end

		end,
	},
}
