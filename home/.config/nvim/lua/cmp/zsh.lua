-- ~/.config/nvim/lua/cmp/zsh.lua
-- ~/.config/nvim/after/ftplugin/zsh.vim
-- ~/.config/nvim/snippets/zsh/

local snippet = require "snippet"
local filetype = "zsh"
local language = filetype
local source = {}

function source:get_keyword_pattern() return [[:\k\+]] end
function source:resolve(item, callback) callback(snippet:add_doc(item, filetype)) end
source.is_available = snippet.is_available { filetype = filetype, language = language }

function source:complete(_, callback)
	callback {
		{ label = ":skeleton", insertText = snippet:get "zsh/shebang.zsh" },
		{ label = ":sign",     insertText = snippet:get "zsh/sign.zsh" },
	}
end

return source
