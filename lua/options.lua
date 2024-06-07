vim.g.mapleader = " "
vim.g.maplocalleader = " "

local options = {
	number = true,
	clipboard = "unnamedplus",
	undofile = true,
	-- case insensitive searching unless capital letter present
	ignorecase = true,
	smartcase = true,

	signcolumn = "yes",

	splitright = true,
	splitbelow = true,

	scrolloff = 10,
	hlsearch = true, -- highlight on search

	shiftwidth = 4,
	tabstop = 4,

	background = "dark",
	termguicolors = true,
}

for option, value in pairs(options) do
	vim.opt[option] = value
end
