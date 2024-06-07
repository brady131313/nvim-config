local servers = {
	lua_ls = {},
	tsserver = {},
	elixirls = {
		cmd = { vim.fn.stdpath("data") .. "/mason/packages/elixir-ls/language_server.sh" },
	},
	tailwindcss = {
		init_options = {
			userLanguages = {
				elixir = "html-eex",
				heex = "html-eex",
			},
		},
	},
}

local server_names = {}
for server, _ in pairs(servers) do
	table.insert(server_names, server)
end

return {
	{
		"williamboman/mason.nvim",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = server_names,
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local default_config = {
				capabilities = capabilities,
			}

			for server, config in pairs(servers) do
				config = vim.tbl_deep_extend("force", default_config, config)
				lspconfig[server].setup(config)
			end
		end,
	},
	{
		"folke/lazydev.nvim",
		dependencies = {
			{ "Bilal2453/luvit-meta", lazy = true },
		},
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"github/copilot.vim",
	},
}
