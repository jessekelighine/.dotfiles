-- ~/.config/nvim/lua/cmp/gitignore.lua
-- ~/.config/nvim/after/ftplugin/gitignore.vim
-- ~/.config/nvim/snippets/gitignore/

local snippet = require "snippet"
local filetype = "gitignore"
local language = filetype
local source = {}

function source:get_keyword_pattern() return [[:\k\+]] end
function source:resolve(item, callback) callback(snippet:add_doc(item, filetype)) end
source.is_available = snippet:is_available { filetype = filetype, language = language }

function source:complete(_, callback)
	local items = {
		{ label = ":tex", insertText = snippet:get "tex/.gitignore" },
	}
	callback(items)
end

return source
