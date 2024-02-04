return {

	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		event = "VeryLazy",
		-- opts = {
		-- 	suggestion = { enabled = false },
		-- 	panel = { enabled = false },
		-- 	filetypes = {
		-- 		markdown = true,
		-- 		help = true,
		-- 	},
		-- },
		config = function()
			require("copilot").setup({

				panel = {
					enabled = true,
					auto_refresh = false,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						-- open = "<leader>cC",
					},
					layout = {
						position = "right", -- | top | left | right
						ratio = 0.4,
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					debounce = 75,
					keymap = {
						accept = "<C-m>",
						accept_word = "<C-w>",
						accept_line = false,
						next = "<C-]>",
						prev = "<C-[>",
						dismiss = "<C-d>",
					},
				},
				copilot_node_command = "node", -- Node.js version must be > 18.x
				server_opts_overrides = {},

				filetypes = {
					markdown = true, -- overrides default
					terraform = false, -- disallow specific filetype
					yaml = false,
					sh = function()
						if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
							-- disable for .env files
							return false
						end
						return true
					end,
				},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		optional = true,
		event = "VeryLazy",
		opts = function(_, opts)
			local Util = require("lazyvim.util")
			local colors = {
				[""] = Util.ui.fg("Special"),
				["Normal"] = Util.ui.fg("Special"),
				["Warning"] = Util.ui.fg("DiagnosticError"),
				["InProgress"] = Util.ui.fg("DiagnosticWarn"),
			}
			table.insert(opts.sections.lualine_x, 2, {
				function()
					local icon = require("lazyvim.config").icons.kinds.Copilot
					local status = require("copilot.api").status.data
					return icon .. (status.message or "")
				end,
				cond = function()
					if not package.loaded["copilot"] then
						return
					end
					local ok, clients = pcall(require("lazyvim.util").lsp.get_clients, { name = "copilot", bufnr = 0 })
					if not ok then
						return false
					end
					return ok and #clients > 0
				end,
				color = function()
					if not package.loaded["copilot"] then
						return
					end
					local status = require("copilot.api").status.data
					return colors[status.status] or colors[""]
				end,
			})
		end,
	},
}
