vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "NZzzv")
--une erreur de syntaxe
vim.keymap.set("n", "zj", "o<Esc>k") -- insert line down without leaver n mode
vim.keymap.set("n", "zk", "O<Esc>j") -- insert line up without leaver n mode
vim.keymap.set("n", "<leader>Zd", '"_d')
vim.keymap.set("v", "<leader>Zd", '"_d')
-- Use <C-B> (or <C-S-b> in some terminals) for visual block mode
vim.keymap.set('n', '<C-b>', '<C-v>')

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")
-- vim.keymap.set("i", "<leader>cu", "<esc>mzgUiw`za") --current word in huppercase in insert mode a
-- vim.keymap.set("i", "<leader>cl", "<esc>mzguiw`za") --set current word in lowercase in insert mode
vim.keymap.set("n", "<leader>S", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gIc<Left><Left><Left><Left><Left>") -- search and replace with highlight and confirmation
vim.keymap.set("n", "<S-Up>", "ddkP") --move line up on normal mode with shift
vim.keymap.set("n", "<S-Down>", "ddp") --move line down on normal mode with shift
vim.api.nvim_set_keymap("n", "<C-a>", ':lua vim.cmd("normal! ggVG")<CR>', { noremap = true }) -- Select ALL
lvim.keys.normal_mode["<C-s>"] = ":w<cr>" -- KEKW ctrl s sickness

vim.keymap.set("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u") --accetp first suggestion from :spellcheck for last word that the spellchecker find wrong

-- vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- vim.keymap.set({ "n", "v" }, "<leader>Y", [["+Y]])

local icons_opts = { noremap = true, silent = true }
vim.keymap.set("n", "<Leader><Leader>i", "<cmd>IconPickerNormal<cr>", icons_opts)
vim.keymap.set("n", "<Leader><Leader>y", "<cmd>IconPickerYank<cr>", icons_opts) --> Yank the selected icon into register
vim.keymap.set("i", "<C-i>", "<cmd>IconPickerInsert<cr>", icons_opts)
-- vim.keymap.set("i", "<C-I>", "<cmd>IconPickerInsert<cr>", icons_opts) -- not working with kitty
-- vim.keymap.set("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u") --syntaxe correction du dernier mot saisi

-- Set up the key mapping
vim.api.nvim_set_keymap(
	"n",
	"zg",
	':lua require("DictionnaryManager").add_word_to_spell_and_sync()<CR>',
	{ noremap = true, silent = false }
)
