-- File where i ovveride default presets
return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function(_, opts)
			-- table.remove(opts.sections.lualine_b)
			-- Inserting your custom function into lualine_c
			table.insert(opts.sections.lualine_a, {
				function()
					return require("NeoComposer.ui").status_recording()
				end,
			})
			table.insert(opts.sections.lualine_y, { "" })
			table.insert(opts.sections.lualine_y, { "encoding" })
			-- NOTE : Last commit date
			table.insert(opts.sections.lualine_b, {
				function()
					-- Attempt to execute the Git command
					local handle = io.popen('git log -1 --format="%cd" --date=format:"%d/%m %H:%M" 2> /dev/null')

					-- Check if the command execution was successful
					if handle then
						local result = handle:read("*a")
						handle:close()

						-- Remove any trailing newline character
						result = string.gsub(result, "\n", "")

						-- Git icon (adjust based on your font and preferences)
						local git_icon = " " -- Example icon using Nerd Fonts

						-- Return the git icon and formatted date or an empty string if result is empty
						return (result ~= "" and git_icon .. result) or ""
					else
						-- Return an empty string if handle is nil (command execution failed)
						return ""
					end
				end,
			})
		end,
	},
	-- WORK just fine
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		opts = function(_, opts)
			opts.options.numbers = "ordinal"
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      { "<leader>/" , false },

			{ "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Search Word in Dir" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
			{ "<leader>r", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
			{
				"<leader>fp",
				function()
					require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
				end,
				desc = "Find Plugin File",
			},
			{
				"<leader>fP",
				function()
					require("telescope.builtin").live_grep({ cwd = require("lazy.core.config").options.root })
				end,
				desc = "Find Plugin File",
			},
			{
				"<leader>fD",
				function()
					local path = jit.os:lower():find("windows") and "L:\\home\\dylan\\.local\\share\\chezmoi\\"
						or "/home/dylan/.local/share/chezmoi/"
					require("telescope.builtin").find_files({ cwd = path })
				end,
				desc = "DotFiles",
			},
		},
		-- change some options
		opts = {
			defaults = {
				layout_strategy = "horizontal",
				-- layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				winblend = 0,
			},
		},
	},

	-- {
	--   "nvim-lualine/lualine.nvim",
	--   event = "VeryLazy",
	--   init = function()
	--     vim.g.lualine_laststatus = vim.o.laststatus
	--     if vim.fn.argc(-1) > 0 then
	--       -- set an empty statusline till lualine loads
	--       vim.o.statusline = " "
	--     else
	--       -- hide the statusline on the starter page
	--       vim.o.laststatus = 0
	--     end
	--   end,
	--   opts = function()
	--     -- PERF: we don't need this lualine require madness 🤷
	--     local lualine_require = require("lualine_require")
	--     lualine_require.require = require
	--
	--     local icons = require("lazyvim.config").icons
	--
	--     vim.o.laststatus = vim.g.lualine_laststatus
	--
	--     return {
	--       options = {
	--         theme = "auto",
	--         globalstatus = true,
	--         disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
	--       },
	--       sections = {
	--         lualine_a = { "mode" },
	--         lualine_b = { "branch" },
	--
	--         lualine_c = {
	--           Util.lualine.root_dir(),
	--           {
	--             "diagnostics",
	--             symbols = {
	--               error = icons.diagnostics.Error,
	--               warn = icons.diagnostics.Warn,
	--               info = icons.diagnostics.Info,
	--               hint = icons.diagnostics.Hint,
	--             },
	--           },
	--           { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
	--           { Util.lualine.pretty_path() },
	--         },
	--         lualine_x = {
	--         -- stylua: ignore
	--         {
	--           function() return require("noice").api.status.command.get() end,
	--           cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
	--           color = Util.ui.fg("Statement"),
	--         },
	--         -- stylua: ignore
	--         {
	--           function() return require("noice").api.status.mode.get() end,
	--           cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
	--           color = Util.ui.fg("Constant"),
	--         },
	--         -- stylua: ignore
	--         {
	--           function() return "  " .. require("dap").status() end,
	--           cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
	--           color = Util.ui.fg("Debug"),
	--         },
	--           {
	--             require("lazy.status").updates,
	--             cond = require("lazy.status").has_updates,
	--             color = Util.ui.fg("Special"),
	--           },
	--           {
	--             "diff",
	--             symbols = {
	--               added = icons.git.added,
	--               modified = icons.git.modified,
	--               removed = icons.git.removed,
	--             },
	--             source = function()
	--               local gitsigns = vim.b.gitsigns_status_dict
	--               if gitsigns then
	--                 return {
	--                   added = gitsigns.added,
	--                   modified = gitsigns.changed,
	--                   removed = gitsigns.removed,
	--                 }
	--               end
	--             end,
	--           },
	--         },
	--         lualine_y = {
	--           { "progress", separator = " ", padding = { left = 1, right = 0 } },
	--           { "location", padding = { left = 0, right = 1 } },
	--         },
	--         -- lualine_z = {
	--         --   function()
	--         --     return " " .. os.date("%R")
	--         --   end,
	--         -- },
	--       },
	--       extensions = { "neo-tree", "lazy" },
	--     }
	--   end,
	-- },
}
