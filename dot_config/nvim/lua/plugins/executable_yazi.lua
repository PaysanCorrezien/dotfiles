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
		"rolv-apneseth/tfm.nvim",
		config = function()
			-- Set keymap so you can open the default terminal file manager (yazi)
			vim.api.nvim_set_keymap("n", "<leader>e", "", {
				noremap = true,
				callback = require("tfm").open,
			})
		end,
	},
}
