-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local os_utils = require("utils.os_utils")
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
vim.g.my_ltexfile_path = remote_ltex_ls
vim.g.my_spellfile_path = remote_spell
vim.g.my_chezmoi_config_path = chezmoi
vim.opt.spellfile = remote_spell
local current_os = os_utils.get_os()
-- Check if the current OS is Windows
if current_os == "Windows" then
	-- Retrieve the Windows username dynamically
	local windows_username = os_utils.get_windows_username()
	-- Set the sqlite_clib_path with dynamic username
	local sqlite_clib_path = "C:/Users/" .. windows_username .. "/AppData/Roaming/sqlite-dll/sqlite3.dll"
	vim.api.nvim_set_var("sqlite_clib_path", sqlite_clib_path)
	-- Set shell to PowerShell and the command flag
	vim.opt.shell = "pwsh.exe"
	vim.opt.shellcmdflag = "-c"
	vim.opt.runtimepath:append("L:\\home\\dylan\\.local\\share\\chezmoi\\dot_config\\lvim\\dict\\")
end

vim.log.level = "warn"
vim.opt.clipboard = ""
-- vim.opt.updatetime = 70 -- faster completion
--
vim.opt.spellfile = remote_spell
--BUG: Fix this for en ?
vim.opt.spell = true
vim.opt.spelllang = { "fr" }
vim.opt.spelllang = { "fr" }
vim.opt.spellsuggest = { "double", 9 }

vim.opt.cursorline = false -- highlight the current line
