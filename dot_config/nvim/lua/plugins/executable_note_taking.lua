local os_utils = require("utils.os_utils")

-- TODO: find a way to make this automatic with a single array and automatic conversion with a function
local home = os.getenv("HOME") or "~"
-- Define OS-specific paths for both the vault and attachments
-- Settings with paths
obsidiannvim_settings = {
	vault_paths = {
		-- Windows = "C:/Users/dylan/Documents/KnowledgeBase/",
		Windows = "~/Documents/KnowledgeBase",
		Linux = "/mnt/c/users/dylan/Documents/KnowledgeBase/",
	},
	attachments_paths = {
		Windows = "C:\\Users\\dylan\\Documents\\KnowledgeBase\\static\\img\\",
		Linux = "/mnt/c/users/dylan/Documents/KnowledgeBase/static/img/",
	},
	pdftoppm_paths = {
		Windows = "C:\\Users\\dylan\\scoop\\shims\\pdftoppm.exe",
		Linux = "/usr/bin/pdftoppm",
	},
	templates_paths = {
		Windows = "C:\\Users\\dylan\\Documents\\KnowledgeBase\\Projets\\Templates\\",
		Linux = "/mnt/c/users/dylan/Documents/KnowledgeBase/Projets/Templates/",
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
	Windows = "C:\\Users\\dylan\\Documents\\Projet\\Work\\Projet\\pdf.nvim",
	Linux = "/mnt/c/users/dylan/Documents/Projet/Work/Projet/pdf.nvim/",
}

local pdf_plugin_path = os_utils.get_setting(pdf_paths)

local dictionary_path = {
	Windows = "C:\\Users\\dylan\\Documents\\Projet\\Work\\Projet\\dictionary.nvim",
	Linux = "/mnt/c/users/dylan/Documents/Projet/Work/Projet/dictionary.nvim/",
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
	-- {
	--BUG: find where cmp is broken and fix it
	--   "barreiroleo/ltex_extra.nvim",
	--   -- TODO: remove when PR merged
	--   commit = "6d00bf2fbd6fcecafd052c0e0f768b67ceb3307f",
	--   ft = { "markdown", "tex" },
	--   dependencies = { "neovim/nvim-lspconfig" },
	--   -- yes, you can use the opts field, just I'm showing the setup explicitly
	--   config = function()
	--     require("ltex_extra").setup({
	--       -- your_ltex_extra_opts,
	--       -- table <string> : languages for witch dictionaries will be loaded, e.g. { "es-AR", "en-US" }
	--       -- https://valentjn.github.io/ltex/supported-languages.html#natural-languages
	--       load_langs = { "fr" }, -- en-US as default
	--       -- boolean : whether to load dictionaries on startup
	--       init_check = true,
	--       -- string : relative or absolute paths to store dictionaries
	--       -- e.g. subfolder in current working directory: ".ltex"
	--       -- e.g. shared files for all projects :  vim.fn.expand("~") .. "/.local/share/ltex"
	--       -- path = "~/.config/lvim/dict", -- current working directory
	--       path = ltex_extra_cwd,
	--       -- cant work because \\\\ are poorly interpreted
	--       -- path = "\\\\wsl.localhost\\Debian\\home\\dylan\\.config\\lvim\\dict",
	--       -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
	--       log_level = "none",
	--       -- table : configurations of the ltex language server.
	--       -- Only if you are calling the server from ltex_extra
	--       server_opts = {
	--         -- capabilities = your_capabilities,
	--         on_attach = function(client, bufnr)
	--           -- your on_attach process
	--         end,
	--         settings = {
	--           ltex = {
	--             -- cmd = { "/home/dylan/.local/share/nvim/lsp_servers/ltex/ltex-ls/bin/ltex-ls" },
	--             language = "fr",
	--             diagnosticSeverity = "information",
	--             setenceCacheSize = 2000,
	--             additionalRules = {
	--               enablePickyRules = true,
	--               motherTongue = "fr",
	--             },
	--             -- trace = { server = "verbose" },
	--             -- dictionary = "~/.config/lvim/dict/", -- added global dictionary path
	--             completionEnabled = "true",
	--             checkfrenquency = "edit",
	--             statusBarItem = "true",
	--             disabledRules = {},
	--             -- hiddenFalsePositives = {},
	--           },
	--         },
	--       },
	--     })
	--   end,
	-- },
	-- {
	--   -- dir = dictionary_plugin_path, -- DEV : use local path
	--   "paysancorrezien/dictionary.nvim", -- PROD : use remote path
	--   ft = "markdown",
	--   dependencies = {
	--     "nvim-lua/plenary.nvim",
	--   },
	--   config = function()
	--     require("dictionary").setup({
	--       dictionary_paths = {
	--         -- home .. "/.local/share/chezmoi/dot_config/lvim/dict/ltex.dictionary.fr.txt",
	--         -- home .. "/.local/share/chezmoi/dot_config/lvim/dict/spell.utf-8.add",
	--         -- home .. "/.config/lvim/dict/ltex.dictionary.fr.txt",
	--         -- home .. "/.config/lvim/dict/spell.utf-8.add",
	--         remote_ltex_ls,
	--         remote_spell,
	--         local_ltex_ls,
	--         local_spell,
	--       },
	--       override_zg = true,
	--       ltex_dictionary = true, -- if you are use ltex-ls extra and want to use zg to also update ltex-ls dictionary
	--       cmp = {
	--         enabled = true,
	--         custom_dict_path = local_ltex_ls,
	--         max_spell_suggestions = 10,
	--         filetypes = { "markdown", "tex" },
	--         priority = 20000,
	--         name = "mydictionary",
	--         source_label = "[Dict]",
	--         -- kind_icon = cmp.lsp.CompletionItemKind.Event, -- Icon for suggestions
	--         -- kind_icon = " "
	--       },
	--     })
	--   end,
	-- },
	-- {
	--   -- dir = pdf_plugin_path, -- DEV : use local path
	--   "paysancorrezien/pdf.nvim", -- PROD : use remote path
	--   ft = "markdown",
	--   dependencies = {
	--     "nvim-lua/plenary.nvim",
	--   },
	--   config = function()
	--     require("pdf").setup({
	--       -- Your configuration here
	--       -- pdf_path = "/mnt/c/Users/dylan/Documents/Obsidian Vault/Zettelkasten/Files",
	--       -- image_path = "/mnt/c/Users/dylan/Documents/Obsidian Vault/Zettelkasten/Files",
	--       pdf_path = obsidian_attachments_path,
	--       image_path = obsidian_attachments_path,
	--       pdftoppm_path = pdftoppm__path,
	--       new_link_format = function(prefix, text, generated_image_file)
	--         return prefix .. "[" .. text .. "](/img/" .. generated_image_file .. ")"
	--       end,
	--     })
	--   end,
	-- },
	-- {
	--   "epwalsh/obsidian.nvim",
	--   lazy = false,
	--   -- event = { "BufReadPre /home/dylan/Documents/Vault/**.md" },
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
	--   -- event = { "BufReadPre " .. obsidian_vault_path .. "/**.md" },
	--   dependencies = {
	--     -- Required.
	--     "nvim-lua/plenary.nvim",
	--
	--     -- Optional, for completion.
	--     "hrsh7th/nvim-cmp",
	--
	--     -- Optional, for search and quick-switch functionality.
	--     "nvim-telescope/telescope.nvim",
	--
	--     -- Optional, alternative to nvim-treesitter for syntax highlighting.
	--     -- "godlygeek/tabular",
	--     -- "preservim/vim-markdown",
	--   },
	--   opts = {
	--     -- dir = "~/Documents/KnowledgeBase",
	--     dir = obsidian_vault_path, -- no need to call 'vim.fn.expand' here
	--
	--     -- Optional, if you keep notes in a specific subdirectory of your vault.
	--     notes_subdir = "Docs/KnowledgeBase",
	--
	--     -- Optional, if you keep daily notes in a separate directory.
	--     daily_notes = {
	--       folder = "Tasks",
	--     },
	--
	--     -- Optional, completion.
	--     completion = {
	--       nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
	--     },
	--     attachments = {
	--       -- The default folder to place images in via `:ObsidianPasteImg`.
	--       -- If this is a relative path it will be interpreted as relative to the vault root.
	--       -- You can always override this per image by passing a full path to the command instead of just a filename.
	--       img_folder = obsidian_attachments_path, -- This is the default
	--       -- A function that determines the text to insert in the note when pasting an image.
	--       -- It takes two arguments, the `obsidian.Client` and a plenary `Path` to the image file.
	--       -- This is the default implementation.
	--       ---@param client obsidian.Client
	--       ---@param path Path the absolute path to the image file
	--       ---@return string
	--       img_text_func = function(client, path)
	--         local link_path
	--         local vault_relative_path = client:vault_relative_path(path)
	--         if vault_relative_path ~= nil then
	--           -- Use the modified path if the image is saved in the vault dir.
	--           -- Strip off unwanted parts of the path and keep only '/img/' and the file name
	--           link_path = string.match(vault_relative_path, "/img/.+$")
	--         else
	--           -- For absolute paths, extract only the '/img/' part and the file name.
	--           link_path = string.match(tostring(path), "/img/.+$")
	--         end
	--         if not link_path then
	--           -- Fallback in case the desired pattern is not found
	--           link_path = tostring(path)
	--         end
	--         local display_name = vim.fs.basename(link_path)
	--         return string.format("![%s](%s)", display_name, link_path)
	--       end,
	--     },
	--     -- Optional, customize how names/IDs for new notes are created.
	--     note_id_func = function(title)
	--       -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
	--       -- In this case a note with the title 'My new note' will given an ID that looks
	--       -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
	--       local suffix = ""
	--       if title ~= nil then
	--         -- If title is given, transform it into valid file name.
	--         suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
	--       else
	--         -- If title is nil, just add 4 random uppercase letters to the suffix.
	--         for _ = 1, 4 do
	--           suffix = suffix .. string.char(math.random(65, 90))
	--         end
	--       end
	--       return tostring(os.time()) .. "-" .. suffix
	--     end,
	--
	--     templates = {
	--       subdir = "Projets/Templates",
	--       -- date_format = "%Y-%m-%d-%a",
	--       -- time_format = "%H:%M",
	--     },
	--     -- use_advanced_uri = true,
	--     finder = "telescope.nvim",
	--   },
	--   config = function(_, opts)
	--     require("obsidian").setup(opts)
	--
	--     -- Optional, override the 'gf' keymap to utilize Obsidian's search functionality.
	--     -- see also: 'follow_url_func' config option above.
	--     vim.keymap.set("n", "gf", function()
	--       if require("obsidian").util.cursor_on_markdown_link() then
	--         return "<cmd>ObsidianFollowLink<CR>"
	--       else
	--         return "gf"
	--       end
	--     end, { noremap = false, expr = true })
	--   end,
	-- },
	{
		"renerocksai/telekasten.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telekasten").setup({
				home = obsidian_vault_path,
			})
		end,
		keys = {
			{ "z", name = "+goto" },
			{ "<leader>zf", ":lua require('telekasten').find_notes()<CR>", desc = "Find Notes" },
			-- { "<leader>zP", ":lua PushNotes()<CR>", desc = "Push Notes" },
			{ "<leader>zg", ":lua require('telekasten').search_notes()<CR>", desc = "Search W under cursor in notes" },
			{ "<leader>zz", ":lua require('telekasten').follow_link()<CR>", desc = "Follow Link" },
			-- { "<leader>zT", ":lua require('telekasten').goto_today()<CR>", desc = "Open Daily" },
			{ "<leader>zy", ":lua require('telekasten').yank_notelink()<CR>", desc = "Yank Notelink" },
			-- { "<leader>zi", ":lua require('telekasten').paste_img_and_link()<CR>", desc = "Paste Img and Link" },
			{ "<leader>zb", ":lua require('telekasten').show_backlinks()<CR>", desc = "Show Backlinks" },
			{ "<leader>zI", "<cmd>ObsidianPasteImg<CR>", desc = "Insert IMG" },
			{ "<leader>zR", "<cmd>ObsidianRename<CR>", desc = "Rename" },
			{ "<leader>zx", "<cmd>:lua require('telekasten').toggle_todo()<CR>", desc = "Toggle Todo" },
			{ "<leader>zn", "<Cmd>lua CreateNote()<CR>", desc = "Create Note In Daily" },
			{ "<leader>zN", "<Cmd>lua NewNoteWithCustomTemplate()<CR>", desc = "New Note With Custom Template" },
			{ "<leader>zr", "<Cmd>lua find_recent_note()<CR>", desc = "Open Recent Notes" },
			{ "<leader>zF", "<cmd>ChatGPTRun french<cr>", desc = "AI - Syntax Correction FR" },
			{ "<leader>zL", "<cmd>ChatGPTRun markdownFormatter<cr>", desc = "AI - Format MD Note" },
			{ "<leader>zS", "<cmd>ChatGPTRun completeFromSkeleton<cr>", desc = "AI - Draft Post" },
			{ "<leader>zC", "<Cmd>lua PdfToImage()<CR>", desc = "Convert PDF to Image" },
		},
	},
}
