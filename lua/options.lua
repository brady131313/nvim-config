vim.g.mapleader = " "
vim.g.maplocalleader = " "

local options = {
    number = true,
    clipboard = "unnamedplus",
    -- case insensitive searching unless capital letter present
    ignorecase = true,
    smartcase = true,
    mouse = "a",

    signcolumn = "yes",

    splitright = true,
    splitbelow = true,

    scrolloff = 10,
    hlsearch = false,
    incsearch = true,

    shiftwidth = 2,
    tabstop = 2,
    softtabstop = 2,
    expandtab = true,

    background = "dark",
    termguicolors = true,
    wrap = false,

    swapfile = false,
    backup = false,
    undodir = vim.fn.stdpath("data") .. "/undo",
    undofile = true,

    updatetime = 50,
}

for option, value in pairs(options) do
    vim.opt[option] = value
end
