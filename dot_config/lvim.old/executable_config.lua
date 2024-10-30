-- Attempt setting runtimepath before plug launch WORK
local os_utils = require("os_utils")
-- NOTE: runtime path of spellfile need to be set before option set spell: or it will install on each start of neovim
-- Get the home directory path
-- 10:58:39 AM msg_show Warning: Cannot find word list "fr.utf-8.spl" or "fr.ascii.spl"
--TODO: prevent hardcode somehow ? install pynvim before lvim ?
local home = os.getenv("HOME") or "~"
vim.g.python3_host_prog = home .. "/.pyenv/versions/3.10.4/bin/python"
local dictionaries_files_path = {
	remote_ltex_ls = {
		Windows = "L:\\home\\dylan\\.local\\share\\chezmoi\\dot_config\\lvim\\dict\\ltex.dictionary.fr.txt",
		Linux = home .. "/.local/share/chezmoi/dot_config/lvim/dict/ltex.dictionary.fr.txt",
	},
	remote_spell = {
		Windows = "L:\\home\\dylan\\.local\\share\\chezmoi\\dot_config\\lvim\\dict\\spell.utf-8.add",
		Linux = home .. "/.local/share/chezmoi/dot_config/lvim/dict/spell.utf-8.add",
	},
	chezmoi = {
		Windows = "L:\\home\\dylan\\.local\\share\\chezmoi\\dot_config\\lvim\\executable_config.lua",
		Linux = home .. "/.local/share/chezmoi/dot_config/lvim/executable_config.lua",
	},
	ltex_ls_folder = {
		Windows = "\\wsl.localhost\\Debian\\home\\dylan\\.local\\share\\chezmoi\\dot_config\\lvim\\dict\\",
		Linux = home .. "/.local/share/chezmoi/dot_config/lvim/dict/",
	},
}

local remote_ltex_ls = os_utils.get_setting(dictionaries_files_path.remote_ltex_ls)
local remote_spell = os_utils.get_setting(dictionaries_files_path.remote_spell)
local chezmoi = os_utils.get_setting(dictionaries_files_path.chezmoi)
local ltex_ls_folder = os_utils.get_setting(dictionaries_files_path.ltex_ls_folder)
-- Define the paths directly using the home directory path
-- vim.g.my_ltexfile_path = home .. "/.local/share/chezmoi/dot_config/lvim/dict/ltex.dictionary.fr.txt"
-- vim.g.my_spellfile_path = home .. "/.local/share/chezmoi/dot_config/lvim/dict/spell.utf-8.add"
-- vim.g.my_chezmoi_config_path = home .. "/.local/share/chezmoi/dot_config/lvim/executable_config.lua"
vim.g.my_ltexfile_path = remote_ltex_ls
vim.g.my_spellfile_path = remote_spell
vim.g.my_chezmoi_config_path = chezmoi

-- Debug: Print the path to check
-- print("Runtimepath before: " .. vim.o.runtimepath)
-- -- vim.opt.runtimepath:append(ltex_ls_folder)
-- print("Runtimepath after: " .. vim.o.runtimepath)
-- Get the home directory path
-- Set the spellfile option to the path of your .add file
vim.opt.spellfile = remote_spell
-- SQL LITE for neocomposer on windows
-- Before setting
-- print("OS uname: " .. vim.inspect(vim.loop.os_uname()))
-- print("Detected OS: " .. os_utils.get_os())
local current_os = os_utils.get_os()
-- Check if the current OS is Windows
if current_os == "Windows" then
	-- Retrieve the Windows username dynamically
	local windows_username = os_utils.get_windows_username()
	-- Set the sqlite_clib_path with dynamic username
	local sqlite_lib_path = "C:/Users/" .. windows_username .. "/AppData/Roaming/sqlite-dll/sqlite3.dll"
	vim.api.nvim_set_var("sqlite_lib_path", sqlite_lib_path)
	-- Set shell to PowerShell and the command flag
	vim.opt.shell = "pwsh.exe"
	vim.opt.shellcmdflag = "-c"
	vim.opt.runtimepath:append("L:\\home\\dylan\\.local\\share\\chezmoi\\dot_config\\lvim\\dict\\")
end

-- if current_os == "Linux" then
-- 	vim.cmd([[
-- augroup TmuxRenaming
--     autocmd!
--     autocmd BufEnter * lua _G.rename_tmux_pane()
--     autocmd BufLeave * lua _G.reset_tmux_pane()
-- augroup END
-- ]])
-- end
require("dylan/whichkey")
require("dylan/options")
require("dylan/keymap")
require("dylan/plugins")
require("dylan/lsp")
require("dylan/linters")
require("dylan/formatters")
require("dylan/leap")
require("dylan/telescope")
require("dylan/neocomposer")
require("dylan/colorscheme")
require("dylan/noice")
require("dylan/telekasten")
-- require("dylan/spell")
require("dylan/rust")
require("dylan/autocommands")
require("dylan/lualine")
require("dylan/gitsigns")
require("dylan/treesitter")
-- require("dylan/python")
-- usefull functions
require("utils")
--  function inside utiles chack only load certain modules on linux to not use some on work computer
--
-- Test Tmux rename auto
vim.o.title = true
vim.o.titlestring = "%t"
--
lvim.colorscheme = "kanagawa"

-- autocmd ColorScheme * lua require('leap').init_highlight(true)

-- print("Before setting: " .. vim.inspect(vim.api.nvim_get_var('sqlite_clib_path')))

-- if os_utils.get_os() == "Windows" then
--     vim.api.nvim_set_var('sqlite_clib_path', "C:/Users/dylan/AppData/Roaming/sqlite-dll")
--     -- After setting
--     print("After setting: " .. vim.inspect(vim.api.nvim_get_var('sqlite_clib_path')))
-- end

-- table.insert(lvim.builtin.cmp.sources, { name = "spell" })
-- lvim.builtin.cmp.formatting.source_names.dictionary = "(Spell)"
--
-- table.insert(lvim.builtin.cmp.sources, { name = "spell" })
table.insert(lvim.builtin.cmp.sources, { name = "dictionary" })
lvim.builtin.cmp.formatting.source_names.dictionary = "(Dict)"
-- Set fuzzy matching options for nvim-cmp
lvim.builtin.cmp.matching = {
	disallow_fuzzy_matching = false,
	disallow_fullfuzzy_matching = false,
	disallow_partial_fuzzy_matching = false,
}

-- rename pane tmux working
-- TODO:
-- need to require here or it break
local kind = require("dylan/kind") -- Icones perso
require("dylan/dashboard")
