local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "ca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "gr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "rn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("n", "<leader>fm", function()
		vim.lsp.buf.format()
	end)
end

local servers = {
	lua_ls = {},
	tsserver = {},
	-- elixirls = {
	-- 	cmd = { vim.fn.stdpath("data") .. "/mason/packages/elixir-ls/language_server.sh" },
	-- },
	-- lexical = {
	-- 	cmd = { "lexical" },
	-- },
	tailwindcss = {
		init_options = {
			userLanguages = {
				elixir = "html-eex",
				heex = "html-eex",
			},
		},
	},
	rust_analyzer = {},
}

local server_names = {}
for server, _ in pairs(servers) do
	table.insert(server_names, server)
end

-- add nextls after because mason lsp_config doesn't support it
servers["nextls"] = {
	cmd = { "nextls", "--stdio" },
	init_options = {
		extensions = {
			credo = { enable = true },
		},
		experimental = {
			completions = { enable = true },
		},
	},
}

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
				on_attach = on_attach,
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
