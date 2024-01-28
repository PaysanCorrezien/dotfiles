local gptnvim_action_path = "L:\\home\\dylan\\.config\\lvim\\correct_french.json"

return {
	"jackMort/ChatGPT.nvim",
	lazy = true,
	-- event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("chatgpt").setup({
			openai_params = {
				model = "gpt-4-1106-preview",
				frequency_penalty = 0,
				presence_penalty = 0,
				max_tokens = 1000,
				temperature = 0,
				top_p = 1,
				n = 1,
			},
			actions_paths = { gptnvim_action_path },
			predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/PaysanCorrezien/dotfiles/main/dot_config/lvim/prompts.csv",
		})
	end,
	init = function()
		local wk = require("which-key")

		wk.register({
			["<leader>x"] = { name = "Misc + AI" },
		}, { mode = "n" }) -- Register for normal mode

		wk.register({
			["<leader>x"] = { name = "Misc + AI" },
		}, { mode = "v" }) -- Register for visual mode
	end,
	keys = {
		{ "<leader>xg", "<cmd>ChatGPT<cr>", desc = "GPT Chat", mode = { "n", "v" } },
		{ "<leader>xA", "<cmd>ChatGPTActAs<cr>", desc = "ChatGPT Act As", mode = { "n", "v" } },
		{ "<leader>xt", "<cmd>ChatGPTEditWithInstructions<cr>", desc = "Edit with Instructions", mode = { "n", "v" } },
		{ "<leader>xC", "<cmd>ChatGPTRun complete_code<cr>", desc = "Complete Code", mode = { "n", "v" } },
		{ "<leader>xP", "<cmd>ChatGPTRun powershellDocs<cr>", desc = "Powershell Docs", mode = { "n", "v" } },
		{ "<leader>xL", "<cmd>ChatGPTRun luaEmmyDocs<cr>", desc = "Lua Docs", mode = { "n", "v" } },
		{ "<leader>xS", "<cmd>ChatGPTRun summarize<cr>", desc = "Summarize", mode = { "n", "v" } },
		{ "<leader>xD", "<cmd>ChatGPTRun docstrings<cr>", desc = "Docstrings", mode = { "n", "v" } },
	},
	-- {
	--   "zbirenbaum/copilot.lua",
	--   cmd = "Copilot",
	--   build = ":Copilot auth",
	--   opts = {
	--     suggestion = { enabled = false },
	--     panel = { enabled = false },
	--     filetypes = {
	--       markdown = false,
	--       help = false,
	--       -- config files with credentials
	--       yaml = false,
	--       toml = false,
	--       json = false,
	--     },
	--   },
	-- },
}
