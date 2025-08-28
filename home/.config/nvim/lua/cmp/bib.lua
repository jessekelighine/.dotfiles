-- ~/.config/nvim/lua/cmp/bib.lua
-- ~/.config/nvim/after/ftplugin/bib.vim
-- ~/.config/nvim/snippets/bib/

local snippet = require "snippet"
local filetype = "bib"
local language = "bibtex"
local source = {}

function source:get_trigger_characters() return { "@" } end
function source:get_keyword_pattern() return [[@\k\+]] end
function source:resolve(item, callback) callback(snippet:add_doc(item, filetype)) end
source.is_available = snippet.is_available { language = language }

function source:complete(_, callback)
	callback {
		snippet.snippet { label = "@article",     insertText = snippet:get "bib/article.snippet.bib" },
		snippet.snippet { label = "@book",        insertText = snippet:get "bib/book.snippet.bib" },
		snippet.snippet { label = "@inbook",      insertText = snippet:get "bib/inbook.snippet.bib" },
		snippet.snippet { label = "@misc",        insertText = snippet:get "bib/misc.snippet.bib" },
		snippet.snippet { label = "@online",      insertText = snippet:get "bib/online.snippet.bib" },
		snippet.snippet { label = "@proceedings", insertText = snippet:get "bib/proceedings.snippet.bib" },
		snippet.snippet { label = "@thesis",      insertText = snippet:get "bib/thesis.snippet.bib" },
	}
end

return source
