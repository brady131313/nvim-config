local keymap = vim.api.nvim_set_keymap

local opts = { silent = true, noremap = true }
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = { silent = true }
keymap("n", "<S-l>", ":tabn<CR>", opts)
keymap("n", "<S-h>", ":tabp<CR>", opts)

local opts = { silent = true, noremap = true }
keymap("n", "<C-j>", [[<Cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>]], opts)
keymap("n", "<C-k>", [[<Cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>]], opts)
keymap("n", "<C-h>", [[<Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>]], opts)
keymap("n", "<C-l>", [[<Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>]], opts)
