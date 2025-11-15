-- ~/.config/nvim/lua/cmp/misc.lua

local source = {}

function source:get_keyword_pattern() return [[:\k\+]] end

function source:complete(_, callback)
	callback {
		{ label = ":path",     insertText = vim.fn.expand("%:p") },
		{ label = ":date",     insertText = vim.fn.strftime("%F") },
		{ label = ":website",  insertText = vim.fn['snippet#Sign']("website") },
		{ label = ":email",    insertText = vim.fn['snippet#Sign']("email") },
		{ label = ":name",     insertText = vim.fn['snippet#Sign']("name") },
		{ label = ":shruggie", insertText = "¯\\_(ツ)_/¯" },
	}
end

return source
