lvim.lsp.installer.setup.ensure_installed = {
	"jsonls",
	"ltex",
	"lua_ls",
	"powershell_es",
	"tailwindcss",
	"yamlls",
	"bashls",
  -- "rust_analyzer"
}
require("lvim.lsp.manager").setup("bashls")
require("lvim.lsp.manager").setup("lua_ls")
-- require("lvim.lsp.manager").setup("rust_analyzer")

require("lspconfig").jsonls.setup({
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	init_options = {
		provideFormatter = true,
	},
	single_file_support = true,
})

local code_actions = require("lvim.lsp.null-ls.code_actions")
code_actions.setup({
	{
		command = "shellcheck",
	},
})

