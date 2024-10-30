local os_utils = require("utils.os_utils")
local powershell_parser_paths = {
	Windows = "C:\\repo\\tree-sitter-powershell\\",
	--	Linux = "/mnt/c/repo/nvim-treesitter-powershell/",
	Linux = "/home/dylan/repo/nvim-treesitter-powershell/",
}
local parser_path = os_utils.get_setting(powershell_parser_paths)

return {
	-- ADD WIP PowerShell parser
	-- {
	-- 	"nvim-treesitter/nvim-treesitter",
	-- 	config = function()
	-- 		-- Set preferred compiler order
	-- 		local install = require("nvim-treesitter.install")
	-- 		install.compilers = { "zig", "gcc" }
	-- 		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
	-- 		parser_config.powershell = {
	-- 			install_info = {
	-- 				url = parser_path, -- Directory of the installed parser
	-- 				files = { "src/parser.c", "src/scanner.c" },
	-- 				branch = "main",
	-- 			},
	-- 			filetype = "ps1", -- Associate the parser with 'ps1' files
	-- 		}
	-- 	end,
	-- },
	-- {
	-- 	"nvim-treesitter/nvim-treesitter",
	-- 	keys = {
	-- 		{ "<c-i>", desc = "Increment selection" },
	-- 		{ "<bs>", desc = "Decrement selection", mode = "x" },
	-- 	},
	-- 	---@type TSConfig
	-- 	---@diagnostic disable-next-line: missing-fields
	-- 	opts = {
	-- 		incremental_selection = {
	-- 			enable = true,
	-- 			keymaps = {
	-- 				init_selection = "<C-i>",
	-- 				node_incremental = "<C-i>",
	-- 				scope_incremental = false,
	-- 				node_decremental = "<bs>",
	-- 			},
	-- 		},
	-- 		textobjects = {
	-- 			move = {
	-- 				enable = true,
	-- 				set_jumps = true, -- whether to set jumps in the jumplist
	-- 				goto_next_start = {
	-- 					["]f"] = "@function.outer",
	-- 					["]c"] = "@class.outer",
	-- 					["]k"] = "@comment.outer",
	-- 					["]A"] = "@parameter.inner",
	-- 					["]m"] = "@function.outer",
	-- 					["]o"] = "@loop.*",
	-- 					["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
	-- 					["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
	-- 				},
	-- 				goto_next_end = {
	-- 					["]F"] = "@function.outer",
	-- 					["]C"] = "@class.outer",
	-- 					["]M"] = "@function.outer",
	-- 				},
	-- 				goto_previous_start = {
	-- 					["[f"] = "@function.outer",
	-- 					["[c"] = "@class.outer",
	-- 					["[k"] = "@comment.outer",
	-- 					["[A"] = "@parameter.inner",
	-- 					["[m"] = "@function.outer",
	-- 				},
	-- 				goto_previous_end = {
	-- 					["[F"] = "@function.outer",
	-- 					["[C"] = "@class.outer",
	-- 					["[M"] = "@function.outer",
	-- 				},
	-- 				goto_next = {
	-- 					["]D"] = "@conditional.outer",
	-- 				},
	-- 				goto_previous = {
	-- 					["[D"] = "@conditional.outer",
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- 	---@param opts TSConfig
	-- 	config = function(_, opts)
	-- 		if type(opts.ensure_installed) == "table" then
	-- 			---@type table<string, boolean>
	-- 			local added = {}
	-- 			opts.ensure_installed = vim.tbl_filter(function(lang)
	-- 				if added[lang] then
	-- 					return false
	-- 				end
	-- 				added[lang] = true
	-- 				return true
	-- 			end, opts.ensure_installed)
	-- 		end
	-- 		require("nvim-treesitter.configs").setup(opts)
	-- 	end,
	-- },
	-- Merged nvim-treesitter configuration
	{
		"nvim-treesitter/nvim-treesitter",
		-- Using init function to set up PowerShell parser
--		init = function(plugin)
--			-- Manually configure the PowerShell parser
--			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
--			parser_config.powershell = {
--				install_info = {
--					url = parser_path, -- Directory of the installed parser
--					files = { "src/parser.c", "src/scanner.c" },
--					branch = "main",
--				},
--				filetype = "ps1", -- Associate the parser with 'ps1' files
--			}
--
--			-- Set preferred compiler order
--			local install = require("nvim-treesitter.install")
--			install.compilers = { "zig", "gcc" }
--		end,
		-- Configuring the rest of nvim-treesitter settings
		config = function(plugin, opts)
			opts = {
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-m>",
						node_incremental = "<C-m>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
				textobjects = {
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]f"] = "@function.outer",
							["]c"] = "@class.outer",
							["]k"] = "@comment.outer",
							["]A"] = "@parameter.inner",
							["]m"] = "@function.outer",
							["]o"] = "@loop.*",
							["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
							["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
						},
						goto_next_end = {
							["]F"] = "@function.outer",
							["]C"] = "@class.outer",
							["]M"] = "@function.outer",
						},
						goto_previous_start = {
							["[f"] = "@function.outer",
							["[c"] = "@class.outer",
							["[k"] = "@comment.outer",
							["[A"] = "@parameter.inner",
							["[m"] = "@function.outer",
						},
						goto_previous_end = {
							["[F"] = "@function.outer",
							["[C"] = "@class.outer",
							["[M"] = "@function.outer",
						},
						goto_next = {
							["]D"] = "@conditional.outer",
						},
						goto_previous = {
							["[D"] = "@conditional.outer",
						},
					},
				},
			}
			-- Ensure PowerShell parser is installed
			-- opts.ensure_installed = opts.ensure_installed or {}
			-- table.insert(opts.ensure_installed, "powershell")
			-- Apply the configurations
			require("nvim-treesitter.configs").setup(opts)
		end,
		-- Keybindings and other specifications
		keys = {
			{ "<c-m>", desc = "Increment selection" },
			{ "<bs>", desc = "Decrement selection", mode = "x" },
		},
	},
}
