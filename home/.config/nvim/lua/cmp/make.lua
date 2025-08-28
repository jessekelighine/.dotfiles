-- ~/.config/nvim/lua/cmp/make.lua
-- ~/.config/nvim/after/ftplugin/make.vim
-- ~/.config/nvim/snippets/make/

local snippet = require "snippet"
local filetype = "make"
local language = filetype
local source = {}

function source:get_keyword_pattern() return [[:\k\+]] end
function source:resolve(item, callback) callback(snippet:add_doc(item, filetype)) end
source.is_available = snippet.is_available { language = language }

function source:complete(_, callback)
	callback {
		{ label = ":sign",     insertText = snippet:get "make/sign.make" },
		{ label = ":markdown", insertText = snippet:get "make/markdown.make" },
		{ label = ":quarto",   insertText = snippet:get "make/quarto.make" },
		{ label = ":tex",      insertText = snippet:get "make/tex.make" },
		{ label = ":texfull",  insertText = snippet:get "make/tex-full.make" },
	}
end

return source
