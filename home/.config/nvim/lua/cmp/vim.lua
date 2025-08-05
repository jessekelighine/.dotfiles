-- ~/.config/nvim/lua/cmp/vim.lua
-- ~/.config/nvim/after/ftplugin/vim.vim
-- ~/.config/nvim/snippets/vim/

local snippet = require "snippet"
local filetype = "vim"
local language = filetype
local source = {}

function source:get_keyword_pattern() return [[:\k\+]] end
function source:resolve(item, callback) callback(snippet:add_doc(item, filetype)) end
source.is_available = snippet:is_available { language = language }

function source:complete(_, callback)
	local items = {
		{ label = ":tex",      insertText = snippet:get "vim/tex.vim" },
		{ label = ":markdown", insertText = snippet:get "vim/markdown.vim" },
	}
	callback(items)
end

return source
