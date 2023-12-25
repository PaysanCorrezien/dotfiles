-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
	"lua",
	"rust",
	"toml",
	"bash",
	"json",
	"markdown",
	"svelte",
	"python",
	"html",
	"css",
	"yaml",
	"javascript",
	--not available sadly
	-- "powershell"
}


-- require("nvim-treesitter.configs").setup({
-- 	textobjects = {
-- 		select = {
-- 			enable = true,

-- 			-- Automatically jump forward to textobj, similar to targets.vim
-- 			lookahead = true,

-- 			keymaps = {
-- 				["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter" },
-- 				["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter" },
-- 				["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
-- 				["if"] = { query = "@function.inner", desc = "Select inner part of a function" },
-- 				["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
-- 				["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
-- 				["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },
-- 				["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
-- 				["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },
-- 				["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
-- 				["at"] = { query = "@comment.outer", desc = "Select outer part of a comment" },
-- 				["it"] = { query = "@comment.inner", desc = "Select inner part of a comment" },
-- 			},
-- 			-- You can choose the select mode (default is charwise 'v')
-- 			--
-- 			-- Can also be a function which gets passed a table with the keys
-- 			-- * query_string: eg '@function.inner'
-- 			-- * method: eg 'v' or 'o'
-- 			-- and should return the mode ('v', 'V', or '<c-v>') or a table
-- 			-- mapping query_strings to modes.
-- 			selection_modes = {
-- 				["@parameter.outer"] = "v", -- charwise
-- 				["@function.outer"] = "V", -- linewise
-- 				["@class.outer"] = "<c-b>", -- blockwise
-- 			},
-- 			-- If you set this to `true` (default is `false`) then any textobject is
-- 			-- extended to include preceding or succeeding whitespace. Succeeding
-- 			-- whitespace has priority in order to act similarly to eg the built-in
-- 			-- `ap`.
-- 			--
-- 			-- Can also be a function which gets passed a table with the keys
-- 			-- * query_string: eg '@function.inner'
-- 			-- * selection_mode: eg 'v'
-- 			-- and should return true of false
-- 			include_surrounding_whitespace = true,
-- 		},
-- 		move = {
-- 			enable = true,
-- 			set_jumps = true, -- whether to set jumps in the jumplist
-- 			goto_next_start = {
-- 				["]m"] = { query = "@function.outer", desc = "Go to next function start" },
-- 				["]]"] = { query = "@class.outer", desc = "Go to next class start" },
-- 				["]o"] = { query = "@loop.outer", desc = "Go to next loop start" },
-- 				["]s"] = { query = "@scope", desc = "Go to next scope start" },
-- 				["]z"] = { query = "@fold", desc = "Go to next fold start" },
-- 			},
-- 			goto_next_end = {
-- 				["]M"] = { query = "@function.outer", desc = "Go to next function end" },
-- 				["]["] = { query = "@class.outer", desc = "Go to next class end" },
-- 			},
-- 			goto_previous_start = {
-- 				["[m"] = { query = "@function.outer", desc = "Go to previous function start" },
-- 				["[["] = { query = "@class.outer", desc = "Go to previous class start" },
-- 			},
-- 			goto_previous_end = {
-- 				["[M"] = { query = "@function.outer", desc = "Go to previous function end" },
-- 				["[]"] = { query = "@class.outer", desc = "Go to previous class end" },
-- 			},
-- 			goto_next = {
-- 				["]d"] = { query = "@conditional.outer", desc = "Go to next conditional" },
-- 			},
-- 			goto_previous = {
-- 				["[d"] = { query = "@conditional.outer", desc = "Go to previous conditional" },
-- 			},
-- 		},
-- 	},
-- })
