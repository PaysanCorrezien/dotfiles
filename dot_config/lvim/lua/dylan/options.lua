-- vim options vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
-- vim options
-- general
lvim.log.level = "info"
-- lvim.format_on_save = {
-- 	enabled = true,
-- 	pattern = "*.lua",
-- 	timeout = 1000,
-- }
-- to disable icons and use a minimalist setup, uncomment the following
vim.opt.colorcolumn = "99999"
vim.opt.relativenumber = true
vim.opt.mouse = "a" -- allow the mouse to be used in Neovim
vim.opt.termguicolors = true 
-- highlight
-- lvim.lsp.document_highlight = false
--
vim.opt.cursorline = false -- highlight the current line
--Configuration du spelling z=
vim.opt.spell = true
-- BUG: enforcing install ok each launch ??
-- vim.opt.spelllang = { "fr" , "en" }
vim.opt.spellsuggest = {'double', 9}
-- vim.opt.spellfile = "/home/dylan/.config/lvim/dict/spell.utf-8.add"
-- vim.opt.spellfile = "~/.local/share/chezmoi/dot_config/lvim/dict/spell.utf-8.add"
-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
-- vim.opt.showmode = true
vim.opt.clipboard = ""
vim.opt.updatetime = 70 -- faster completion
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true
lvim.leader = "space"

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

lvim.builtin.luasnip.sources.friendly_snippets = true

-- TO move by buffer number
lvim.builtin.bufferline.options.numbers = "ordinal"

lvim.builtin.treesitter.highlight.enable = true
-- Enble cmp completion for command line
lvim.builtin.cmp.cmdline.enable = true
-- lvim.builtin.cmp.crates.enable = true

-- vim.env.NVIM_LOG_FILE = vim.fn.stdpath('data') .. '/log'
-- vim.opt.verbose = 1
-- lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"
-- table.insert(lvim.builtin.cmp.sources,1,{ name = "copilot" })
