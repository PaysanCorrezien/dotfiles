-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local os_utils = require("utils.os_utils")
local home = os.getenv("HOME") or "~"
-- TODO: python not setup properly with this
vim.g.python3_host_prog = home .. "/.pyenv/versions/3.10.4/bin/python"
local dictionaries_files_path = {
	remote_ltex_ls = {
		Windows = "L:\\home\\dylan\\.local\\share\\chezmoi\\dot_config\\lvim\\dict\\ltex.dictionary.fr.txt",
		WSL = home .. "/.local/share/chezmoi/dot_config/lvim/dict/ltex.dictionary.fr.txt",
		Linux = home .. "/.local/share/chezmoi/dot_config/lvim/dict/ltex.dictionary.fr.txt",
	},
	remote_spell = {
		Windows = "L:\\home\\dylan\\.local\\share\\chezmoi\\dot_config\\lvim\\dict\\spell.utf-8.add",
		WSL = home .. "/.local/share/chezmoi/dot_config/lvim/dict/spell.utf-8.add",
		Linux = home .. "/.local/share/chezmoi/dot_config/lvim/dict/spell.utf-8.add",
	},
	chezmoi = {
		Windows = "L:\\home\\dylan\\.local\\share\\chezmoi\\dot_config\\lvim\\executable_config.lua",
		WSL = home .. "/.local/share/chezmoi/dot_config/lvim/executable_config.lua",
		Linux = home .. "/.local/share/chezmoi/dot_config/lvim/executable_config.lua",
	},
	ltex_ls_folder = {
		Windows = "\\wsl.localhost\\Debian\\home\\dylan\\.local\\share\\chezmoi\\dot_config\\lvim\\dict\\",
		WSL = home .. "/.local/share/chezmoi/dot_config/lvim/dict/",
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
-- if current_os == "Windows" then
-- 	-- Retrieve the Windows username dynamically
--
-- 	local windows_username = os_utils.get_windows_username()
-- 	-- Set the sqlite_clib_path with dynamic username
-- 	local sqlite_clib_path = "C:/Users/" .. windows_username .. "/AppData/Roaming/sqlite-dll/sqlite3.dll"
-- 	vim.api.nvim_set_var("sqlite_clib_path", sqlite_clib_path)
-- 	-- Set shell to PowerShell and the command flag
-- 	-- vim.opt.shell = "pwsh.exe"
-- 	-- vim.opt.shellcmdflag = "-nologo -noprofile -ExecutionPolicy RemoteSigned -command Invoke-PlainCommand"
-- 	-- vim.opt.shellcmdflag = "-nologo -noprofile"
-- 	-- -- vim.opt.shellcmdflag =
-- 	-- -- 	[[-nologo -noprofile -ExecutionPolicy RemoteSigned -command "& {param([string]$Command) $output = & pwsh -Command $Command; $output -replace '\\e\\[\\d+;?\\d*m', ''}"]]
-- 	-- vim.opt.shellxquote = ""
--
-- 	-- local powershell_options = {
-- 	-- 	shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
-- 	-- 	shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
-- 	-- 	shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
-- 	-- 	shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
-- 	-- 	shellquote = "",
-- 	-- 	shellxquote = "",
-- 	-- }
-- 	--
-- 	-- for option, value in pairs(powershell_options) do
-- 	-- 	vim.opt[option] = value
-- 	-- end
-- 	vim.opt.runtimepath:append("L:\\home\\dylan\\.local\\share\\chezmoi\\dot_config\\lvim\\dict\\")
-- 	vim.g.python3_host_prog = "C:\\python312\\python.exe"
-- else
--NOTE: on nix i set a env variable to the path of the sqlite3.so
-- Check if SQL_CLIB_PATH environment variable is set
local sql_clib_path = vim.env.SQL_CLIB_PATH
if sql_clib_path and sql_clib_path ~= "" then
	-- vim.g.sql_clib_path = sql_clib_path
	-- Add this line to set the variable for the sqlite.lua plugin
	vim.g.sqlite_clib_path = sql_clib_path
	print("SQL_CLIB_PATH set to: " .. vim.g.sqlite_clib_path)
else
	print("Warning: SQL_CLIB_PATH is not set.")
end
-- end

vim.log.level = "warn"
vim.opt.clipboard = ""
-- vim.opt.updatetime = 70 -- faster completion
--
vim.opt.spellfile = remote_spell
vim.opt.spell = true
vim.opt.spelllang = { "en", "fr" }
vim.opt.spellsuggest = { "double", 9 }

vim.opt.cursorline = false -- highlight the current line
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
