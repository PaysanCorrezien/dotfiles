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
	{
		-- dir = "c:/repo/yazi.nvim", -- DEV : use local path
		"paysancorrezien/yazi.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},

		keys = {
			{ "<leader>e", "<cmd>Yazi<CR>", desc = "Toggle Yazi" },
		},
	},
}
