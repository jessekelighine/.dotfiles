-- ~/.config/nvim/after/plugin/cmp.lua
-- ~/.config/nvim/lua/plugin/cmp.lua
-- ~/.config/nvim/lua/cmp/

-- CUSTOM CMP SOURCES ---------------------------------------------------------

local cmp = require "cmp"
local config = cmp.get_config()
local custom_sources_path = vim.fn.stdpath("config") .. "/lua/cmp"
local custom_sources = vim.fn.readdir(custom_sources_path)
local source_prefix = "custom-"

for _, source_file in ipairs(custom_sources) do
	local source_root = string.gsub(source_file, "%.lua$", "")
	local source_name = source_prefix .. source_root
	local source = require("cmp." .. source_root)
	cmp.register_source(source_name, source)
	table.insert(config.sources, { name = source_name })
end

cmp.setup(config)
