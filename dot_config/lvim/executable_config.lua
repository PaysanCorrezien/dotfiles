-- reload("dylan/whichkey")
-- reload("dylan/options")
-- reload("dylan/keymap")
-- reload("dylan/plugins")
-- reload("dylan/lsp")
-- reload("dylan/linters")
-- reload("dylan/formatters")
-- reload("dylan/leap")
-- reload("dylan/telescope")
-- reload("dylan/neocomposer")
-- reload("dylan/lvim_config")
-- -- reload("dylan/harpoon")
-- reload("dylan/colorscheme")
-- reload("dylan/noice")
-- reload("dylan/telekasten")
-- require("dylan/dashboard")
-- reload("dylan/spell")
-- -- usefull functions
-- reload("utils")
-- -- require('codeium').setup();
-- HACK: 
-- Windows
local modules = {
	["dylan/whichkey"] = true,
	-- ["dylan/dashboard"] = true,
	["dylan/options"] = true,
	["dylan/keymap"] = true,
	["dylan/plugins"] = true,
	["dylan/lsp"] = true,
	["dylan/linters"] = true,
	["dylan/formatters"] = true,
	["dylan/leap"] = true,
	["dylan/telescope"] = true,
	["dylan/neocomposer"] = true,
	["dylan/lvim_config"] = true,
	-- ["dylan/harpoon"] = true,  -- Uncomment if you want this module
	["dylan/colorscheme"] = true,
	["dylan/noice"] = true,
	["dylan/telekasten"] = false, -- Don't load this on Windows
	["dylan/spell"] = true,
	["dylan/rust"] = true,
	-- ['codeium'] = true,  -- Uncomment if you want this module
}
-- vim.opt.spellfile = "/home/dylan/.local/share/chezmoi/dot_config/lvim/dict/spell.utf-8.add"
-- usefull functions
require("utils")
--  function inside utiles chack only load certain modules on linux to not use some on work computer
_G.load_modules(modules)
-- TODO: Remplacer par bon path
_G.CONFIG_PATH = (package.config:sub(1,1) == '\\') and "windows_config_path" or "/home/dylan/.config/"
-- Paths for different operating systems
local paths = {
    linux = {
        ltex = "/home/dylan/.local/share/chezmoi/dot_config/lvim/dict/ltex.dictionary.fr.txt",
        spell = "/home/dylan/.local/share/chezmoi/dot_config/lvim/dict/spell.utf-8.add",
        chezmoi_config = "/home/dylan/.local/share/chezmoi/dot_config/lvim/executable_config.lua"
    },
    windows = {
        ltex = "C:/Users/Username/AppData/Local/nvim/dict/ltex.dictionary.fr.txt",
        spell = "C:/Users/Username/AppData/Local/nvim/dict/spell.utf-8.add",
        chezmoi_config = "C:/Users/Username/AppData/Local/nvim/dict/executable_config.lua"
    },
}

-- Detect the operating system
local os = package.config:sub(1,1) == '\\' and 'windows' or 'linux'

-- Use the paths table to get the correct paths
vim.g.my_ltexfile_path = paths[os].ltex
vim.g.my_spellfile_path = paths[os].spell
vim.g.my_chezmoi_config_path = paths[os].chezmoi_config

-- use the file defined before as spellfile 
vim.opt.spellfile = vim.g.my_spellfile_path
--
-- Test Tmux rename auto
vim.o.title = true
vim.o.titlestring = "%t"

vim.api.nvim_command('autocmd BufEnter,BufRead,BufNewFile * echom "Setting title to: " . expand("%:t")')
-- For working with windows

--
lvim.colorscheme = "kanagawa"
-- vim.keymap.set("i", "<C-a>", function()
--   return vim.fn["codeium#Accept"]()
-- end, { expr = true })

-- vim.keymap.set("i", "<c-k>", function()
--   return vim.fn["codeium#CycleCompletions"](1)
-- end, { expr = true })

