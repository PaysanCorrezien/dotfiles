return {
	{
		"almo7aya/openingh.nvim",
		cmd = { "OpenInGHRepo", "OpenInGHFile", "OpenInGHFileLines" },
		init = function()
			local wk = require("which-key")

			wk.register({
				["<leader>cg"] = { name = "+github" },
			})
		end,
		keys = {
			{ "<leader>cgg", "<cmd>OpenInGHFileLines<CR>", desc = "Open in GitHub File Lines" },
			{ "<leader>cgr", "<cmd>OpenInGHRepo<CR>", desc = "Open in GitHub Repo" },
			{ "<leader>cgf", "<cmd>OpenInGHFile<CR>", desc = "Open in GitHub File" },
		},
	},
}
