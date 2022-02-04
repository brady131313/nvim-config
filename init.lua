-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_vscode = vim.g.vscode == 1

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	Packer_bootstrap = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

-- Sync on save
vim.cmd([[
	augroup Packer
		autocmd!
		autocmd BufWritePost init.lua PackerCompile
	augroup end
]])

require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use({ "nvim-lua/plenary.nvim", disable = is_vscode })
	use({ "nvim-telescope/telescope.nvim", disable = is_vscode })
	use({ "sainnhe/gruvbox-material", disable = is_vscode })
	use({ "sbdchd/neoformat", disable = is_vscode })
	use({ "neovim/nvim-lspconfig", disable = is_vscode })
	use({ "williamboman/nvim-lsp-installer", disable = is_vscode })
	use({ "kyazdani42/nvim-web-devicons", disable = is_vscode })
	use({ "romgrk/barbar.nvim", disable = is_vscode })
	use({ "nvim-lualine/lualine.nvim", disable = is_vscode })
	use({ "windwp/nvim-autopairs", disable = is_vscode })
	use({ "akinsho/toggleterm.nvim", disable = is_vscode })
	use({ "rmagatti/auto-session", disable = is_vscode })
	use({ "lukas-reineke/indent-blankline.nvim", disable = is_vscode })
	use({ "nathom/filetype.nvim", disable = is_vscode })
	use({
		"b3nj5m1n/kommentary",
		setup = function()
			vim.g.kommentary_create_default_mappings = false
		end,
		disable = is_vscode,
	})
	use({
		"kyazdani42/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup({})
		end,
		disable = is_vscode,
	})
	use({
		"ms-jpq/coq_nvim",
		branch = "coq",
		run = ":COQdeps",
		disable = is_vscode,
	})
	use({
		"ms-jpq/coq.artifacts",
		branch = "artifacts",
		disable = is_vscode,
	})
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		disable = is_vscode,
	})
	use({
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
		disable = is_vscode,
	})

	if Packer_bootstrap then
		require("packer").sync()
	end
end)

if is_vscode then
	return require("init_vs")
end

local options = {
	guifont = "JetBrainsMono Nerd Font Mono",
	shell = "/bin/bash",
	mouse = "a",
	ignorecase = true, -- Ignore case in search
	smartcase = true, -- Override ignore case if contains uppercase
	smartindent = true,
	expandtab = true, -- Expand tabs to spaces
	shiftwidth = 2, -- Num of spaces for each indent
	tabstop = 2, -- Insert 2 spaces for a tab
	hidden = true,
	clipboard = "unnamedplus",
	number = true,
	wrap = true,
	undofile = true, -- Save undo history
	splitright = true,
	splitbelow = true,
	termguicolors = true,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.g.mapleader = " "

vim.g.neovide_floating_blur = 0
vim.g.did_load_filetypes = 1
vim.g.coq_settings = {
	auto_start = "shut-up",
	keymap = { recommended = false },
}

-- Theme
vim.o.background = "dark"
vim.g.gruvbox_material_background = "hard"
vim.cmd([[colorscheme gruvbox-material]])

-- Format on save
vim.cmd([[
	augroup fmt
		autocmd!
		autocmd BufWritePre * undojoin | Neoformat
	augroup end
]])

-- Treesitter
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"css",
		"dockerfile",
		"elixir",
		"fish",
		"heex",
		"html",
		"javascript",
		"json",
		"lua",
		"python",
		"regex",
		"rust",
		"svelte",
		"toml",
		"typescript",
		"yaml",
	},
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
})

local lsp_root = vim.fn.stdpath("data") .. "/lsp_servers/"
local sumneko_root_path = lsp_root .. "sumneko_lua/extension/server"
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- LSP
local on_attach = function(_, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "ge", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

local lsp_installer = require("nvim-lsp-installer")
local coq = require("coq")
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = on_attach,
	}

	if server.name == "sumneko_lua" then
		opts.cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" }
		opts.settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
					path = runtime_path,
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = {
					enable = false,
				},
			},
		}
	end

	server:setup(coq.lsp_ensure_capabilities(opts))
