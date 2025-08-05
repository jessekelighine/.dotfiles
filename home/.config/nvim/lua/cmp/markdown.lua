-- ~/.config/nvim/lua/cmp/markdown.lua
-- ~/.config/nvim/after/ftplugin/markdown.vim
-- ~/.config/nvim/snippets/markdown/

local snippet = require "snippet"
local filetype = "markdown"
local language = filetype
local source = {}

function source:get_keyword_pattern() return [[:\k\+]] end
function source:resolve(item, callback) callback(snippet:add_doc(item, filetype)) end
source.is_available = snippet:is_available { language = language }

function source:complete(_, callback)
	local items = {
		{
			label = ":skeleton",
			insertText = snippet:get "markdown/skeleton.md",
			documentation = snippet.wrap_code(snippet:get "markdown/skeleton.md", "yaml"),
		},
		snippet.snippet { label = ":comment",  insertText = "<!-- $0 -->" },
	}
	callback(items)
end

return source
