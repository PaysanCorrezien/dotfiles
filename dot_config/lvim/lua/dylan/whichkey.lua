lvim.builtin.which_key.opts.mode = { "n", "v", "R" }
lvim.builtin.which_key.mappings["S"] = { ":lua search_and_replace()<CR>", "Search and replace" }

--Harpoon
lvim.builtin.which_key.mappings["A"] = { "<cmd>:lua require('harpoon.mark').add_file()<cr>", "Harp Add" }
lvim.builtin.which_key.mappings["H"] = { "<cmd>:Telescope harpoon marks<cr>", "List Harp Mark" }

lvim.builtin.which_key.mappings["j"] = { "<cmd>Telescope jumplist<cr>", "Jumplist" }
lvim.builtin.which_key.mappings["X"] = { ":lua RunPowershellCommand()<cr>", "Run PowerShell Command" }
lvim.builtin.which_key.mappings["W"] = { ":lua SudoSave()<cr>", "Save with Sudo" }
lvim.builtin.which_key.mappings["M"] = { ":lua SaveWindowsCreds()<cr>", "Save with Windows Credentials" }
lvim.builtin.which_key.mappings["R"] = { ":lua reload_config()<cr>", "Reload Conf" }
-- override a default keymapping
--

lvim.builtin.which_key.mappings["x"] = {
	name = "Dylan",
	-- j = { "<cmd>Telescope jumplist<cr>", "jumplist" },
	o = { "<cmd>Telescope vim_options<cr>", "vimoptions" },
	l = { "<cmd>Telescope loclist<cr>", "loclist" },
	m = { "<cmd>:Telescope macros<cr>", "Neo Macros" },
	e = { "<cmd><cr>", "Neo Macros Edit" },
	-- c = { "<cmd>Codeium Enable<cr>", "Codeium Enable" },
	-- d = { "<cmd>Codeium Disable<cr>", "Codeium Disable" },
	g = { "<cmd>ChatGPT<cr>", "GPT CHAT" },
	A = { "<cmd>ChatGPTActAs<cr>", "ChatGPTActAs" },
	t = { "<cmd>ChatGPTEditWithInstructions<cr>", "ChatGPTEditWithInstructions" },
	-- G = { "<cmd>ChatGPTRun grammar_correction<cr>", "ChatGPT Correct" }, --Only english
	-- F = { "<cmd>ChatGPTRun french<cr>", "ChatGPT Correct" }, --Only French
	C = { "<cmd>ChatGPTRun complete_code<cr>", "ChatGPT End Code" },
	P = { "<cmd>ChatGPTRun powershellDocs<cr>", "Generate Ps Docs" },
	S = { "<cmd>ChatGPTRun summarize<cr>", "ChatGPT summarize" },
	D = { "<cmd>ChatGPTRun docstrings<cr>", "ChatGPT Docs" },
	H = { "<cmd>Telescope command_history <cr>", "Command history" },
	-- O = { "<cmd>ChatGPTRun optimize_code<cr>", "ChatGPT Optimize" },
	-- BUG: same with dict ect make it work again
	-- X = {
	-- 	"<cmd>lua vim.lsp.buf.execute_command({command = '_ltex.addToDictionary', arguments = {vim.fn.expand('<cword>')}})<CR>",
	-- 	"addtodict",
	-- },
	-- J = {
	-- 	"<cmd>lua vim.lsp.buf.execute_command({command = '_ltex.hideFalsePositives', arguments = {vim.fn.expand('<cword>')}})<CR>",
	-- 	"hidefalsepositive",
	-- },
	-- R = {
	-- 	"<cmd>lua vim.lsp.buf.execute_command({command = '_ltex.disableRules', arguments = {vim.fn.expand('<cword>')}})<CR>",
	-- 	"disablerules",
	-- },

	X = {
		"<cmd>lua require('ltex_extra.commands-lsp').addToDictionary({ arguments = { { words = { ['fr'] = { vim.fn.expand('<cword>') } } } } })<CR>",
		"addtodict",
	},
}
--Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["1"] = { "<cmd>BufferLineGoToBuffer 1<cr>", "Go To Tab 1" }
lvim.builtin.which_key.mappings["2"] = { "<cmd>BufferLineGoToBuffer 2<cr>", "Go To Tab 2" }
lvim.builtin.which_key.mappings["3"] = { "<cmd>BufferLineGoToBuffer 3<cr>", "Go To Tab 3" }
lvim.builtin.which_key.mappings["4"] = { "<cmd>BufferLineGoToBuffer 4<cr>", "Go To Tab 4" }
lvim.builtin.which_key.mappings["5"] = { "<cmd>BufferLineGoToBuffer 5<cr>", "Go To Tab 5" }
lvim.builtin.which_key.mappings["6"] = { "<cmd>BufferLineGoToBuffer 6<cr>", "Go To Tab 6" }
lvim.builtin.which_key.mappings["7"] = { "<cmd>BufferLineGoToBuffer 7<cr>", "Go To Tab 7" }

