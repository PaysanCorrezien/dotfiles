return {
	{
		"chrisgrieser/nvim-scissors",

		dependencies = "nvim-telescope/telescope.nvim", -- optional
		opts = {
			-- snippetDir = "~/AppData/Local/nvim/snippets/",
			snippetDir = vim.fn.stdpath("config") .. "/snippets",
			editSnippetPopup = {
				height = 0.6, -- relative to the window, number between 0 and 1
				width = 0.8,
				border = "rounded",
				keymaps = {
					cancel = "q",
					saveChanges = "<CR>", -- alternatively, can also use `:w`
					goBackToSearch = "<BS>",
					delete = "<C-BS>",
					openInFile = "<C-o>",
					insertNextToken = "<C-t>", -- insert & normal mode
					jumpBetweenBodyAndPrefix = "<Tab>", -- insert & normal mode
				},
				-- `none` writes as a minified json file using `vim.encode.json`.
				-- `yq`/`jq` ensure formatted & sorted json files, which is relevant when
				-- you version control your snippets.
				jsonFormatter = "jq", -- default none

				init = function()
					require("luasnip.loaders.from_vscode").lazy_load({
						paths = { vim.fn.stdpath("config") .. "/snippets" },
					})
				end,
				keys = {
					{ "<leader>ce", "<cmd>lua require('scissors').editSnippet()<CR>", desc = "Edit Snippets" },
					{ "<leader>cc", "<cmd>lua require('scissors').addNewSnippet()<CR>", desc = "Create Snippets" },
				},
			},
		},
	},
}
