-- init.lua

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

require("lazy").setup({

	"jessekelighine/vim-bunttex",
	"tpope/vim-repeat",
	"tpope/vim-vinegar",
	"R-nvim/R.nvim",

	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	},

	{
		"jessekelighine/miramare",
		config = function ()
			vim.g.miramare_transparent_background = 1
			vim.g.miramare_disable_italic_comment = 0
			vim.cmd([[ colorscheme miramare ]])
		end,
	},

	{
		"jessekelighine/vim-peekaboo",
		config = function ()
			vim.g.peekaboo_compact = 1
		end,
	},

	{
		"jessekelighine/vindent.vim",
		event = "VimEnter",
		init = function ()
			vim.g.vindent_motion_OO_prev = '[l'
			vim.g.vindent_motion_OO_next = ']l'
			vim.g.vindent_motion_less_prev = '[-'
			vim.g.vindent_motion_less_next = ']-'
			vim.g.vindent_motion_more_prev = '[='
			vim.g.vindent_motion_more_next = ']='
			vim.g.vindent_motion_XX_ss = '[p'
			vim.g.vindent_motion_XX_se = ']p'
			vim.g.vindent_motion_OX_ss = '[P'
			vim.g.vindent_motion_OX_se = ']P'
			vim.g.vindent_object_OO_ii = 'iI'
			vim.g.vindent_object_XX_ii = 'ii'
			vim.g.vindent_object_XX_ai = 'ai'
			vim.g.vindent_object_XX_aI = 'aI'
			vim.g.vindent_jumps = 1
			vim.g.vindent_begin = 1
			vim.g.vindent_count = 0
		end
	},

	{
		"junegunn/fzf.vim",
		dependencies = { "junegunn/fzf" },
		config = function ()
			vim.g.fzf_path = vim.fn.system({
				"which", "fzf",
				"| xargs realpath",
				"| xargs dirname",
				"| xargs dirname",
				"| xargs printf"
			})
			vim.cmd([[
			let &rtp ..= "," .. g:fzf_path
			let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
			let $FZF_DEFAULT_COMMAND = "rg --files --hidden"
			let g:fzf_preview_window = [ 'right:40%' ]
			let g:fzf_layout = { 'down': '~20%' }
			]])
			vim.keymap.set('n', '<C-B>', ':Buffers<CR>')
			vim.keymap.set('n', '<C-T>', ':Files<CR>')
			vim.keymap.set('n', '<C-F>', ':Lines<CR>')
		end,
	},

	{
		"junegunn/vim-easy-align",
		config = function ()
			vim.keymap.set({ 'x', 'n' }, 'ga', '<Plug>(EasyAlign)')
		end,
	},

	{
		"mbbill/undotree",
		config = function ()
			vim.keymap.set('n', '<leader>u', ':UndotreeToggle<CR>')
		end,
	},

	{
		"tpope/vim-surround",
		config = function ()
			vim.api.nvim_create_autocmd(
				{ "VimEnter", "BufNewFile", "BufRead" },
				{
					pattern = {"*"},
					callback = function ()
						vim.b.surround_49  = "（\r）"
						vim.b.surround_50  = "「\r」"
						vim.b.surround_51  = "《\r》"
						vim.b.surround_92  = "\\\r\\"
						vim.b.surround_97  = "\1anything: \1\r\1\1"
						vim.b.surround_122 = "\1anything(1): \1\r\2anything(2): \2"
					end
				}
			)
		end,
	},

})

-- git submodule add 'https://github.com/R-nvim/cmp-r'     main/start/cmp-r
-- git submodule add 'https://github.com/hrsh7th/nvim-cmp' main/start/nvim-cmp
