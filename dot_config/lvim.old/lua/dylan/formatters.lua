local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
    { command = "black", filetypes = { "python" } }, -- Python
  -- { command = "ruff", args= { "-n", "-e", "--stdin-filename", "$FILENAME", "-" },filetypes={"python"}},
    { command = "shfmt", filetypes = { "bash" } }, -- Bash
    { command = "rustfmt", filetypes = { "rust" } }, -- Rust
    { command = "prettierd", filetypes = { -- Web & Markdown
        "javascript", "javascriptreact", "typescript", "typescriptreact", 
        "vue", "css", "scss", "less", "html", "yaml", 
        "markdown", "markdown.mdx", "graphql", "handlebars", "json"
    }},
    { command = "stylua", filetypes = { "lua" } }, -- Lua
  { command = "taplo", filetypes = { "toml" } }, -- TOML
    -- { command = "csharpier", filetypes = { "cs" } }, -- C#
})

