return {
	{
		"max397574/better-escape.nvim",
		config = true,
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			sync_root_with_cwd = true,
			respect_buf_cwd = true,
			update_focused_file = {
				enable = true,
				update_cwd = true,
			},
		},
	},
	{
		"diegoulloao/neofusion.nvim",
		priority = 1000,
		config = function()
			require("neofusion").setup()
			vim.cmd([[ colorscheme neofusion ]])
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = true,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = true,
	},
	{
		"famiu/bufdelete.nvim",
	},
	{
		"folke/noice.nvim",
		enabled = false,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = false,
			},
		},
	},
	{
		"echasnovski/mini.comment",
		version = "*",
		opts = {
			mappings = {
				comment = "<leader>/",
				comment_line = "<leader>//",
				comment_visual = "<leader>/",
				textobject = "<leader>/",
			},
		},
	},
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			open_mapping = [[<C-\>]],
			insert_mappings = false,
		},
	},
	{
		"smoka7/hop.nvim",
		version = "2.7",
		config = true,
	},
}
