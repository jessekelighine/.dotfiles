-- ~/.config/nvim/lua/cmp/matlab.lua
-- ~/.config/nvim/after/ftplugin/matlab.vim
-- ~/.config/nvim/snippets/matlab/

local snippet = require "snippet"
local filetype = "matlab"
local language = filetype
local source = {}

function source:get_keyword_pattern() return [[:\k\+]] end
function source:resolve(item, callback) callback(snippet:add_doc(item, filetype)) end
source.is_available = snippet:is_available { language = language }

function source:complete(_, callback)
	local items = {
		{ label = ":skeleton", insertText = snippet:get "matlab/matlab_sign.m" },
		{ label = ":sign",     insertText = snippet:get "matlab/matlab_sign.m" },
		{ label = ":block",    insertText = snippet:get "matlab/matlab_block.m" },
		snippet.snippet { label = ":lambda",   insertText = "$1 = @($2) $0;" },
		snippet.snippet { label = ":function", insertText = "function $1 = $2($3)\n\t$0\nend" },
	}
	callback(items)
end

return source
