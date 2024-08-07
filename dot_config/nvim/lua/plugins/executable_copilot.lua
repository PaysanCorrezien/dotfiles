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
		"zbirenbaum/copilot-cmp",
		enabled = false,
	},
	-- {
	-- 	"nvim-lualine/lualine.nvim",
	-- 	optional = true,
	-- 	event = "VeryLazy",
	-- 	opts = function(_, opts)
	-- 		local Util = require("lazyvim.util")
	-- 		local colors = {
	-- 			[""] = Util.ui.fg("Special"),
	-- 			["Normal"] = Util.ui.fg("Special"),
	-- 			["Warning"] = Util.ui.fg("DiagnosticError"),
	-- 			["InProgress"] = Util.ui.fg("DiagnosticWarn"),
	-- 		}
	-- 		table.insert(opts.sections.lualine_x, 2, {
	-- 			function()
	-- 				local icon = require("lazyvim.config").icons.kinds.Copilot
	-- 				local status = require("copilot.api").status.data
	-- 				return icon .. (status.message or "")
	-- 			end,
	-- 			cond = function()
	-- 				if not package.loaded["copilot"] then
	-- 					return
	-- 				end
	-- 				local ok, clients = pcall(require("lazyvim.util").lsp.get_clients, { name = "copilot", bufnr = 0 })
	-- 				if not ok then
	-- 					return false
	-- 				end
	-- 				return ok and #clients > 0
	-- 			end,
	-- 			color = function()
	-- 				if not package.loaded["copilot"] then
	-- 					return
	-- 				end
	-- 				local status = require("copilot.api").status.data
	-- 				return colors[status.status] or colors[""]
	-- 			end,
	-- 		})
	-- 	end,
	-- },
	-- {
	-- 	"CopilotC-Nvim/CopilotChat.nvim",
	-- 	branch = "canary",
	-- 	dependencies = {
	-- 		{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
	-- 		{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
	-- 	},
	-- 	opts = {
	-- 		debug = true, -- Enable debugging
	-- 		-- See Configuration section for rest
	-- 	},
	-- 	-- See Commands section for default commands if you want to lazy load on them
	-- 	keys = {
	-- 		{ "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "Explain code" },
	-- 		{ "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "Generate tests" },
	-- 		{ "<leader>ccr", "<cmd>CopilotChatReset<cr>", desc = "Reset chat" },
	-- 		{
	--
	-- 			"<leader>ccq",
	-- 			function()
	-- 				local input = vim.fn.input("Quick Chat: ")
	-- 				if input ~= "" then
	-- 					require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
	-- 				end
	-- 			end,
	-- 			desc = "Quick chat",
	-- 		},
	-- 		-- Show help actions with telescope
	-- 		{
	-- 			"<leader>cch",
	-- 			function()
	-- 				local actions = require("CopilotChat.actions")
	-- 				require("CopilotChat.integrations.telescope").pick(actions.help_actions())
	-- 			end,
	-- 			desc = "Telescope Help actions",
	-- 		},
	--
	-- 		-- Show prompts actions with telescope
	-- 		{
	-- 			"<leader>ccp",
	-- 			function()
	-- 				local actions = require("CopilotChat.actions")
	-- 				require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
	-- 			end,
	-- 			desc = "Telescope - Prompt actions",
	-- 		},
	-- 		-- { "<leader>cco", "<cmd>CopilotChatOpen<cr>", desc = "CopilotChat - Open chat window" },
	-- 		-- { "<leader>ccc", "<cmd>CopilotChatClose<cr>", desc = "CopilotChat - Close chat window" },
	-- 		{ "<leader>h", "<cmd>CopilotChatToggle<cr>", desc = "Toggle chat window" },
	-- 		{ "<leader>ccd", "<cmd>CopilotChatDebugInfo<cr>", desc = "Show debug information" },
	-- 		{ "<leader>ccx", "<cmd>CopilotChatFix<cr>", mode = { "n", "x" }, desc = "Fix the code" },
	-- 		{ "<leader>ccX", "<cmd>CopilotChatFixDiagnostic<cr>", mode = { "n", "x" }, desc = "Fix the Diagnostic" },
	-- 		{ "<leader>cco", "<cmd>CopilotChatOptimize<cr>", mode = { "n", "x" }, desc = "Optimize the code" }, -- Note: 'cco' is duplicated, consider an alternative key combination.
	-- 		{ "<leader>ccD", "<cmd>CopilotChatDocs<cr>", mode = { "n", "x" }, desc = "Document the code" },
	-- 		{ "<leader>ccC", "<cmd>CopilotChatCommit<cr>", desc = "Write commit message" },
	-- 		{
	-- 			"<leader>ccS",
	-- 			"<cmd>CopilotChatCommitStaged<cr>",
	-- 			desc = "Write commit message for staged changes",
	-- 		},
	-- 		{
	-- 			"<leader>ccv",
	-- 			function()
	-- 				local prefix = vim.fn.input("Prefix Input: ")
	-- 				local chat = require("CopilotChat")
	-- 				-- Directly use the prefix as the prompt, assuming `select.visual` automatically appends the visual selection
	-- 				chat.ask(prefix, { selection = require("CopilotChat.select").visual })
	-- 			end,
	-- 			mode = "x", -- This key mapping will be available in visual mode
	-- 			desc = "Chat with visual selection",
	-- 		},
	-- 		{
	-- 			"<leader>ccb",
	-- 			function()
	-- 				local prefix = vim.fn.input("Prefix Input: ")
	-- 				local chat = require("CopilotChat")
	-- 				-- Directly use the prefix as the prompt, assuming `select.buffer` automatically appends the buffer content
	-- 				chat.ask(prefix, { selection = require("CopilotChat.select").buffer })
	-- 			end,
	-- 			mode = "n", -- This key mapping will be available in normal mode
	-- 			desc = "Chat with buffer ",
	-- 		},
}