-- vim.keymap.set("i", "<c-j>", function()
--   return vim.fn["codeium#CycleCompletions"](-1)
-- end, { expr = true })

-- vim.keymap.set("i", "<c-x>", function()
--   return vim.fn["codeium#Clear"]()
-- end, { expr = true })

-- autocmd ColorScheme * lua require('leap').init_highlight(true)

-- setup must be called before loading
-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inlines, "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- - disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
-- 	return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
-- 	local function buf_set_option(...)
-- 		vim.api.nvim_buf_set_option(bufnr, ...)
-- 	end
-- 	--Enable completion triggered by <c-x><c-o>
-- 	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "stylua" },
--   -- {
--   --   command = "prettier",
--   --   extra_args = { "--print-width", "100" },
--   --   filetypes = { "typescript", "typescriptreact" },
--   -- },
-- }
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },

-- lvim.builtin.treesitter.ensure_installed = {
-- 	"bash",
-- 	"c",
-- 	"javascript",
-- 	"json",
-- 	"lua",
-- 	"python",
-- 	"css",
-- 	"rust",
-- 	"java",
-- 	"yaml",
-- }

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- generic LSP settings

--make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--   "jsonls",
--   "lua_ls",
-- }

--
-- vim.api.nvim_set_keymap('n', '<Leader>e', '<Cmd>lua exec_luafile()<CR>', { noremap = true, silent = true })

-- vim.api.nvim_set_keymap("n", "d", ":lua delete_change()<CR>", { noremap = true, silent = true })
-- function find_recent_files()
--   local opts = {
--     sorting_strategy = "ascending",
--     layout_strategy = "horizontal",
--     layout_config = {
--       preview_width = 0.65,
--     },
--     prompt_title = "~ Recent Files ~",
--     cwd = vim.fn.expand(directory),
--   }
--   require("telescope.builtin").find_files(opts)
-- end

--
-- require('ObsidianExtra').setup({
--   obsidiandir = "~/documents/obsidian vault/",
--   dictionnarfile = "~/.config/lvim/dict/fr.txt",
--   spellcheckfile = "~/.config/lvim/spell/fr.utf-8.spl",
--   treesitter = true
-- })
-- codeium setup
-- table.insert(lvim.builtin.cmp.sources, { name = "dictionnary" })
-- lvim.builtin.cmp.formatting.source_names.dictionnary = "(Dictionnary)"
local kind = require("dylan/kind") -- Icones perso

-- table.insert(lvim.builtin.cmp.sources, { name = "spell" })
-- lvim.builtin.cmp.formatting.source_names.spell = "(Spell)"
table.insert(lvim.builtin.cmp.sources, { name = "codeium" })
lvim.builtin.cmp.formatting.source_names.codeium = "(Codeium)"
local default_format = lvim.builtin.cmp.formatting.format
lvim.builtin.cmp.formatting.format = function(entry, vim_item)
	vim_item = default_format(entry, vim_item)
	if entry.source.name == "codeium" then
		vim_item.kind = ""
		vim_item.kind_hl_group = "CmpItemKindTabnine"
	end
	if entry.source.name == "spell" then
		vim_item.kind = kind.cmp_kind.TypeParameter
		vim_item.kind_hl_group = "CmpItemKindTabnine"
	end
	-- if entry.source.name == "Dictionnary" then
	--   vim_item.kind = kind.icons.repo
	--   vim_item.kind_hl_group = "CmpItemKindTabnine"
	-- end
	return vim_item
end

-- TODO:
-- Find a way to write this in lua directly 
-- au nvim_ghost_user_autocommands User *github.com setfiletype markdown
vim.api.nvim_exec([[
augroup nvim_ghost_user_autocommands
  au!
  au User *.com setfiletype markdown | lua vim.cmd('LspStart')
  au User *.fr setfiletype markdown | lua vim.cmd('LspStart')
augroup END
]], false)


-- TODO: 
-- need to require here or it break 
require("dylan/dashboard") 
