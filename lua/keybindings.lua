local keymap = vim.keymap.set

keymap("n", "<Esc>", "<cmd>nohlsearch<CR>")
keymap("n", "Q", "<Nop>")

keymap({ "n", "v" }, "<leader>tw", ":set wrap!<CR>", { desc = "Toggle wrap" })

keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move the selected lines down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move the selected lines up" })

keymap("n", "<C-d>", "<C-d>zz", { desc = "Scroll half page down" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Scroll half page up" })

keymap("n", "n", "nzzzv", { desc = "Move to the next search match" })
keymap("n", "N", "nzzzv", { desc = "Move to the previous search match" })

-- easier window navigation
keymap("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", {})
keymap("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", {})
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", {})
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", {})
keymap("n", "<leader>fp", function()
	require("telescope").extensions.projects.projects()
end, {})

keymap("n", "H", ":BufferLineCyclePrev<CR>", { silent = true })
keymap("n", "L", ":BufferLineCycleNext<CR>", { silent = true })
keymap("n", "gb", ":BufferLinePick<CR>", { silent = true })
keymap("n", "<leader>x", ":Bdelete<CR>", { silent = true })

keymap("n", "<leader>d", "<cmd>Trouble diagnostics toggle<cr>")

keymap("", "f", "<cmd>HopChar1CurrentLineAC<CR>")
keymap("", "F", "<cmd>HopChar1CurrentLineBC<CR>")
keymap("", "s", "<cmd>HopChar1AC<CR>")
keymap("", "S", "<cmd>HopChar1BC<CR>")

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	keymap("t", "<esc>", [[<C-\><C-n>]], opts)
	keymap("t", "jk", [[<C-\><C-n>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
