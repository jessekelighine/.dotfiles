-- ~/.config/nvim/lua/cmp/lua.lua
-- ~/.config/nvim/after/ftplugin/lua.vim
-- ~/.config/nvim/snippets/lua/

local snippet = require "snippet"
local filetype = "lua"
local language = filetype
local source = {}

function source:get_keyword_pattern() return [[:\k\+]] end
function source:resolve(item, callback) callback(snippet:add_doc(item, filetype)) end
source.is_available = snippet:is_available { language = language }

function source:complete(_, callback)
	local items = {
		snippet.snippet { label = ":block",   insertText = "$0-------------------------------------------------------------------------------" },
		snippet.snippet { label = ":ternary", insertText = "$1 and $2 or $0" },
	}
	callback(items)
end

return source