-- TODO: symlink windows and wsl doc
-- BUG: crashing
lvim.builtin.which_key.mappings["8"] =
	{ "<cmd>:TodoTrouble cwd=/mnt/c/Users/dylan/Documents/Projet/Work/Projet/<cr>", "Todo on All Project" }
-- lvim.builtin.which_key.mappings["8"] = { "<cmd>require ('telescope').extensions.file_browser.file_browser(path=%:p:h select_buffer=true)<cr>", "Telescope explorer" }
-- lvim.builtin.which_key.mappings["E"] = { "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", "Telescope explorer" }
lvim.builtin.which_key.mappings["E"] = { "<cmd>NnnPicker<cr>", "NNN File Browser" }
lvim.builtin.which_key.mappings["I"] = { "<cmd>IconPickerInsert<cr>", "Icon Picker" } -- ctrl e in insert mode do the same

lvim.builtin.which_key.vmappings["y"] = { '"+y', "Copy Y" }
lvim.builtin.which_key.mappings["Y"] = { "<cmd>Telescope neoclip<cr>", "ClipBoard" }
-- lvim.builtin.which_key.mappings["y"] = { '[["+y]]', "Copy To ClipBoard" }

lvim.builtin.which_key.mappings["sm"] = { "<cmd>Telescope marks<CR>", "marks" }
lvim.builtin.which_key.mappings["Ln"] = { "<cmd>Noice<CR>", "Noice Alerts" }
-- Note: useless with tmux
lvim.builtin.which_key.mappings["LC"] =
	{ "<cmd>Telescope fd cwd=~/.local/share/chezmoi/dot_config/lvim<CR>", "Config Folder" }
lvim.builtin.which_key.mappings["Lc"] =
	{ "<cmd>edit ~/.local/share/chezmoi/dot_config/lvim/executable_config.lua<cr>", "config.lua" }
lvim.builtin.which_key.mappings["LD"] =
	{ "<cmd>Telescope file_browser cwd=~/.local/share/chezmoi/dot_config/lvim<cr>", ".config/" }
lvim.builtin.which_key.mappings["Lx"] = { "<cmd>Telescope file_browser cwd=~/.local/share/chezmoi/<CR>", "Dotfiles" }

-- GIT part
lvim.builtin.which_key.mappings["G"] = { "<cmd>Git<CR>", "Git" }
-- BUG: GPG commit dont work inside nvim
lvim.builtin.which_key.mappings["gv"] = { "<cmd>!git commit <CR>", "Git commit" }
lvim.builtin.which_key.mappings["ga"] = { "<cmd>Git add .<CR>", "Git Add ALL" }
lvim.builtin.which_key.mappings["gL"] = { "<cmd>Gitsigns setloclist<CR>", "Git LocList" }
lvim.builtin.which_key.mappings["gg"] = {}

