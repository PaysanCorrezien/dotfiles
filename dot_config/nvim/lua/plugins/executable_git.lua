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
	{
		"tpope/vim-fugitive",
		keys = {
			{ "<leader>gg", false },
			{ "<leader>gG", false },
			{ "<leader>gB", "<cmd>Telescope git_branches<CR>", desc = "Git Branches" },
			{ "<leader>gb", "<cmd>Git blame<CR>", desc = "Git Blame" },
			{ "<leader>gd", "<cmd>Gdiffsplit<CR>", desc = "Git Diff" },
			{ "<leader>gC", "<cmd>Git commit<CR>", desc = "Git Commit" },
			{ "<leader>gp", "<cmd>Git push<CR>", desc = "Git Push" },
			{ "<leader>gP", "<cmd>Git pull<CR>", desc = "Git Pull" },
			{ "<leader>gg", "<cmd>Git<CR>", desc = "Git UI" },
			{ "<leader>gG", "<cmd>Git fetch --all<CR>", desc = "Git Fetch All" },
			{ "<leader>gl", "<cmd>Git log<CR>", desc = "Git Log" },
			{ "<leader>gr", "<cmd>Gread<CR>", desc = "Git Reset file" },
			{ "<leader>ga", "<cmd>Gwrite<CR>", desc = "Git add File" },
			{ "<leader>gR", "<cmd>Gremove<CR>", desc = "Git Remove" },
			{ "<leader>gm", "<cmd>Gmove<CR>", desc = "Git Move" },
			{ "<leader>gA", "<cmd>Git add .<CR>", desc = "Git Add All cwd" },
			{ "<leader>gM", "<cmd>Git mergetool<CR>", desc = "Git Merge Tool" },
			{ "<leader>ge", "<cmd>Gedit<CR>", desc = "Git Edit" },
			{ "<leader>gv", "<cmd>Gvsplit<CR>", desc = "Git Vertical Split" },
		},
	},
}
