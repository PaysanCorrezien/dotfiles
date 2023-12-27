return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- Python tools
          { "pyright", auto_update = true }, -- LSP
          -- { "black", auto_update = true }, -- Formatter
          { "flake8", auto_update = true }, -- Linter
          { "mypy", auto_update = true }, -- Type Checker
          -- { 'ruff', auto_update = true},

          -- Bash tools
          { "bashls", auto_update = true }, -- LSP
          { "shellcheck", auto_update = true }, -- Linter
          { "shellharden", auto_update = true }, -- Linter

          -- Svelte tools
          { "svelte", auto_update = true }, -- LSP

          -- JSON tools
          -- { 'jsonls', auto_update = true },   -- LSP
          -- YAML tools
          { "yamllint", auto_update = true }, -- LSP
          -- TOML tools
          { "taplo", auto_update = true }, -- LSP
          -- Markdown tools
          { "ltex", auto_update = true }, -- LSP for LaTeX and Markdown
          { "markdownlint", auto_update = true }, -- Linter

          -- JavaScript / Web (HTML, CSS) tools
          { "eslint", auto_update = true }, -- Linter
          { "prettierd", auto_update = true }, -- Formatter

          -- Others you might consider
          { "html", auto_update = true }, -- LSP for HTML
          { "cssls", auto_update = true }, -- LSP for CSS
          -- lua
          -- { "luacheck", auto_update = true }, -- LSP for CSS
          -- Misc
          -- TODO: Test this ?
          -- { 'gitleaks', auto_update = true },    -- LSP for CSS
        },
        auto_update = false,
        run_on_start = true,
        start_delay = 3000, -- 3 second delay
        debounce_hours = 10, -- at least 5 hours between attempts to install/update
      })
    end,
  },
}
