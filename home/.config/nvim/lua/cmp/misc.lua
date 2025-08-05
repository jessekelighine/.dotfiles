-- ~/.config/nvim/lua/cmp/misc.lua

local source = {}

function source:get_keyword_pattern() return [[:\k\+]] end

function source:complete(_, callback)
	local items = {
		{ label = ":path",     insertText = vim.fn.expand("%:p") },
		{ label = ":date",     insertText = vim.fn.strftime("%F") },
		{ label = ":website",  insertText = vim.fn['snippet#GetAuthor']() },
		{ label = ":shruggie", insertText = "¯\\_(ツ)_/¯" },
	}
	callback(items)
end

return source
