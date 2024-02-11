return {
	--NOTE: patch umtil https://github.com/LazyVim/LazyVim/pull/2198 is merged
	-- {
	-- 	"mrcjkb/rustaceanvim",
	-- 	version = "^4", -- Recommended
	-- 	-- version = "*", -- Recommended
	-- 	ft = { "rust" },
	-- 	opts = {
	-- 		server = {
	-- 			on_attach = function(client, bufnr)
	-- 				-- register which-key mappings
	-- 				local wk = require("which-key")
	-- 				wk.register({
	-- 					["<leader>cR"] = {
	-- 						function()
	-- 							vim.cmd.RustLsp("codeAction")
	-- 						end,
	-- 						"Code Action",
	-- 					},
	-- 				}, { mode = "n", buffer = bufnr })
	-- 				--NOTE: This is the setup for nvim 10.x
	-- 				vim.lsp.inlay_hint.enable(bufnr, true)
	-- 			end,
	-- 		},
	-- 	},
	-- 		},
	-- 	},
	-- },

	-- Extend auto completion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{
				"Saecki/crates.nvim",
				event = { "BufRead Cargo.toml" },
				opts = {
					src = {
						cmp = { enabled = true },
					},
				},
			},
		},
		---@param opts cmp.ConfigSchema
		opts = function(_, opts)
			local cmp = require("cmp")
			opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
				{ name = "crates" },
			}))
		end,
	},

	-- Add Rust & related to treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "ron", "rust", "toml" })
		end,
	},

	-- Ensure Rust debugger is installed
	{
		"williamboman/mason.nvim",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "codelldb" })
		end,
	},

	{
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		ft = { "rust" },
		opts = {
			server = {
				on_attach = function(client, bufnr)
					-- register which-key mappings
					local wk = require("which-key")
					wk.register({
						["<leader>cR"] = {
							function()
								vim.cmd.RustLsp("codeAction")
							end,
							"Code Action",
						},
						["<leader>dr"] = {
							function()
								vim.cmd.RustLsp("debuggables")
							end,
							"Rust debuggables",
						},
					}, { mode = "n", buffer = bufnr })
					-- vim.lsp.inlay_hint.enable(bufnr, true)
				end,
				default_settings = {
					-- rust-analyzer language server configuration
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							runBuildScripts = true,
						},
						trace = { server = "verbose" },
						-- Add clippy lints for Rust.
						checkOnSave = {
							allFeatures = true,
							command = "clippy",
							extraArgs = { "--no-deps" },
						},
						procMacro = {
							enable = true,
							ignored = {
								["async-trait"] = { "async_trait" },
								["napi-derive"] = { "napi" },
								["async-recursion"] = { "async_recursion" },
							},
						},
					},
				},
			},
		},
		config = function(_, opts)
			vim.g.rustaceanvim = vim.tbl_deep_extend("force", {}, opts or {})
		end,
		keys = {
			{
				"<leader>dr",
				"<cmd>Rust debuggables<cr>",
				desc = "Rust debuggables",
			},
			{
				"<leader>cS",
				"<cmd>RustAnalyzer restart<cr>",
				desc = "Restart LSP",
			},
			{
				"<leader>cC",
				"<cmd>RustLsp openCargo<cr>",
				desc = "Open Cargo",
			},
			{
				"<leader>cD",
				"<cmd>RustLsp externalDocs<cr>",
				desc = "External Doc",
			},
			--TODO: do this globally for all lang
			{
				"<leader>cZ",
				"<cmd>RustLsp renderDiagnostic<cr>",
				desc = "Render Diagnostic",
			},
			{
				"<leader>cU",
				"<cmd>Crates upgrade_crate<cr>",
				desc = "Upgrade Crate",
			},
			{
				"<leader>cF",
				false,
			},
			{
				"<leader>cz",
				function()
					local bufnr = vim.api.nvim_get_current_buf()
					local line, col = unpack(vim.api.nvim_win_get_cursor(0))
					local diagnostics = vim.diagnostic.get(bufnr, { lnum = line - 1 })

					local messages = {}
					for _, diag in ipairs(diagnostics) do
						table.insert(messages, diag.message)
					end

					local final_message = table.concat(messages, "\n")
					vim.fn.setreg("+", final_message) -- Copy to clipboard

					print("Diagnostics copied to clipboard") -- Optional: Confirmation message
				end,
				desc = "Copy LSP Diagnostics to Clipboard",
			},
		},
	},

	-- Correctly setup lspconfig for Rust 🚀

	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = { enabled = true },
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {

			-- --NOTE: nighly
			-- inlay_hints = {
			-- 	enabled = true,
			-- },
			--
			servers = {
				rust_analyzer = {},
				taplo = {
					keys = {
						{
							"K",
							function()
								if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
									require("crates").show_popup()
								else
									vim.lsp.buf.hover()
								end
							end,
							desc = "Show Crate Documentation",
						},
					},
				},
			},
			setup = {
				rust_analyzer = function()
					return true
				end,
			},
		},
	},

	{
		"nvim-neotest/neotest",
		optional = true,
		opts = function(_, opts)
			opts.adapters = opts.adapters or {}
			vim.list_extend(opts.adapters, {
				require("rustaceanvim.neotest"),
			})
		end,
	},
}
