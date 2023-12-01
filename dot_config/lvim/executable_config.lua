-- Attempt setting runtimepath before plug launch WORK
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
-- ['codeium'] = true,  -- Uncomment if you want this module
-- vim.opt.spellfile = "/home/dylan/.local/share/chezmoi/dot_config/lvim/dict/spell.utf-8.add"
-- usefull functions
require("utils")
--  function inside utiles chack only load certain modules on linux to not use some on work computer
-- TODO: Remplacer par bon path

--
-- Test Tmux rename auto
vim.o.title = true
vim.o.titlestring = "%t"

--
lvim.colorscheme = "kanagawa"

-- autocmd ColorScheme * lua require('leap').init_highlight(true)

--
-- TODO : advance on this
-- require('ObsidianExtra').setup({
--   obsidiandir = "~/documents/obsidian vault/",
--   dictionnarfile = "~/.config/lvim/dict/fr.txt",
--   spellcheckfile = "~/.config/lvim/spell/fr.utf-8.spl",
--   treesitter = true
-- })
local kind = require("dylan/kind") -- Icones perso

-- table.insert(lvim.builtin.cmp.sources, { name = "spell" })
-- lvim.builtin.cmp.formatting.source_names.spell = "(Spell)"
-- rename pane tmux working
vim.cmd([[
augroup TmuxRenaming
    autocmd!
    autocmd BufEnter * lua _G.rename_tmux_pane()
    autocmd BufLeave * lua _G.reset_tmux_pane()
augroup END
]])

-- TODO:
-- need to require here or it break
require("dylan/dashboard")