lvim.builtin.which_key.mappings["t"] = {
	name = "+Trouble",
	r = { "<cmd>Trouble lsp_references<cr>", "References" },
	f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
	d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
	q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
	l = { "<cmd>Trouble loclist<cr>", "LocationList" },
	w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

-- lvim.builtin.which_key.mappings['w'] = {  "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({skip_empty_lines=true})<CR>", "FuzzyFindCurrentFile" }
lvim.builtin.which_key.mappings["w"] = {
	"<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({skip_empty_lines=true})<CR>",
	"FuzzyFindCurrentFile",
}
lvim.builtin.which_key.mappings["u"] = {
	"<cmd>lua require('telescope').extensions.undo.undo()<CR>",
	"Undotree",
}
-- Reactive registre infos
lvim.builtin.which_key.setup.plugins.registers = true
lvim.builtin.which_key.setup.plugins.marks = true
lvim.builtin.which_key.setup.plugins.spelling = true
lvim.builtin.which_key.setup.plugins.presets = true

lvim.builtin.which_key.mappings["z"] = {
	name = "+Telekasten",
	f = { ":lua require('telekasten').find_notes()<CR>", "Find Notes" },
	P = { ":lua PushNotes()<CR>", "Push Notes" }, --
	-- Z = { "lua require('telekasten').panel()<CR>", "Telekasten Panel" },
	-- d = { ":lua require('telekasten').find_daily_notes()<CR>", ".find_daily_notes" },
	g = { ":lua require('telekasten').search_notes()<CR>", "Search W under cursor in notes" },
	z = { ":lua require('telekasten').follow_link()<CR>", "Follow Link" },
	T = { ":lua require('telekasten').goto_today()<CR>", "Open Daily" },
	-- W = { ":lua require('telekasten').goto_thisweek()<CR>",".goto_thisweek"},
	-- w = { ":lua require('telekasten').find_weekly_notes()<CR>",".find_weekly_notes"},
	-- n = { ":lua require('telekasten').new_note()<CR>",".new_note"},
	-- N = { ":lua require('telekasten').new_templated_note()<CR>",".new_templated_note"},
	y = { ":lua require('telekasten').yank_notelink()<CR>", "Yank Notelink" },
	i = { ":lua require('telekasten').paste_img_and_link()<CR>", "Paste_img_and_link" },
	-- t = { ":lua require('telekasten').toggle_todo()<CR>",".toggle_todo"},
	b = { ":lua require('telekasten').show_backlinks()<CR>", "Show_backlinks" },
	-- F = { ":lua require('telekasten').find_friends()<CR>",".find_friends"},
	I = { ":lua require('telekasten').insert_img_link({ i=true })<CR>", "Insert IMG" },
	p = { ":lua require('telekasten').preview_img()<CR>", ".preview_img" },
	m = { ":lua require('telekasten').browse_media()<CR>", ".browse_media" },
	a = { ":lua require('telekasten').show_tags()<CR>", ".show_tags" },
	R = { ":lua require('telekasten').rename_note()<CR>", "Rename" },
	x = { "<cmd>:lua require('telekasten').toggle_todo()<CR>", "toggle_todo" },
	n = { "<Cmd>lua CreateNote()<CR>", "CreateNoteInDaily" },
	-- t = { "<Cmd>lua CreateDailyTask()<CR>", "CreateTask" },
	N = { "<Cmd>lua NewNoteWithCustomTemplate()<CR>", "NewNoteWithCustomTemplate" },
	r = { "<Cmd>lua find_recent_note()<CR>", "OpenRecentNotes" },
	-- TODO:
	F = { "<cmd>ChatGPTRun french<cr>", "Syntaxe Correction FR" },
	L = { "<cmd>ChatGPTRun markdownFormatter<cr>", "Format MD note" },
	S = { "<cmd>ChatGPTRun completeFromSkeleton<cr>", "Draft Poste" },
	C = { "<Cmd>lua PdfToImage()<CR>", "Convert Pdf to image" },
	B = { "<Cmd>lua find_recent_note()<CR>", "Send to Blog" },
}

-- Python
lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>", "Test Method" }
lvim.builtin.which_key.mappings["dM"] =
	{ "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Test Method DAP" }
lvim.builtin.which_key.mappings["df"] = {
	"<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>",
	"Test Class",
}
lvim.builtin.which_key.mappings["dF"] = {
	"<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
	"Test Class DAP",
}
lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" }

-- binding for switching
lvim.builtin.which_key.mappings["xE"] = {
	name = "Python",
	c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose python Env" },
}
-- END python

-- rg arguments sortr modified
-- TODO: faire fonctionner pour eviter d'avoir un script custom
-- local opts = require('telescope.pickers').new({}, {'vimgrep_arguments'=='rg','--no-heading','with-filename','--vimgrep'})
-- lvim.builtin.which_key.mappings["9"] = { "<cmd>lua require('telescope.builtin').find_files(opts)<cr>", "Custom Finder" }
