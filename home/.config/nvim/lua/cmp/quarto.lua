-- ~/.config/nvim/lua/cmp/quarto.lua
-- ~/.config/nvim/after/ftplugin/quarto.vim
-- ~/.config/nvim/snippets/quarto/

local snippet = require "snippet"
local filetype = "quarto"
local language = filetype
local source = {}

function source:get_keyword_pattern() return [[:\k\+]] end
function source:resolve(item, callback) callback(snippet:add_doc(item, filetype)) end
source.is_available = snippet:is_available { language = language }

---@param opts table with fields "env", "append", and "content"
---@return string snippet quarto block snippet
local block = function(opts)
	opts.tags = opts.tags or "$1"
	opts.content = opts.content or "$0"
	local block = ""
	block = block .. ":::{" .. opts.tags .. "}" .. "\n"
	block = block .. opts.content .. "\n"
	block = block .. ":::"
	return block
end

function source:complete(_, callback)
	local items = {

		{
			label = ":skeleton",
			insertText = snippet:get "quarto/skeleton.qmd",
			documentation = snippet.wrap_code(snippet:get "quarto/skeleton.qmd", "yaml"),
		},

		-- MISC:
		snippet.snippet { label = ":comment", insertText = "<!-- $0 -->" },

		-- BLOCKS:
		snippet.snippet { label = ":block",       insertText = block {} },
		snippet.snippet { label = ":tip",         insertText = block { tags = ".callout-tip" } },
		snippet.snippet { label = ":note",        insertText = block { tags = ".callout-note" } },
		snippet.snippet { label = ":warning",     insertText = block { tags = ".callout-warning" } },
		snippet.snippet { label = ":important",   insertText = block { tags = ".callout-important" } },
		snippet.snippet { label = ":caution",     insertText = block { tags = ".callout-caution" } },
		snippet.snippet { label = ":proof",       insertText = block { tags = ".proof" } },
		snippet.snippet { label = ":definition",  insertText = block { tags = "#def-$1 name=\"$2\"" } },
		snippet.snippet { label = ":theorem",     insertText = block { tags = "#thm-$1 name=\"$2\"" } },
		snippet.snippet { label = ":lemma",       insertText = block { tags = "#lem-$1 name=\"$2\"" } },
		snippet.snippet { label = ":corollary",   insertText = block { tags = "#cor-$1 name=\"$2\"" } },
		snippet.snippet { label = ":proposition", insertText = block { tags = "#prop-$1 name=\"$2\"" } },
		snippet.snippet { label = ":remark",      insertText = block { tags = "#rem-$1 name=\"$2\"" } },
		snippet.snippet { label = ":exercise",    insertText = block { tags = "#exr-$1 name=\"$2\"" } },
		snippet.snippet { label = ":solution",    insertText = block { tags = "#sol-$1 name=\"$2\"" } },
		snippet.snippet { label = ":conjecture",  insertText = block { tags = "#cjn-$1 name=\"$2\"" } },
		snippet.snippet { label = ":eg",          insertText = block { tags = "#exm-$1 name=\"$2\"" } },
		snippet.snippet { label = ":figure",      insertText = block { tags = "#fig-$1 fig-env=\"figure*\" name=\"$2\"" } },
		snippet.snippet { label = ":table",       insertText = block { tags = "#tab-$1 name=\"$2\"" } },

	}
	callback(items)
end

return source
