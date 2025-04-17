-- init.lua

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function() vim.highlight.on_yank() end,
})

-- Lazy.nvim ------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {

	{ import = "plugins" },

	"tpope/vim-sleuth",
	"tpope/vim-repeat",
	"tpope/vim-vinegar",

	{
		"github/copilot.vim",
		config = function()
			-- vim.cmd [[
			-- 		imap <silent><script><expr> <C-p> copilot#Accept("\<CR>")
			-- 		let g:copilot_no_tab_map = v:true
			-- 		]]
		end
	},

	{
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
	},

	{
		"unblevable/quick-scope",
		init = function()
			vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
			vim.g.qs_lazy_highlight = true
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "*",
				group = vim.api.nvim_create_augroup("qs_colors", { clear = true }),
				command = [[
						highlight QuickScopePrimary   ctermfg=196 cterm=underline
						highlight QuickScopeSecondary ctermfg=81  cterm=underline
						]]
			})
		end,
	},

	{
		"jessekelighine/miramare",
		config = function()
			vim.g.miramare_transparent_background = 1
			vim.g.miramare_disable_italic_comment = 0
			vim.cmd.colorscheme "miramare"
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<C-t>", builtin.find_files)
			vim.keymap.set("n", "<C-f>", builtin.live_grep)
			vim.keymap.set("n", "<C-b>", builtin.buffers)
			vim.keymap.set("n", "<C-s>", builtin.spell_suggest)
			require("telescope").setup {
				defaults = {
					mappings = {
						i = {
							["<C-k>"] = "move_selection_previous",
							["<C-j>"] = "move_selection_next",
						}
					}
				}
			}
		end,
	},

	{
		"junegunn/vim-easy-align",
		config = function()
			vim.keymap.set({ 'x', 'n' }, 'ga', '<Plug>(EasyAlign)')
		end,
	},

	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set('n', '<leader>u', ':UndotreeToggle<CR>')
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			cmp.setup {
				sources = {{ name = "cmp_r" }},
				mapping = cmp.mapping.preset.insert {
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end, { "i", "s" }),
				},
			}
			require("cmp_r").setup {}
		end,
	},

	{
		"R-nvim/R.nvim",
		lazy = false,
		dependencies = { "R-nvim/cmp-r" },
		config = function()
			require("r").setup {
				pdfviewer = "",
				nvimpager = "tab", -- how help pages are viewed
				R_args = { "--quiet", "--no-save" },
				view_df = {
					open_app = ":tabnew %s | setlocal ft=csv",
					csv_sep = "\t",
					n_lines = -1,
				},
				disable_cmds = {
					"RSendLine",
					"RCustomStart",
					"RSPlot",
					"RSaveClose",
				},
				hook = {
					on_filetype = function()
						vim.api.nvim_buf_set_keymap(0, "n", "<leader>d", "<Plug>RDSendLine", {})
						vim.api.nvim_buf_set_keymap(0, "v", "<leader>d", "<Plug>RSendSelection", {})
						-- vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine:noh<CR>", {})
						-- vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
					end
				},
			}
		end,
	},

}
