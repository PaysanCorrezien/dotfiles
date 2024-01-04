return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("plugins.colorscheme").setup({
				flavor = "mocha",
			})
		end,
	},
	{ "rebelot/kanagawa.nvim" },
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "kanagawa-dragon",
		},
	},
}
