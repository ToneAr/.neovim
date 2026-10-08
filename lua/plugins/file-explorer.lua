return {
	{
		'stevearc/oil.nvim',
		opts = {
			default_file_explorer = true,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			-- Single highlight for every icon so it follows the system accent
			columns = { { "icon", highlight = "OilIcon" } },
		},
		dependencies = {
			{ "nvim-mini/mini.icons", opts = {} }
		},
		init = function()
			-- Fallback for colorschemes that don't define OilIcon
			local function link_icon()
				vim.api.nvim_set_hl(0, "OilIcon", { default = true, link = "OilDirIcon" })
			end
			link_icon()
			vim.api.nvim_create_autocmd("ColorScheme", { callback = link_icon })
		end,
		lazy = false,
	},
	{
		"mikavilpas/yazi.nvim",
		version = "*",
		event = "VeryLazy",
		dependencies = {
			{ "nvim-lua/plenary.nvim", lazy = true },
		},
		keys = {
			{
				"<leader>-",
				mode = { "n", "v" },
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				"<leader>cw",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				"<c-up>",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		opts = {
			open_for_directories = false,
			keymaps = {
				show_help = "<f1>",
			},
		},
		init = function()
			vim.g.loaded_netrwPlugin = 1
		end,
	},
	-- {
	-- 	"nvim-neo-tree/neo-tree.nvim",
	-- 	branch = "v3.x",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"MunifTanjim/nui.nvim",
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	-- 	lazy = false,
	-- }
}



