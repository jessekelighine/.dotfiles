return	{
	"tpope/vim-surround",
	config = function()
		vim.api.nvim_create_autocmd(
			{ "VimEnter", "BufNewFile", "BufRead" },
			{
				pattern = "*",
				group = vim.api.nvim_create_augroup("VimSurround", { clear = true }),
				callback = function()
					vim.b.surround_49  = "（\r）"
					vim.b.surround_50  = "「\r」"
					vim.b.surround_51  = "《\r》"
					vim.b.surround_52  = "〈\r〉"
					vim.b.surround_92  = "\\\r\\"
					vim.b.surround_97  = "\1anything: \1\r\1\1"
					vim.b.surround_122 = "\1anything(1): \1\r\2anything(2): \2"
				end,
			}
		)
	end,
}
