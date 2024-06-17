return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.6",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		{
			"ahmedkhalf/project.nvim",
			config = function()
				require("project_nvim").setup()
			end,
		},
	},
	config = function()
		local telescope = require("telescope")
		telescope.setup()
		telescope.load_extension("fzf")
		telescope.load_extension("projects")
	end,
}
