-- ~/.config/nvim/lua/plugin/cmp.lua
-- ~/.config/nvim/after/plugin/cmp.lua

return {
	"hrsh7th/nvim-cmp",
	config = function()

		local cmp = require "cmp"
		local icons = require "completion-item-icons"
		local sources = {
			{ name = "cmp_r" },
		}

		-- ADD CUSTOM SOURCES:
		local custom_sources_dir = vim.fn.stdpath("config") .. "/lua/cmp"
		local custom_sources = vim.fn.readdir(custom_sources_dir)
		local custom_source_prefix = "custom-"
		for _, source_file in ipairs(custom_sources) do
			local source_root = string.gsub(source_file, "%.lua$", "")
			local source_name = custom_source_prefix .. source_root
			local source = require("cmp." .. source_root)
			cmp.register_source(source_name, source)
			table.insert(sources, { name = source_name })
		end

		cmp.setup {
			sources = sources,
			snippet = {
				expand = function(args)
					vim.snippet.expand(args.body)
				end
			},
			mapping = cmp.mapping.preset.insert {
				["<Tab>"] = cmp.mapping.confirm { select = true },
				["<CR>"]  = cmp.mapping.confirm { select = false },
			},
			window = {
				completion = {
					border = "single",
					winhighlight = "Normal:CmpNormal",
				},
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
