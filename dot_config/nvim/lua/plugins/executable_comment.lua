return {
	{
		"mini.comment",
		enabled = false,
	},
	{
		"numToStr/Comment.nvim",
		lazy = false,
		-- event = { "BufReadPost", "BufNewFile" },
		config = true,
		keys = {
			-- { "/", "<Plug>(comment_toggle_linewise_current)", desc = "Comment" },
		},
		-- 	filetypes_denylist = {
		-- 		"alpha",
		-- 		"dbui",
		-- 		"DiffviewFileHistory",
		-- 		"DiffviewFiles",
		-- 		"dirbuf",
		-- 		"dirvish",
		-- 		"DressingSelect",
		-- 		"fugitive",
		-- 		"fugitive",
		-- 		"git",
		-- 		"lazy",
		-- 		"lir",
		-- 		"lspinfo",
		-- 		"mason",
		-- 		"minifiles",
		-- 		"neogitstatus",
		-- 		"neo-tree",
		-- 		"notify",
		-- 		"NvimTree",
		-- 		"Outline",
		-- 		"packer",
		-- 		"SidebarNvim",
		-- 		"spectre_panel",
		-- 		"spectre_panel",
		-- 		"TelescopePrompt",
		-- 		"TelescopePrompt",
		-- 		"toggleterm",
		-- 		"toggleterm",
		-- 		"Trouble",
		-- },
	},
	-- disable trouble
	--TODO : End this not working right now
	-- For mini.comment to work
	-- vim.keymap.set({ "n", "x", "o" }, "<leader>/", function()
	--   local mode = vim.api.nvim_get_mode().mode
	--   if mode:sub(1, 1) == "n" then
	--     -- Normal mode - toggle comment on the current line
	--     vim.api.nvim_feedkeys(
	--       vim.api.nvim_replace_termcodes("<Cmd>lua MiniComment.operator()<CR>_", true, false, true),
	--       "n",
	--       false
	--     )
	--   elseif mode:sub(1, 1) == "v" then
	--     -- Visual and Visual-Line and Visual-Block modes - toggle comment on visual selection
	--     require("mini.comment").operator("visual")
	--   elseif mode == "o" then
	--     -- Operator-pending mode - select comment textobject
	--     require("mini.comment").textobject()
	--   end
	-- end, { noremap = true, silent = true, desc = "Comment" })
}
