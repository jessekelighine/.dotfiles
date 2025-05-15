return {
	"junegunn/vim-easy-align",
	config = function()
		vim.keymap.set({ 'x', 'n' }, 'ga', '<Plug>(EasyAlign)')
	end,
}
