lvim.plugins = {
	{ "lunarvim/colorschemes" },
	-- { "codethread/qmk.nvim",
	-- config = function()

	--   local conf = {
	--     name = 'LAYOUT',
	--     'x x x x x x x x x x x x',
	--       'x x x x x x x x x x x x',
	--       'x x x x x x x x x x x x',
	--       'x x x x x x _ x x x x x x x',
	--       '_ x x x _ _ _ x x x x',
	--   }
	--   require('qmk').setup(conf)
	-- end
	-- },
	{ "folke/tokyonight.nvim" },
	{ "rebelot/kanagawa.nvim" },
	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		config = function()
			require("todo-comments").setup()
		end,
	},
	-- { "OmniSharp/omnisharp-vim" },
	{
	  "folke/persistence.nvim",
	  event = "BufReadPre", -- this will only start session saving when an actual file was opened
    lazy = true,
	  config = function()
	    require("persistence").setup {
	      dir = vim.fn.expand(vim.fn.stdpath "config" .. "/session/"),
	      options = { "buffers", "curdir", "tabpages", "winsize" },
	    }
	  end,
	},
  {
  "folke/trouble.nvim",
    cmd = "TroubleToggle",
},
	-- {
	-- 	"epwalsh/obsidian.nvim",
	-- 	lazy = false,
	-- 	-- event = { "BufReadPre /home/dylan/Documents/Vault/**.md" },
	-- 	-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
	-- 	event = { "BufReadPre " .. vim.fn.expand("~") .. "/Documents/Obsidian Vault/**.md" },
	-- 	dependencies = {
	-- 		-- Required.
	-- 		"nvim-lua/plenary.nvim",

	-- 		-- Optional, for completion.
	-- 		"hrsh7th/nvim-cmp",

	-- 		-- Optional, for search and quick-switch functionality.
	-- 		"nvim-telescope/telescope.nvim",

	-- 		-- Optional, alternative to nvim-treesitter for syntax highlighting.
	-- 		-- "godlygeek/tabular",
	-- 		-- "preservim/vim-markdown",
	-- 	},
	-- 	opts = {
	-- 		dir = "~/Documents/Obsidian Vault/", -- no need to call 'vim.fn.expand' here

	-- 		-- Optional, if you keep notes in a specific subdirectory of your vault.
	-- 		notes_subdir = "Zettelkasten/Main",

	-- 		-- Optional, if you keep daily notes in a separate directory.
	-- 		daily_notes = {
	-- 			folder = "Tasks",
	-- 		},

	-- 		-- Optional, completion.
	-- 		completion = {
	-- 			nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
	-- 		},
	-- 		-- Optional, customize how names/IDs for new notes are created.
	-- 		note_id_func = function(title)
	-- 			-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
	-- 			-- In this case a note with the title 'My new note' will given an ID that looks
	-- 			-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
	-- 			local suffix = ""
	-- 			if title ~= nil then
	-- 				-- If title is given, transform it into valid file name.
	-- 				suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
	-- 			else
	-- 				-- If title is nil, just add 4 random uppercase letters to the suffix.
	-- 				for _ = 1, 4 do
	-- 					suffix = suffix .. string.char(math.random(65, 90))
	-- 				end
	-- 			end
	-- 			return tostring(os.time()) .. "-" .. suffix
	-- 		end,

	-- 		templates = {
	-- 			subdir = "Zettelkasten/Templates",
	-- 			-- date_format = "%Y-%m-%d-%a",
	-- 			-- time_format = "%H:%M",
	-- 		},
	-- 		use_advanced_uri = true,
	-- 		finder = "telescope.nvim",
	-- 	},
	-- 	config = function(_, opts)
	-- 		require("obsidian").setup(opts)

	-- 		-- Optional, override the 'gf' keymap to utilize Obsidian's search functionality.
	-- 		-- see also: 'follow_url_func' config option above.
	-- 		vim.keymap.set("n", "gf", function()
	-- 			if require("obsidian").util.cursor_on_markdown_link() then
	-- 				return "<cmd>ObsidianFollowLink<CR>"
	-- 			else
	-- 				return "gf"
	-- 			end
	-- 		end, { noremap = false, expr = true })
	-- 	end,
	-- },
	{
		"renerocksai/telekasten.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	-- { "renerocksai/calendar-vim" },
	{ "catppuccin/nvim", name = "catppuccin" },
	{ "theprimeagen/harpoon" },
	{ "christoomey/vim-tmux-navigator" },
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		-- event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"ecthelionvi/NeoComposer.nvim",
		dependencies = { "kkharji/sqlite.lua" },
		opts = {},
	},

	{ "ggandor/leap.nvim" },
	{ "ggandor/flit.nvim" },

	-- {
	--   "jcdickinson/http.nvim",
	--   build = "cargo build --workspace --release"
	-- },
	-- {
	--   "jcdickinson/codeium.nvim",
	--   dependencies = {
	--     -- "jcdickinson/http.nvim",
	--     "nvim-lua/plenary.nvim",
	--     "hrsh7th/nvim-cmp",
	--   },
	--   config = function()
	--     require("codeium").setup({
	--     })
	--   end
	-- },
	-- { 'Exafunction/codeium.vim',
	--   config = function()
	--     vim.g.codeium_enabled = false
	--   end,
	-- },
	{
		"jackMort/ChatGPT.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("chatgpt").setup({
				chat = {
					keymaps = {
						close = "<C-c>",
						yank_last = "<C-y>",
						scroll_up = "<C-u>",
						scroll_down = "<C-d>",
						toggle_settings = "<C-o>",
						new_session = "<C-n>",
						cycle_windows = "<Tab>",
						select_session = "<C-g>",
					},
				},

				actions_paths = { "/home/dylan/.config/lvim/correct_french.json" },
				predefined_chat_gpt_prompts = "http://127.0.0.1:8080/prompts.csv",
				popup_input = {
					submit = "<CR>",
				},
			})
		end,
	},
	{ "tpope/vim-repeat" },
	{ "tpope/vim-obsession" },
	{
		"barreiroleo/ltex_extra.nvim",
		ft = { "markdown", "tex" },
		dependencies = { "neovim/nvim-lspconfig" },
		-- yes, you can use the opts field, just I'm showing the setup explicitly
		config = function()
			require("ltex_extra").setup({
				-- your_ltex_extra_opts,
				-- table <string> : languages for witch dictionaries will be loaded, e.g. { "es-AR", "en-US" }
				-- https://valentjn.github.io/ltex/supported-languages.html#natural-languages
				load_langs = { "fr" }, -- en-US as default
				-- boolean : whether to load dictionaries on startup
				init_check = true,
				-- string : relative or absolute paths to store dictionaries
				-- e.g. subfolder in current working directory: ".ltex"
				-- e.g. shared files for all projects :  vim.fn.expand("~") .. "/.local/share/ltex"
				path = "~/.config/lvim/dict", -- current working directory
				-- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
				log_level = "none",
				-- table : configurations of the ltex language server.
				-- Only if you are calling the server from ltex_extra
				server_opts = {
					-- capabilities = your_capabilities,
					on_attach = function(client, bufnr)
						-- your on_attach process
					end,
					settings = {
						ltex = {
							-- cmd = { "/home/dylan/.local/share/nvim/lsp_servers/ltex/ltex-ls/bin/ltex-ls" },
							language = "fr",
							diagnosticSeverity = "information",
							setenceCacheSize = 2000,
							additionalRules = {
								enablePickyRules = true,
								motherTongue = "fr",
							},
							trace = { server = "verbose" },
							-- dictionary = "~/.config/lvim/dict/", -- added global dictionary path
							completionEnabled = "true",
							checkfrenquency = "edit",
							statusBarItem = "true",
							disabledRules = {},
							-- hiddenFalsePositives = {},
						},
					},
				},
			})
		end,
	},
	{
		"folke/noice.nvim",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
	{ "nvim-tree/nvim-web-devicons", lazy = false },
	{
		"stevearc/dressing.nvim",
		{
			"ziontee113/icon-picker.nvim",
			config = function()
				require("icon-picker").setup({
					disable_legacy_commands = true,
				})
			end,
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{ "debugloop/telescope-undo.nvim" },
	{ dir = "~/Documents/Projets/NeovimPlugins/ObsidianExtra.nvim" },
  --lazy
{
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
},
	{
		"AckslD/nvim-neoclip.lua",
		dependencies = {
			-- you'll need at least one of these
			{ "nvim-telescope/telescope.nvim" },
			-- {'ibhagwan/fzf-lua'},
		},
		config = function()
			require("neoclip").setup()
		end,
	},
}
