local os_utils = require("utils.os_utils")
local cmp = require("cmp")

-- TODO: find a way to make this automatic with a single array and automatic conversion with a function
local home = os.getenv("HOME") or "~"
-- Define OS-specific paths for both the vault and attachments
-- Settings with paths
obsidiannvim_settings = {
	vault_paths = {
		-- Windows = "D:/Users/dylan/Documents//",
		Windows = "D:\\notes\\",
		Linux = "/mnt/d/notes//",
	},
	attachments_paths = {
		Windows = "D:\\notes\\\\static\\img\\",
		Linux = "/mnt/d/notes//static/img/",
	},
	pdftoppm_paths = {
		Windows = "D:\\Users\\dylan\\scoop\\shims\\pdftoppm.exe",
		Linux = "/usr/bin/pdftoppm",
	},
	templates_paths = {
		Windows = "D:\\notes\\\\Projets\\Templates\\",
		Linux = "/mnt/d/notes//Projets/Templates/",
	},
}

-- Retrieve the correct paths based on the OS
local obsidian_vault_path = os_utils.get_setting(obsidiannvim_settings.vault_paths)
local obsidian_attachments_path = os_utils.get_setting(obsidiannvim_settings.attachments_paths)
local pdftoppm__path = os_utils.get_setting(obsidiannvim_settings.pdftoppm_paths)
local templates_path = os_utils.get_setting(obsidiannvim_settings.templates_paths)

-- - Retrieve the correct path based on the OS
-- local obsidian_vault_path = os_utils.get_setting(obsidiannvim_paths)

local pdf_paths = {
	Windows = "c:\\Users\\dylan\\Documents\\Projet\\Work\\Projet\\pdf.nvim",
	Linux = "/mnt/c/user/dylan/Documents/Projet/Work/Projet/pdf.nvim/",
}

local pdf_plugin_path = os_utils.get_setting(pdf_paths)

local dictionary_path = {
	Windows = "C:\\Users\\dylan\\Documents\\Projet\\Work\\Projet\\dictionary.nvim",
	Linux = "/mnt/c/notes/Projet/Work/Projet/dictionary.nvim/",
}
local dictionary_plugin_path = os_utils.get_setting(dictionary_path)

local dictionaries_files_path = {
	remote_ltex_ls = {
		Windows = "L:\\home\\dylan\\.local\\share\\chezmoi\\dot_config\\lvim\\dict\\ltex.dictionary.fr.txt",
		Linux = home .. "/.local/share/chezmoi/dot_config/lvim/dict/ltex.dictionary.fr.txt",
	},
	remote_spell = {
		Windows = "L:\\home\\dylan\\.local\\share\\chezmoi\\dot_config\\lvim\\dict\\spell.utf-8.add",
		Linux = home .. "/.local/share/chezmoi/dot_config/lvim/dict/spell.utf-8.add",
	},
	local_ltex_ls = {
		Windows = "L:\\home\\dylan\\.config\\lvim\\dict\\ltex.dictionary.fr.txt",
		Linux = home .. "/.config/lvim/dict/ltex.dictionary.fr.txt",
	},
	local_spell = {
		Windows = "L:\\home\\dylan\\.config\\lvim\\dict\\spell.utf-8.add",
		Linux = home .. "/.config/lvim/dict/spell.utf-8.add",
	},
}
local remote_ltex_ls = os_utils.get_setting(dictionaries_files_path.remote_ltex_ls)
local remote_spell = os_utils.get_setting(dictionaries_files_path.remote_spell)
local local_ltex_ls = os_utils.get_setting(dictionaries_files_path.local_ltex_ls)
local local_spell = os_utils.get_setting(dictionaries_files_path.local_spell)

local ltex_extra_plugin_cwd = {

	Windows = "L:\\home\\dylan\\.config\\lvim\\dict",
	Linux = home .. "/.config/lvim/dict",
}

local ltex_extra_cwd = os_utils.get_setting(ltex_extra_plugin_cwd)

