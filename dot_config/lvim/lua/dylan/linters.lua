-- -- set additional linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	-- { command = "flake8", filetypes = { "python" } },
	{
		-- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
		command = "shellcheck",
		-- @usage arguments to pass to the formatter
		-- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    -- TODO : make it work on all zsh file , same for lsp  ?
		extra_args = { "--severity", "warning" },
		filetypes = { "sh", "zsh" },
	},
	-- { command = "jsonlint", filetype = { "json" } },
	-- Useless {  command = "csharpier", filetype = { "cs"}},
	-- {
	-- 	command = "codespell",
	-- 	---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
	-- 	filetypes = { "javascript", "python" },
	-- },
	-- { command = "eslint_d", filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" } },
  --TODO: { command = "prettierd"}
	{ command = "flake8", args = { "--ignore=E203,E501" }, filetypes = { "python" } },
	{ command = "mypy", filetypes = { "python" } },
  -- { command = "ruff", args= { "-n", "-e", "--stdin-filename", "$FILENAME", "-" },filetypes={"python"}},
	{ command = "yamllint", filetypes = { "yaml" } },
	{ command = "markdownlint", filetypes = { "markdown" } },
  -- SO SLOW ????
	-- { command = "luacheck", filetypes = { "lua" } },
})
