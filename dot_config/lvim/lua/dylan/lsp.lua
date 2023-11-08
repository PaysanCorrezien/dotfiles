lvim.lsp.installer.setup.ensure_installed = {
	"jsonls",
	"lua_ls",
	"tailwindcss",
	"bashls",
	"cssls",
	"html",
	"ltex",
	"powershell_es",
	"pyright",
	"rust_analyzer",
	"svelte",
	"tailwindcss",
	"yamlls",
	"tsserver",
	"yamlls",
  
  -- TODO: set yaml, vim, and check others
	"vimls",
	-- "rust_analyzer"
}
require("lvim.lsp.manager").setup("bashls")
require("lvim.lsp.manager").setup("cssls")
require("lvim.lsp.manager").setup("html")
require("lvim.lsp.manager").setup("ltex")
require("lvim.lsp.manager").setup("powershell_es")
require("lvim.lsp.manager").setup("pyright")
require("lvim.lsp.manager").setup("svelte")
require("lvim.lsp.manager").setup("tailwindcss")
require("lvim.lsp.manager").setup("tsserver")
require("lvim.lsp.manager").setup("yamlls")
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

lvim.lsp.automatic_configuration.skipped_servers = { "svelte",
"sourcery", "jedi_language_server","ruff_lsp"}

-- lvim.lsp.override = { "svelte" }
require("lspconfig").svelte.setup({
	cmd = { "svelteserver", "--stdio" },
	filetypes = { "svelte" },
	root_dir = require("lspconfig/util").root_pattern("package.json", "tsconfig.json", ".git"),
	settings = {
		svelte = {
			plugin = {
				html = {
					completions = {
						enable = true,
					},
					hover = {
						enable = true,
					},
					diagnostics = {
						enable = true,
					},
				},
				svelte = {
					completions = {
						enable = true,
					},
					hover = {
						enable = true,
					},
					diagnostics = {
						enable = true,
					},
				},
				css = {
					completions = {
						enable = true,
					},
					hover = {
						enable = true,
					},
					diagnostics = {
						enable = true,
					},
				},
				js = {
					completions = {
						enable = true,
					},
					hover = {
						enable = true,
					},
					diagnostics = {
						enable = true,
					},
				},
			},
		},
	},
})
lvim.lsp.automatic_configuration.skipped_servers = { "tsserver" }
-- lvim.lsp.override = { "tsserver" }
require("lspconfig").tsserver.setup({
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	root_dir = require("lspconfig/util").root_pattern("package.json", "tsconfig.json", ".git"),
	settings = {
		documentFormatting = false,
	},
})
