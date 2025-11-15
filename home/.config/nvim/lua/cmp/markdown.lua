-- ~/.config/nvim/lua/cmp/markdown.lua
-- ~/.config/nvim/after/ftplugin/markdown.vim
-- ~/.config/nvim/snippets/markdown/

local snippet = require "snippet"
local filetype = "markdown"
local source = {}

function source:get_keyword_pattern() return [[:\k\+]] end
function source:resolve(item, callback) callback(snippet:add_doc(item, filetype)) end
source.is_available = function()
	if vim.bo.filetype == "markdown" then return true end
	if vim.bo.filetype == "quarto" then return true end
	return false
end

function source:complete(_, callback)
	callback {
		{
			label = ":skeleton",
			insertText = snippet:get "markdown/skeleton.md",
			documentation = snippet.wrap_code(snippet:get "markdown/skeleton.md", "yaml"),
		},
		snippet.snippet { label = ":comment", insertText = "<!-- $0 -->" },
		snippet.snippet { label = ":ahref",   insertText = "<a href=\"$1\">$0</a>" },
		snippet.snippet { label = ":img",     insertText = "<img src=\"$0\" loading=\"lazy\" />" },
		snippet.snippet { label = ":ruby",    insertText = "<ruby><rb>$1</rb><rp>（</rp><rt>$2</rt><rp>）</rp></ruby>" },
	}
end

return source
