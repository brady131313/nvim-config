if not vim.g.vscode then
  require("user.options")
  require("user.keymaps")
  require("user.plugins")
  require("user.colorscheme")
  require("user.cmp")
  require("user.lsp")
  require("user.telescope")
  require("user.treesitter")
  require("user.autopairs")
  require("user.nvim-tree")
  require("user.gitsigns")
  require("user.comment")
  require("user.bufferline")
  require("user.lualine")
  require("user.impatient")
  require("user.indentline")
  require("user.toggleterm")
  require("user.whichkey")
  require("user.trouble")
  require("user.mkdx")
  require("user.symbols-outline")
end

if vim.g.vscode == 1 then
  require("vscode")
end
