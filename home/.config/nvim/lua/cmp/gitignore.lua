-- ~/.config/nvim/lua/cmp/gitignore.lua
-- ~/.config/nvim/after/ftplugin/gitignore.vim

local snippet = require "snippet"
local filetype = "gitignore"
local language = filetype
local source = {}

function source:get_keyword_pattern() return [[:\k\+]] end
function source:resolve(item, callback) callback(snippet:add_doc(item, filetype)) end
source.is_available = snippet.is_available { language = language }

function source:complete(_, callback)
	callback {
		{ label = ":tex", insertText = snippet:get "tex/.gitignore" },
	}
end

return source
