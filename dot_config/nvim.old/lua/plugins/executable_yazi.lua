return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		enabled = false,
		-- keys = {
		-- 	-- disable the keymap to grep files
		-- 	{ "<leader>e", false },
		-- 	-- change a keymap
		-- }	},,
	},
	{
		"echasnovski/mini.files",
		enabled = false,
	},
	{
		"echasnovski/mini.pairs",
		enabled = false,
	},
	-- {
	-- 	"rolv-apneseth/tfm.nvim",
	-- 	config = function()
	-- 		-- Set keymap so you can open the default terminal file manager (yazi)
	-- 		vim.api.nvim_set_keymap("n", "<leader>e", "", {
	-- 			noremap = true,
	-- 			callback = require("tfm").open,
	-- 		})
	-- 	end,
	-- },
	---@type LazySpec
	{
		"mikavilpas/yazi.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = "VeryLazy",
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{
				"<leader>e",
				function()
					require("yazi").yazi()
				end,
				desc = "Open the file manager",
			},
			{
				-- Open in the current working directory
				"<leader>-",
				function()
					require("yazi").yazi(nil, vim.fn.getcwd())
				end,
				desc = "Open the file manager in nvim's working directory",
			},
		},
		---@type YaziConfig
		opts = {
			open_for_directories = false,
		},
	},
}
