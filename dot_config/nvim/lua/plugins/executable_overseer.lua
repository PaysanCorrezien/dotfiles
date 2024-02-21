return {
	{
		"stevearc/overseer.nvim",
		event = "VeryLazy",
		opts = {},
		config = function()
			require("overseer").setup({
				templates = { "builtin", "user.cpp_build", "powershell", "user.rustdev1" },
			})
		end,
		keys = {
			{ "<leader>9", "<cmd>OverseerRun<CR>", desc = "Run OverseerRun" },
			{
				"<leader>P",
				function()
					local script_path = vim.fn.expand("%:p"):gsub("\\", "/") -- Ensure POSIX-style paths
					local term_command =
						string.format("wezterm cli split-pane --horizontal -- pwsh -NoExit -c \". '%s'\"", script_path)
					os.execute(term_command)
				end,
				desc = "Source PowerShell Script in New Terminal",
			},
		},
	},
}
