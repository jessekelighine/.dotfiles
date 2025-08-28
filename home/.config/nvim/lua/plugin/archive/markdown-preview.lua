-- ~/.config/nvim/lua/plugin/markdown-preview.lua

return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = "cd app && yarn install",
	ft = { "markdown" },
	init = function() vim.g.mkdp_filetypes = { "markdown" } end,
	config = function() vim.g.mkdp_theme = "light" end,
}
