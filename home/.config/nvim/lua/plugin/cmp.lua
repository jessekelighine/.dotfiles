-- ~/.config/nvim/lua/plugin/cmp.lua
-- ~/.config/nvim/after/plugin/cmp.lua

return {
	"hrsh7th/nvim-cmp",
	config = function()
		local cmp = require "cmp"
		local icons = require "lsp-icons"
		cmp.setup {
			snippet = {
				expand = function(args)
					vim.snippet.expand(args.body)
				end
			},
			sources = {
				{ name = "cmp_r" },
			},
			mapping = cmp.mapping.preset.insert {
				["<Tab>"] = cmp.mapping.confirm { select = true },
				["<CR>"]  = cmp.mapping.confirm { select = false },
			},
			window = {
				documentation = cmp.config.window.bordered {
					border = "single"
				}
			},
			formatting = {
				format = function(_, item)
					item.kind = " " .. ( icons[item.kind] or "∘" ) .. " " .. item.kind
					return item
				end,
			}
		}
	end,
}
