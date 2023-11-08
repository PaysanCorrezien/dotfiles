local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	--  { command = "black", filetypes = { "python" } },
	-- { command = "isort", filetypes = { "python" } },
	{ command = "shfmt", filetype = { "bash" } },
	-- { command =  "omnisharp",filetype = {"cs"}},
	--
	{
		command = "prettierd",
		filetypes = { "typescript", "typescriptreact" },
	},
	{
    command = "rustfmt",
    filetypes = { "rust" },
  },
{
	  command = "prettierd",
	  filetypes = {
	    "javascript",
	    "javascriptreact",
	    "typescript",
	    "typescriptreact",
	    "vue",
	    "css",
	    "scss",
	    "less",
	    "html",
	    "yaml",
	    "markdown",
	    "markdown.mdx",
	    "graphql",
	    "handlebars",
	    "json",
	  }
	},
	{ command = "fixjson", filetype = { "json" } },

	{ command = "stylua" },
	{ command = "shellharden", filetype = { "bash " } },
	{
		command = "csharpier",
		--  extra_args = { "--write-stdout" },
		filetype = { "cs" },
	},
})
