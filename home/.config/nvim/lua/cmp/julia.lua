-- ~/.config/nvim/lua/cmp/julia.lua
-- ~/.config/nvim/after/ftplugin/julia.vim
-- ~/.config/nvim/snippets/julia/

local snippet = require "snippet"
local filetype = "julia"
local language = "julia"
local source = {}

-- function source:get_trigger_characters() return { ":" } end
function source:get_keyword_pattern() return [[:\k\+]] end
function source:resolve(item, callback) callback(snippet:add_doc(item, filetype)) end
source.is_available = snippet.is_available { language = language }

function source:complete(_, callback)
	callback {
		snippet.snippet { label = ':skeleton', insertText = snippet:get "julia/skeleton.jl" },
		snippet.snippet { label = ':sign',     insertText = snippet:get "julia/sign.jl" },
		snippet.snippet { label = ':block',    insertText = '$0###############################################################################' },
		snippet.snippet { label = ':let',      insertText = 'let\n\t$0\nend' },
	}
end

return source
