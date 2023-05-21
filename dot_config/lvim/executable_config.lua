reload("dylan/whichkey")
reload("dylan/options")
reload("dylan/keymap")
reload("dylan/plugins")
reload("dylan/lsp")
reload("dylan/linters")
reload("dylan/formatters")
reload("dylan/leap")
reload("dylan/telescope")
reload("dylan/neocomposer")
reload("dylan/lvim_config")
-- reload("dylan/harpoon")
reload("dylan/colorscheme")
reload("dylan/noice")
reload("dylan/telekasten")
reload("dylan/dashboard")
reload("dylan/spell")
-- usefull functions
reload("utils")
-- require('codeium').setup();
--
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

-- require('ObsidianExtra').hello()
