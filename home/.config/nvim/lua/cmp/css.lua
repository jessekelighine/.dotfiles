-- ~/.config/nvim/lua/cmp/css.lua
-- ~/.config/nvim/after/ftplugin/css.vim
-- ~/.config/nvim/snippets/css/

local snippet = require "snippet"
local filetype = "css"
local language = filetype
local source = {}

function source:get_keyword_pattern() return [[:\k\+]] end
function source:resolve(item, callback) callback(snippet:add_doc(item, filetype)) end
source.is_available = snippet:is_available { language = language }

function source:complete(_, callback)
	local items = {
		{ label = ":quarto", insertText = snippet:get "css/quarto.css" },
		{ label = ":style",  insertText = snippet:get "css/style.css" },
	}
	callback(items)
end

return source