end)

-- Autopairs
local remap = vim.api.nvim_set_keymap
local npairs = require("nvim-autopairs")

npairs.setup({
	map_bs = false,
	map_cr = false,
	check_ts = true,
})

npairs.add_rules(require("nvim-autopairs.rules.endwise-elixir"))
npairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))

remap("i", "<esc>", [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
remap("i", "<c-c>", [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap("i", "<tab>", [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
remap("i", "<s-tab>", [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

_G.MUtils = {}

MUtils.CR = function()
	if vim.fn.pumvisible() ~= 0 then
		if vim.fn.complete_info({ "selected" }).selected ~= -1 then
			return npairs.esc("<c-y>")
		else
			return npairs.esc("<c-e>") .. npairs.autopairs_cr()
		end
	else
		return npairs.autopairs_cr()
	end
end
remap("i", "<cr>", "v:lua.MUtils.CR()", { expr = true, noremap = true })

MUtils.BS = function()
	if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ "mode" }).mode == "eval" then
		return npairs.esc("<c-e>") .. npairs.autopairs_bs()
	else
		return npairs.autopairs_bs()
	end
end
remap("i", "<bs>", "v:lua.MUtils.BS()", { expr = true, noremap = true })

-- Lualine
require("lualine").setup({
	options = {
		theme = "gruvbox-material",
	},
	extensions = { "nvim-tree", "toggleterm" },
})

-- Term
require("toggleterm").setup({
	shell = "/usr/bin/fish",
	open_mapping = [[<c-\>]],
})

-- Blankline
require("indent_blankline").setup({
	space_char_blankline = " ",
	show_current_context = true,
	use_treesitter = true,
})

MUtils.set_terminal_keymaps = function()
	local opts = { noremap = true }
	vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<c-\><c-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<c-\><c-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<c-h>", [[<c-\><c-n><c-w>h]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<c-j>", [[<c-\><c-n><c-w>j]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<c-k>", [[<c-\><c-n><c-w>k]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<c-l>", [[<c-\><c-n><c-w>l]], opts)
end

vim.cmd([[autocmd! TermOpen term://* lua MUtils.set_terminal_keymaps()]])

-- Filetype
require("filetype").setup({
	overrides = {
		extensions = {
			heex = "eelixir",
		},
	},
})

-- Keybinds
local opts = { noremap = true, silent = true }

-- Telescope
remap("n", "<leader>ff", [[<cmd>lua require('telescope.builtin').find_files()<cr>]], opts)
remap("n", "<leader>fg", [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], opts)
remap("n", "<leader>fb", [[<cmd>lua require('telescope.builtin').buffers()<cr>]], opts)
remap("n", "<leader>fh", [[<cmd>lua require('telescope.builtin').help_tags()<cr>]], opts)

-- Moving around buffers
remap("n", "<s-h>", ":BufferPrevious<cr>", opts)
remap("n", "<s-l>", ":BufferNext<cr>", opts)
remap("n", "<s-c>", ":BufferClose<cr>", opts)
remap("n", "<s-p>", ":BufferPick<cr>", opts)

-- Moving windows
remap("n", "<c-h>", "<C-w>h", opts)
remap("n", "<c-j>", "<C-w>j", opts)
remap("n", "<c-k>", "<C-w>k", opts)
remap("n", "<c-l>", "<C-w>l", opts)

-- Disable search highlighting
remap("n", "<leader>h", [[<cmd>nohlsearch<cr>]], opts)

remap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Comments
remap("n", "<leader>cc", "<plug>kommentary_line_default", {})
remap("n", "<leader>c", "<plug>kommentary_motion_default", {})
remap("x", "<leader>c", "<plug>kommentary_visual_default", {})
