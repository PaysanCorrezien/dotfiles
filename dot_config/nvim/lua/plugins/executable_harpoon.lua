return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		requires = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("harpoon").setup()
		end,
		keys = {
			{
				"<leader>A",
				function()
					require("harpoon"):list():append()
				end,
				desc = "harpoon file",
			},
			{
				"<leader>a",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "harpoon quick menu",
			},
			{
				"<c-1>",
				function()
					require("harpoon"):list():select(1)
				end,
				desc = "harpoon to file 1",
			},
			{
				"<c-2>",
				function()
					require("harpoon"):list():select(2)
				end,
				desc = "harpoon to file 2",
			},
			{
				"<c-3>",
				function()
					require("harpoon"):list():select(3)
				end,
				desc = "harpoon to file 3",
			},
			{
				"<c-4>",
				function()
					require("harpoon"):list():select(4)
				end,
				desc = "harpoon to file 4",
			},
			{
				"<c-5>",
				function()
					require("harpoon"):list():select(5)
				end,
				desc = "harpoon to file 5",
			},
			{
				"<C-e>",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "Toggle H(rpoon Menu",
				mode = { "n" },
			},
			-- Toggle previous & next buffers stored within H(rpoon list
			{
				"<C-H>",
				function()
					require("harpoon"):list():prev()
				end,
				desc = "harpoon previous buffer",
			},
			{
				"<C-L>",
				function()
					require("harpoon"):list():next()
				end,
				desc = "harpoon next buffer",
			},
		},
	},
}
