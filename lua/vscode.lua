vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window controls
keymap("n", "<C-j>", [[<cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<cr>]], opts)
keymap("n", "<C-k>", [[<cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<cr>]], opts)
keymap("n", "<C-h>", [[<cmd>call VSCodeNotify('workbench.action.focusRightGroup')<cr>]], opts)
keymap("n", "<C-l>", [[<cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<cr>]], opts)

-- toggle sidebar
keymap("n", "<Space>e", [[<cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<cr>]], opts)

local opts = { silent = true }
keymap("n", "<S-l>", ":tabn<CR>", opts)
keymap("n", "<S-h>", ":tabp<CR>", opts)
keymap("n", "<Space>ff", ":find<CR>", opts)
keymap("n", "<Space>c", ":quit<CR>", opts)
