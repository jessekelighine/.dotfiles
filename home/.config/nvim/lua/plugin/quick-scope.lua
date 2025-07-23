-- ~/.config/nvim/lua/plugin/quick-scope.lua

return {
	"unblevable/quick-scope",
	init = function()
		vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
		vim.g.qs_lazy_highlight = true
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			group = vim.api.nvim_create_augroup("QuickScopeColors", { clear = true }),
			command = [[
						highlight QuickScopePrimary   ctermfg=196 cterm=underline
						highlight QuickScopeSecondary ctermfg=81  cterm=underline
						]]
		})
	end,
}
