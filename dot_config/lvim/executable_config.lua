-- Attempt setting runtimepath before plug launch WORK
local os_utils = require("os_utils")
-- NOTE: runtime path of spellfile need to be set before option set spell: or it will install on each start of neovim
-- Get the home directory path
local home = os.getenv("HOME") or "~"
-- Define the paths directly using the home directory path
vim.g.my_ltexfile_path = home .. "/.local/share/chezmoi/dot_config/lvim/dict/ltex.dictionary.fr.txt"
vim.g.my_spellfile_path = home .. "/.local/share/chezmoi/dot_config/lvim/dict/spell.utf-8.add"
vim.g.my_chezmoi_config_path = home .. "/.local/share/chezmoi/dot_config/lvim/executable_config.lua"
-- 10:58:39 AM msg_show Warning: Cannot find word list "fr.utf-8.spl" or "fr.ascii.spl"
--TODO: prevent hardcode somehow ? install pynvim before lvim ?
vim.g.python3_host_prog = home .. "/.pyenv/versions/3.10.4/bin/python"

-- SQL LITE for neocomposer on windows
-- Before setting
-- print("OS uname: " .. vim.inspect(vim.loop.os_uname()))
-- print("Detected OS: " .. os_utils.get_os())
if os_utils.get_os() == "Windows" then
	vim.api.nvim_set_var("sqlite_clib_path", "C:/Users/dylan/AppData/Roaming/sqlite-dll/sqlite3.dll")
	vim.opt.shell = "pwsh.exe"
	vim.opt.shellcmdflag = "-c"
end

if os_utils.get_os() == "Linux" then
	vim.cmd([[
augroup TmuxRenaming
    autocmd!
    autocmd BufEnter * lua _G.rename_tmux_pane()
    autocmd BufLeave * lua _G.reset_tmux_pane()
augroup END
]])
end

-- use the file defined before as spellfile
-- vim.opt.spellfile = vim.g.my_spellfile_path
vim.opt.runtimepath:prepend(home .. "/.local/share/chezmoi/dot_config/lvim/dict")
-- Get the home directory path
-- Set the spellfile option to the path of your .add file
vim.opt.spellfile = home .. "/.local/share/chezmoi/dot_config/lvim/dict/spell.utf-8.add"
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
require("dylan/spell")
require("dylan/rust")
require("dylan/autocommands")
require("dylan/lualine")
require("dylan/gitsigns")
require("dylan/treesitter")
-- require("dylan/python")
-- usefull functions
require("utils")
-- require("DictionnaryManager")
-- require("DictionnaryCmp")
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
