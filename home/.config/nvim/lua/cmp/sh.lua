-- ~/.config/nvim/lua/cmp/sh.lua
-- ~/.config/nvim/after/ftplugin/sh.vim
-- ~/.config/nvim/snippets/sh/

local snippet = require "snippet"
local filetype = "sh"
local language = "bash"
local source = {}

function source:get_keyword_pattern() return [[:\k\+]] end
function source:resolve(item, callback) callback(snippet:add_doc(item, filetype)) end
source.is_available = snippet:is_available { language = language }

function source:complete(_, callback)
	local items = {
		{ label = ":skeleton", insertText = snippet:get "sh/shebang-env.sh" },
		{ label = ":sign",     insertText = snippet:get "sh/sign.sh" },
		snippet.snippet { label = ":block", insertText = "$0###############################################################################" },
	}
	callback(items)
end

return source
