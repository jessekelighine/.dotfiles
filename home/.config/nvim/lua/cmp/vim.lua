-- ~/.config/nvim/lua/cmp/vim.lua
-- ~/.config/nvim/after/ftplugin/vim.vim
-- ~/.config/nvim/snippets/vim/

local snippet = require "snippet"
local filetype = "vim"
local language = filetype
local source = {}

function source:get_keyword_pattern() return [[:\k\+]] end
function source:resolve(item, callback) callback(snippet:add_doc(item, filetype)) end
source.is_available = snippet.is_available { language = language }

function source:complete(_, callback)
	callback {
		{ label = ":tex",      insertText = snippet:get "vim/tex.vim" },
		{ label = ":markdown", insertText = snippet:get "vim/markdown.vim" },
		{ label = ":block",    insertText = '"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""' },
		snippet.snippet {
			label = ":current_char",
			insertText = "let ${1:l:current_char} = getline(\".\")[col(\".\") - 1]",
		},
	}
end

return source
