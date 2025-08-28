-- ~/.config/nvim/lua/snippet.lua
-- ~/.config/nvim/lua/cmp/

local module = {}

module.default_snippet_path = vim.fn.stdpath("config") .. "/snippets"
module.snippet_path = module.default_snippet_path

---@param item table cmp item table
---@return table item cmp item table with snippet format
function module.snippet(item)
	item.insertTextFormat = vim.lsp.protocol.InsertTextFormat.Snippet
	item.kind = item.kind or vim.lsp.protocol.CompletionItemKind.Snippet
	return item
end

-- READ SNIPPET FILE ----------------------------------------------------------

---@param filename string filename 
---@return string content of the snippet file as one string
local readfile = function(filename)
	local file = io.open(filename, "r")
	if not file then return "" end
	local content = file:read("*all")
	file:close()
	return content:sub(1, -2)
end

---@param ... string path to snippet file
---@return string content of the snippet file as one string
function module:get(...)
	local file = table.concat({ self.snippet_path, ... }, "/")
	return readfile(file)
end

-- DOCUMENTATION --------------------------------------------------------------

---@param code string code to wrap in markdown format
---@param filetype string filetype/language name
---@return string code code wrapped in a code block in markdown format
function module.wrap_code(code, filetype)
	filetype = filetype or "txt"
	local output = ""
	output = output .. "**Filetype**: " .. "*" .. filetype .. "*" .. "\n"
	output = output .. "------" .. "\n"
	output = output .. "```" .. filetype .. "\n"
	output = output .. code .. "\n"
	output = output .. "```"
	return output
end

---@param item table cmp item table
---@return table item cmp item table with documentation
function module:add_doc(item, language)
	if item.documentation then return item end
	item.documentation = self.wrap_code(item.insertText, language)
	return item
end

-- AVAILABILITY ---------------------------------------------------------------

---In Neovim 0.12 and later, vim.treesitter.get_parser will
---return nil if no parser is available for the current buffer, so this
---implementation with pcall needs to be changed in the future.
---@param language string language name
---@return boolean boolean whether the current position is in the
---language specified by `language` based on treesitter parser.
local is_available_by_language = function(language)
	local ok, parser = pcall(vim.treesitter.get_parser)
	if not ok or parser == nil then return false end
	local line = vim.fn.line(".")
	local col = vim.fn.col(".")
	local lang = parser:language_for_range({line, col, line, col}):lang()
	return language == lang
end

---@param filetype string filetype name
---@return boolean boolean whether the current buffer's filetype matches the
---given filetype.
local is_available_by_filetype = function(filetype)
	return vim.bo.filetype == filetype
end

---Returns a function that checks whether the source is available based on
---`filetype` and/or `language` information as specified in `opts`. The
---`language` check is based on treesitter parser (useful for code blocks in
---markdown); the `filetype` check is based on the current buffer's filetype.
---@param opts table table with fields `filetype` and/or `language`.
---@return function is_available function that checks if source is available
function module.is_available(opts)
	return function()
		if is_available_by_filetype(opts.filetype) then return true end
		if is_available_by_language(opts.language) then return true end
		return false
	end
end

return module
