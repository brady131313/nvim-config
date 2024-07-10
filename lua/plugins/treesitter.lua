return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "RRethy/nvim-treesitter-endwise",
        "windwp/nvim-ts-autotag",
    },
    config = function()
        local configs = require("nvim-treesitter.configs")

        require('nvim-ts-autotag').setup({
            enable = true
        })

        configs.setup({
            ensure_installed = {
                "lua",
                "vim",
                "vimdoc",
                "elixir",
                "heex",
                "javascript",
                "typescript",
                "tsx",
                "html",
                "css",
                "regex",
                "toml",
                "rust",
                "fish",
                "svelte"
            },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
            endwise = { enable = true },
        })
    end,
}
