-- ~/.config/nvim/lua/cmp/python.lua
-- ~/.config/nvim/after/ftplugin/python.vim
-- ~/.config/nvim/snippets/python/

local snippet = require "snippet"
local filetype = "python"
local language = "python"
local source = {}

function source:get_keyword_pattern() return [[:\k\+]] end
function source:resolve(item, callback) callback(snippet:add_doc(item, filetype)) end
source.is_available = snippet.is_available { language = language }

function source:complete(_, callback)
	callback {
		snippet.snippet { label = ':shebang',  insertText = snippet:get 'python/python_bang.py' },
		snippet.snippet { label = ':skeleton', insertText = snippet:get 'python/skeleton.py' },
		snippet.snippet { label = ':sign',     insertText = snippet:get 'python/sign.py' },
		snippet.snippet { label = ':block',    insertText = snippet:get 'python/block.py' },
	}
end

return source