return {
	{
		"barreiroleo/ltex_extra.nvim",
		lazy = true,
		-- TODO: remove when PR merged

		commit = "6d00bf2fbd6fcecafd052c0e0f768b67ceb3307f",
		ft = { "markdown", "tex" },
		dependencies = { "neovim/nvim-lspconfig" },
		-- yes, you can use the opts field, just I'm showing the setup explicitly
		config = function()
			require("ltex_extra").setup({
				-- your_ltex_extra_opts,
				-- table <string> : languages for witch dictionaries will be loaded, e.g. { "es-AR", "en-US" }
				-- https://valentjn.github.io/ltex/supported-languages.html#natural-languages
				load_langs = { "fr", "en" }, -- en-US as default
				-- boolean : whether to load dictionaries on startup
				init_check = true,
				-- string : relative or absolute paths to store dictionaries
				-- e.g. subfolder in current working directory: ".ltex"
				-- e.g. shared files for all projects :  vim.fn.expand("~") .. "/.local/share/ltex"
				-- path = "~/.config/lvim/dict", -- current working directory
				path = ltex_extra_cwd,
				-- cant work because \\\\ are poorly interpreted
				-- path = "\\\\wsl.localhost\\Debian\\home\\dylan\\.config\\lvim\\dict",
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
							language = "en",
							diagnosticSeverity = "information",
							setenceCacheSize = 2000,
							additionalRules = {
								enablePickyRules = true,
								motherTongue = "fr",
							},
							-- trace = { server = "verbose" },
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
		-- dir = dictionary_plugin_path, -- DEV : use local path
		"paysancorrezien/dictionary.nvim", -- PROD : use remote path
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("dictionary").setup({
				dictionary_paths = {
					remote_ltex_ls,
					remote_spell,
					local_ltex_ls,
					local_spell,
				},
				override_zg = true,
				ltex_dictionary = true, -- if you are use ltex-ls extra and want to use zg to also update ltex-ls dictionary
				cmp = {
					enabled = true,
					custom_dict_path = local_ltex_ls,
					max_spell_suggestions = 10,
					filetypes = { "markdown", "tex" },
					priority = 20000,
					name = "dictionary",
					source_label = "[Dict]",
					-- kind_icon = cmp.lsp.CompletionItemKind.Event, -- Icon for suggestions
					-- kind_icon = " ", -- Icon need to be registered on lsp icons
				},
			})
		end,
	},
	-- register custom cmp for dict
	{
		"nvim-cmp",
		dependencies = {},
		opts = function(_, opts)
			-- Add the obsidian sources to CMP
			-- table.insert(opts.sources, { name = "obsidian", priority = 100 })
			-- table.insert(opts.sources, { name = "obsidian_new", priority = 100 })
			-- table.insert(opts.sources, { name = "obsidian_tags", priority = 100 })

			-- Add the dictionary source to CMP
			table.insert(opts.sources, 1, {
				name = "dictionary",
				priority = 20000, -- Custom priority
			})

			-- Custom formatting for dictionary items
			local existing_formatting_function = opts.formatting.format
			opts.formatting.format = function(entry, vim_item)
				if entry.source.name == "dictionary" then
					-- vim_item.kind = cmp.lsp.CompletionItemKind.Text -- this make crash
					vim_item.menu = "[Dict]" -- Custom label
				elseif existing_formatting_function then
					vim_item = existing_formatting_function(entry, vim_item)
				end
				return vim_item
			end
		end,
	},

	{
		-- dir = pdf_plugin_path, -- DEV : use local path
		"paysancorrezien/pdf.nvim", -- PROD : use remote path
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("pdf").setup({
				pdf_path = obsidian_attachments_path,
				image_path = obsidian_attachments_path,
				pdftoppm_path = pdftoppm__path,
				new_link_format = function(prefix, text, generated_image_file)
					return prefix .. "[" .. text .. "](/img/" .. generated_image_file .. ")"
				end,
			})
		end,
	},
	-- {
	-- 	"renerocksai/telekasten.nvim",
	-- 	dependencies = { "nvim-telescope/telescope.nvim" },
	-- 	config = function()
	-- 		require("telekasten").setup({
	-- 			home = obsidian_vault_path,
	-- 		})
	-- 	end,
	-- },
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		-- event = { "BufReadPre /home/dylan/Documents/Vault/**.md" },
		-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
		-- event = { "BufReadPre " .. obsidian_vault_path .. "/**.md" },
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- Optional, for completion.
			"hrsh7th/nvim-cmp",

			-- Optional, for search and quick-switch functionality.
			"nvim-telescope/telescope.nvim",

			-- Optional, alternative to nvim-treesitter for syntax highlighting.
			-- "godlygeek/tabular",
			-- "preservim/vim-markdown",
		},
		opts = {
			-- dir = "~/Documents/",
			-- dir = obsidian_vault_path, -- no need to call 'vim.fn.expand' here
			workspaces = {
				{
					name = "personal",
					-- path = obsidian_vault_path,
					path = "D:\\notes\\",
					overrides = {
						notes_subdir = "Docs\\KnowledgeBase", --TODO: inline function for this ?
					},
				},
				{
					name = "work",
					path = "~/Documents/Notes",
				},
			},
			-- Optional, if you keep daily notes in a separate directory.
			daily_notes = {
				folder = "Tasks",
			},

			-- Optional, comtruepletion.
			--  BUG: dot work on windows ?
			--
			completion = {
				nvim_cmp = false, -- if using nvim-cmp, otherwise set to false
				-- new_notes_location = "current_dir",
				new_notes_location = "notes_subdir",
				use_path_only = true,
				-- Trigger completion at 2 chars.
				-- min_chars = 1,
			},
			attachments = {
				-- The default folder to place images in via `:ObsidianPasteImg`.
				-- If this is a relative path it will be interpreted as relative to the vault root.
				-- You can always override this per image by passing a full path to the command instead of just a filename.
				img_folder = obsidian_attachments_path, -- This is the default
				-- A function that determines the text to insert in the note when pasting an image.
				-- It takes two arguments, the `obsidian.Client` and a plenary `Path` to the image file.
				-- This is the default implementation.
				---@param client obsidian.Client
				---@param path Path the absolute path to the image file
				---@return string
				img_text_func = function(client, path)
					local link_path
					local vault_relative_path = client:vault_relative_path(path)
					if vault_relative_path ~= nil then
						-- Use the modified path if the image is saved in the vault dir.
						-- Strip off unwanted parts of the path and keep only '/img/' and the file name
						link_path = string.match(vault_relative_path, "../../static/img/.+$")
					else
						-- For absolute paths, extract only the '/img/' part and the file name.
						link_path = string.match(tostring(path), "../static/img/.+$")
					end
					if not link_path then
						-- Fallback in case the desired pattern is not found
						link_path = tostring(path)
					end
					local display_name = vim.fs.basename(link_path)
					return string.format("![%s](%s)", display_name, link_path)
				end,
			},
			-- Optional, customize how names/IDs for new notes are created.
			note_id_func = function(title)
				-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
				-- In this case a note with the title 'My new note' will given an ID that looks
				-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
				--
				local suffix = ""
				if title ~= nil then
					-- If title is given, transform it into valid file name.
					suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
				else
					-- If title is nil, just add 4 random uppercase letters to the suffix.
				end
				return suffix
			end,
			-- Optional, boolean or a function that takes a filename and returns a boolean.
			-- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
			--TODO :
			-- maybe make use ok note_frontmatter_func = function(note)
			-- Optional, alternatively you can customize the frontmatter data.
			note_frontmatter_func = function(note)
				-- Create an output table for the frontmatter
				local out = {}

				out["title"] = note.id -- or any other string you want to use as the title
				out["tags"] = note.tags
				out["date"] = os.date("%Y-%m-%d %H:%M") -- Formats the date as "YYYY-MM-DD"
				out["personal_only"] = true

				-- Add any manually added fields from note.metadata
				if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
					for k, v in pairs(note.metadata) do
						out[k] = v
					end
				end
				-- Return the customized frontmatter
				return out
			end,
			ui = {
				enable = false, -- set to false to disable all additional syntax features
			},

			templates = {
				subdir = "Projets/Templates",
				date_format = "%Y-%m-%d",
				time_format = "%H:%M",
			},
			-- use_advanced_uri = true,
			finder = "telescope.nvim",
			sort_by = "modified",
			sort_reversed = true,

			-- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
			-- way then set 'mappings = {}'.
			mappings = {
				-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
				["gf"] = {
					action = function()
						return require("obsidian").util.gf_passthrough()
					end,
					opts = { noremap = false, expr = true, buffer = true },
				},
				-- -- Toggle check-boxes.
				-- ["<leader>zx"] = {
				-- 	action = function()
				-- 		return require("obsidian").util.toggle_checkbox()
				-- 	end,
				-- 	opts = { buffer = true },
				-- },
			},
			-- log_level = vim.log.levels.TRACE,
		},
		init = function()
			local wk = require("which-key")

			wk.register({
				["<leader>z"] = { name = "+NoteTaking" },
			})
		end,
		keys = {

			{ "<leader>zf", "<cmd>ObsidianQuickSwitch<CR>", desc = "Find Notes" },
			{ "<leader>zG", "<cmd>ObsidianSearch<CR>", desc = "Grep Notes" },
			{ "<leader>zg", "<cmd>ObsidianFollowLink<CR>", desc = "Follow Link", mode = { "n", "v" } },
			{ "<leader>zz", "<cmd>ObsidianBacklinks<CR>", desc = "List Link" },
			{ "<leader>zC", "<cmd>ObsidianCheck<CR>", desc = "Checks" },
			{ "<leader>zi", "<cmd>ObsidianPasteImg<CR>", desc = "Insert IMG" },
			{
				"<leader>zR", -- BUG:  cant rename my notes ? path issue maybe
				function()
					local input = vim.fn.input("Enter new note title: ")
					if input ~= "" then
						vim.cmd("ObsidianRename" .. input)
					end
				end,
				desc = "Rename",
			},
			{ "<leader>zt", "<cmd>ObsidianTemplate<CR>", desc = "Template" },
			{ "<leader>zT", "<cmd>ObsidianTemplate knowledge.md<CR>", desc = "Default Template" },
			{
				"<leader>zn",
				function()
					local input = vim.fn.input("Enter note title: ")
					if input ~= "" then
						vim.cmd("ObsidianNew " .. input)
					end
				end,
				desc = "New Note in Docs/KnowledgeBase with input prompt",
			},

			{ "<leader>zB", "<cmd>ObsidianBacklinks<CR>", desc = "Backlinks" },
			{ "<leader>zL", "<cmd>ObsidianLink<CR>", desc = "Link", mode = { "n", "v" } },
			{ "<leader>zl", "<cmd>ObsidianLinkNew<CR>", desc = "Link New", mode = { "n", "v" } },
			-- { "<leader>zn", "<Cmd>lua CreateNote()<CR>", desc = "Create Note In Daily" },
			-- { "<leader>zN", "<Cmd>lua NewNoteWithCustomTemplate()<CR>", desc = "New Note With Custom Template" },
			-- { "<leader>zr", "<Cmd>lua find_recent_note()<CR>", desc = "Open Recent Notes" },
			{ "<leader>zZ", "<cmd>ChatGPTRun french<cr>", desc = "AI - Syntax Correction FR", mode = { "n", "v" } },
			{
				"<leader>zL",
				"<cmd>ChatGPTRun markdownFormatter<cr>",
				desc = "AI - Format MD Note",
				mode = { "n", "v" },
			},
			{
				"<leader>zS",
				"<cmd>ChatGPTRun completeFromSkeleton<cr>",
				desc = "AI - Draft Post",
				mode = { "n", "v" },
			},
			{ "<leader>zC", "<Cmd>lua PdfToImage()<CR>", desc = "Convert PDF to Image" },
			{ "<leader>zL", "<cmd>DictionaryPickLang<CR>", desc = "Change LSP Lang" },
			{ "<leader>zU", "<cmd>DictionaryUpdate<CR>", desc = "Edit Dicts" },

			{ "<leader>zF", "<cmd>DictionaryUpdateLspLang fr<CR>", desc = "LspLang French" },
			{ "<leader>zE", "<cmd>DictionaryUpdateLspLang en<CR>", desc = "LspLang English" },
			{
				"<leader>zW",
				function()
					local input = vim.fn.input("Enter workspace name: ")
					if input ~= "" then
						vim.cmd("ObsidianWorkspace " .. input)
					end
				end,
				desc = "Workspace Switch",
			},

			{
				"<leader>zx",
				function()
					return require("obsidian").util.toggle_checkbox()
				end,
				desc = "Toggle Checkbox",
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				markdown = { "markdownlint" },
			},
		},
		config = function()
			local markdownlint_config_path = vim.fn.stdpath("config") .. "\\extconfigs\\markdownlint.jsonc"
			require("lint").linters.markdownlint = {
				cmd = "markdownlint",
				stdin = false,
				args = { "--config", markdownlint_config_path, "%filepath" },
			}
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				marksman = {},
			},
		},
		-- TODO :make it use conf without breaking lsp
		-- config = function()
		--   local marksman_config_path = vim.fn.stdpath("config") .. "\\extconfigs\\marksman.toml"
		--   print("Marksman config path: " .. marksman_config_path) -- Debug print
		--   require("lspconfig").marksman.setup({})
		-- end,
	},

	-- { "mrjones2014/smart-splits.nvim" }, --TODO
}
