vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"

local remap = vim.api.nvim_set_keymap
local remap_vsaction = function(mode, binding, action, opts)
	remap(mode, binding, '<cmd>call VSCodeNotify("' .. action .. '")<cr>', opts)
end

local opts = { noremap = true, silent = true }

remap_vsaction("n", "<leader>ff", "workbench.action.quickOpen", opts)
remap_vsaction("n", "<leader>fs", "workbench.action.gotoSymbol", opts)

remap("n", "<s-h>", [[<cmd>Tabprevious<cr>]], opts)
remap("n", "<s-l>", [[<cmd>Tabnext<cr>]], opts)
remap("n", "<s-c>", [[<cmd>Tabclose<cr>]], opts)

remap("n", "<leader>ws", [[<cmd>Split<cr>]], opts)
remap("n", "<leader>wv", [[<cmd>Vsplit<cr>]], opts)
remap_vsaction("n", "<leader>wc", "workbench.action.closeActiveEditor", opts)

remap_vsaction("n", "<c-j>", "workbench.action.focusBelowGroup", opts)
remap_vsaction("n", "<c-k>", "workbench.action.focusAboveGroup", opts)
remap_vsaction("n", "<c-h>", "workbench.action.focusLeftGroup", opts)
remap_vsaction("n", "<c-l>", "workbench.action.focusRightGroup", opts)

remap_vsaction("n", "<leader>t", "workbench.action.terminal.focus", opts)

remap("x", "<leader>c", [[<plug>VSCodeCommentary]], {})
remap("n", "<leader>c", [[<plug>VSCodeCommentary]], {})
remap("o", "<leader>c", [[<plug>VSCodeCommentary]], {})
remap("n", "<leader>cc", [[<plug>VSCodeCommentaryLine]], {})
