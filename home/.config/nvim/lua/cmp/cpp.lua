-- ~/.config/nvim/lua/cmp/cpp.lua
-- ~/.config/nvim/after/ftplugin/cpp.vim
-- ~/.config/nvim/snippets/cpp/

local snippet = require "snippet"
local filetype = "cpp"
local language = filetype
local source = {}

function source:get_keyword_pattern() return [[:\k\+]] end
function source:resolve(item, callback) callback(snippet:add_doc(item, filetype)) end
source.is_available = snippet:is_available { language = language }

function source:complete(_, callback)
	local items = {
		{ label = ":skeleton", insertText = snippet:get "cpp/skeleton.cpp" },
		{ label = ":sign",     insertText = snippet:get "cpp/sign.cpp" },
		{ label = ":rcpp",     insertText = snippet:get "cpp/Rcpp.cpp" },
		{ label = ":arma",     insertText = snippet:get "cpp/RcppArmadillo.cpp" },
		{ label = ":block",    insertText = snippet:get "cpp/block.cpp" },
		snippet.snippet { label = ":class",   insertText = snippet:get "cpp/class.cpp" },
		snippet.snippet { label = ":header",  insertText = snippet:get "cpp/header.cpp" },
		snippet.snippet { label = ":comment", insertText = "/* $0 */" },
		snippet.snippet { label = ":for",     insertText = "for ( int $1 { 0 }; $1 < $2; $1++ )$0" },
		snippet.snippet { label = ":out",     insertText = "std::cout << $0 << std::endl;" },
		snippet.snippet { label = ":in",      insertText = "std::cin >> $0;" },
	}
	callback(items)
end

return source
