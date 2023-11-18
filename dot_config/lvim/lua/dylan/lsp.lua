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
	"pyright",
  "ruff_lsp",
  "dockerls",
	"vimls",
}
-- Disable automatic serv install
lvim.lsp.installer.setup.automatic_installation = false
lvim.lsp.automatic_configuration.skipped_servers = { "svelte","tsserver","pylsp","pyright","jsonls","eslink_d" }
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


require("lspconfig").yamlls.setup({
    settings = {
        yaml = {
            schemas = { kubernetes = "*.yaml" },  -- example schema configuration
            hover = true,
            completion = true,
            validate = true,
            format = {
                enable = true,
                bracketSpacing = true,
                printWidth = 80,
            },
        },
    },
})


local code_actions = require("lvim.lsp.null-ls.code_actions")
code_actions.setup({
	{
		command = "shellcheck",
	},
})

-- Advanced pyright configuration

local pyright_opts = {
  single_file_support = true,
  settings = {
    pyright = {
      disableLanguageServices = false,
      disableOrganizeImports = false,
    },
    python = {
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "workspace", -- openFilesOnly, workspace
        typeCheckingMode = "basic", -- off, basic, strict
        useLibraryCodeForTypes = true,
      },
    },
  },
}

require("lvim.lsp.manager").setup("pyright", pyright_opts)

require("lspconfig").jsonls.setup({
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	init_options = {
		provideFormatter = true,
	},
	single_file_support = true,
})

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

-- lvim.lsp.override = { "tsserver" }
require("lspconfig").tsserver.setup({
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	root_dir = require("lspconfig/util").root_pattern("package.json", "tsconfig.json", ".git"),
	settings = {
		documentFormatting = false,
	},
})
