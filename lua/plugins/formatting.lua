return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            elixir = { "mix" },
            heex = { "mix" },
            typescript = { "prettier" },
            javascript = { "prettier" },
            typescriptreact = { "prettier" },
            ["*"] = { "codespell" },
            ["_"] = { "trim_whitespace" }
        },
        format_on_save = {
            -- These options will be passed to conform.format()
            timeout_ms = 500,
            lsp_fallback = true,
        },
    },
}
