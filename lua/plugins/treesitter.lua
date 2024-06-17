return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"RRethy/nvim-treesitter-endwise",
	},
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"elixir",
				"heex",
				"javascript",
				"typescript",
				"html",
				"css",
				"regex",
				"toml",
				"rust",
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			endwise = { enable = true },
		})
	end,
}
