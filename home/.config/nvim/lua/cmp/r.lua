-- ~/.config/nvim/lua/cmp/r.lua
-- ~/.config/nvim/after/ftplugin/r.vim
-- ~/.config/nvim/snippets/r/

local snippet = require "snippet"
local filetype = "r"
local language = filetype
local source = {}

function source:get_keyword_pattern() return [[:\k\+]] end
function source:resolve(item, callback) callback(snippet:add_doc(item, filetype)) end
source.is_available = snippet:is_available { language = language }

function source:complete(_, callback)
	local items = {
		snippet.snippet { label = ":skeleton",   insertText = snippet:get "r/skeleton.R" },
		snippet.snippet { label = ":sign",       insertText = snippet:get "r/sign.R" },
		snippet.snippet { label = ":future",     insertText = snippet:get "r/future.R" },
		snippet.snippet { label = ":library",    insertText = snippet:get "r/library.R" },
		snippet.snippet { label = ":ggsave",     insertText = snippet:get "r/ggsave.R" },
		snippet.snippet { label = ":ggchinese",  insertText = snippet:get "r/ggplotChinese.R" },
		snippet.snippet { label = ":robust",     insertText = snippet:get "r/robust.R" },
		snippet.snippet { label = ":log",        insertText = snippet:get "r/logfile.R" },
		snippet.snippet { label = ":consolelog", insertText = snippet:get "r/consolelog.R" },
		snippet.snippet { label = ":mode",       insertText = snippet:get "r/modus.R" },
		snippet.snippet { label = ":rm",         insertText = snippet:get "r/rm.R" },
		snippet.snippet { label = ":timer",      insertText = snippet:get "r/timer.R" },
		snippet.snippet { label = ":curry",      insertText = snippet:get "r/curry.R" },
		snippet.snippet { label = ":showtext",   insertText = snippet:get "r/showtext.R" },
		snippet.snippet { label = ":datatable",  insertText = snippet:get "r/datatable.R" },
		snippet.snippet { label = ":block",      insertText = "$0###############################################################################" },
		snippet.snippet { label = ":for",        insertText = "for ($1 in $2) {\n\t$0\n}" },
		snippet.snippet { label = ":function",   insertText = "$1 <- function($2) {\n\t$0\n}" },
	}
	callback(items)
end

return source
