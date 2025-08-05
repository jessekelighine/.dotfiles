-- ~/.config/nvim/lua/snippet.lua
-- ~/.config/nvim/lua/cmp/

local module = {}

module.default_snippet_path = vim.fn.stdpath("config") .. "/snippets"
module.snippet_path = module.default_snippet_path

---@param filename string filename 
---@return string content of the snippet file as one string
local readfile = function(filename)
	local file = io.open(filename, "r")
	if not file then return "" end
	local content = file:read("*all")
	file:close()
	return content:sub(1, -2)
end

---@param code string code to wrap
---@param language string language name
---@return string code code wrapped in a code block in markdown format
function module.wrap_code(code, language)
	local output = ""
	output = output .. "**Filetype**: " .. ( "*" .. language .. "*" ) .. "\n"
	output = output .. "------" .. "\n"
	output = output .. "```" .. language .. "\n"
	output = output .. code .. "\n"
	output = output .. "```"
	return output
end

---@param ... string path to snippet file
---@return string content of the snippet file as one string
function module:get(...)
	local file = table.concat({ self.snippet_path, ... }, "/")
	return readfile(file)
end

---@param item table nvim-cmp item table
---@return table item nvim-cmp item table with snippet format
function module.snippet(item)
	-- This is lifted from nvim-cmp's source code so I don't need to require "cmp".
	-- See nvim-cmp's [documentation](https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/types/lsp.lua) for the magic numbers.
	local snippet_format = 2
	local snippet_kind = 15
	item.insertTextFormat = snippet_format
	item.kind = snippet_kind
	return item
end

---@param item table nvim-cmp item table
---@return table item nvim-cmp item table with documentation
function module:add_doc(item, language)
	if item.documentation then return item end
	item.documentation = self.wrap_code(item.insertText, language)
	return item
end

---NOTE: In Neovim 0.12 and later, vim.treesitter.get_parser will
---return nil if no parser is available for the current buffer, so this
---implementation with pcall needs to be changed in the future.
---@param language string language name
---@return boolean boolean whether the current position is in the
---language specified by `language` based on treesitter parser.
function module.is_available_by_language(language)
	local ok, parser = pcall(vim.treesitter.get_parser)
	if not ok or parser == nil then return false end
	local line = vim.fn.line(".")
	local lang = parser:language_for_range({line, 0, line, 0}):lang()
	return language == lang
end

---@param filetype string filetype name
---@return boolean boolean whether the current buffer's filetype matches the
---given filetype.
function module.is_available_by_filetype(filetype)
	return vim.bo.filetype == filetype
end

---@param opts table table with fileds `filetype` and `language`, checks
---whether the source is available using filetype and treesitter information.
---@return function is_available function that checks if source is available
function module:is_available(opts)
	return function()
		if self.is_available_by_filetype(opts.filetype) then return true end
		if self.is_available_by_language(opts.language) then return true end
		return false
	end
end

return module
