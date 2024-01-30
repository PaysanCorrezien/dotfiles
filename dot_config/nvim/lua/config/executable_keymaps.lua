-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Changelog removal

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "NZzzv")
--une erreur de syntaxe
vim.keymap.set("n", "zj", "o<Esc>k") -- insert line down without leaver n mode
vim.keymap.set("n", "zk", "O<Esc>j") -- insert line up without leaver n mode
-- vim.keymap.set("n", "<leader>Zd", '"_d')
-- vim.keymap.set("v", "<leader>Zd", '"_d')
-- Use <C-B> (or <C-S-b> in some terminals) for visual block mode
vim.keymap.set("n", "<C-b>", "<C-v>")

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

-- vim.keymap.set("i", "<leader>cu", "<esc>mzgUiw`za") --current word in huppercase in insert mode a
-- vim.keymap.set("i", "<leader>cl", "<esc>mzguiw`za") --set current word in lowercase in insert mode
--
-- -- vim.api.nvim_set_keymap('n', '<leader>S', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left><Left>]], { noremap = true, silent = false })
-- vim.keymap.set("n", "<leader>S", "<cmd>%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gIc<Left><Left><Left><Left><Left><cr>") -- search and replace with highlight and confirmation
vim.keymap.set("n", "<S-Up>", "ddkP") --move line up on normal mode with shift
vim.keymap.set("n", "<S-Down>", "ddp") --move line down on normal mode with shift
vim.api.nvim_set_keymap("n", "<C-a>", ':lua vim.cmd("normal! ggVG")<CR>', { noremap = true }) -- Select ALL
-- Normal mode mappings
-- TODO : correct this path
-- vim.set_keymap(
--   "n",
--   "<leader>8",
--   "<cmd>:TodoTrouble cwd=/mnt/c/Users/dylan/Documents/Projet/Work/Projet/<CR>",
--   "Todo on All Project"
-- )
-- Normal mode mappings
-- vim.keymap.set("n", "<leader>I", "<cmd>IconPickerInsert<CR>", { desc = "Icon Picker" }) wezterm builtin now
vim.keymap.set("n", "<leader>S", ":lua search_and_replace()<CR>", { desc = "Search and replace" })
-- vim.keymap.set("n", "<leader>A", "<cmd>:lua require('harpoon.mark').add_file()<CR>", { desc = "Harp Add" })
-- vim.keymap.set("n", "<leader>H", "<cmd>:Telescope harpoon marks<CR>", { desc = "List Harp Mark" })
vim.keymap.set("n", "<leader>j", "<cmd>Telescope jumplist<CR>", { desc = "Jumplist" })
vim.keymap.set("n", "<leader>X", ":lua RunPowershellCommand()<CR>", { desc = "Run PowerShell Command" })
vim.keymap.set("n", "<leader>W", ":lua SudoSave()<CR>", { desc = "Save with Sudo" })
vim.keymap.set("n", "<leader>M", ":lua SaveWindowsCreds()<CR>", { desc = "Save with Windows Credentials" })
vim.keymap.set("n", "<leader>R", ":lua reload_config()<CR>", { desc = "Reload Conf" })
vim.keymap.set("n", "<leader>G", "<cmd>Git<CR>", { desc = "Git" })
-- vim.keymap.set("n", "<leader>gv", "<cmd>!git commit <CR>", { desc = "Git commit" })
-- vim.keymap.set("n", "<leader>ga", "<cmd>Git add .<CR>", { desc = "Git Add ALL" })
vim.keymap.set("n", "<leader>gL", "<cmd>Gitsigns setloclist<CR>", { desc = "Git LocList" })

-- Visual mode mappings
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy Y" })
-- BufferLine mappings
-- for tab number
for i = 1, 7 do
	vim.keymap.set("n", "<leader>" .. i, "<cmd>BufferLineGoToBuffer " .. i .. "<CR>", { desc = "Go To Tab " .. i })
end

-- Visual mode mapping
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy Y", silent = true })
-- Move Lines
vim.keymap.set("n", "<C-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<C-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<C-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<C-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<C-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<C-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- vim.keymap.set("n", "<leader>cP", "<cmd>put =expand('%:p:h')<CR>", { desc = "Full Path" })
vim.keymap.set("n", "<leader>cP", "<cmd>put =expand('%:h')<CR>", { desc = "Copy CWD" })
-- -- Mapping to start the Docusaurus server
-- vim.keymap.set("n", "<leader>zX", function()
-- 	StartDocusaurusServer()
-- end, { desc = "Start Docusaurus Server" })

-- Mapping to open the current file in Docusaurus
vim.keymap.set("n", "<leader>zo", function()
	OpenInDocusaurus()
end, { desc = "Open in Docusaurus" })

vim.api.nvim_set_keymap("n", "<leader>zD", ":lua StartDocusaurusServer()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>zd", ":lua StopDocusaurusServer()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>zX", ":lua GetDocusaurusBufferInfo()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>zN", ":lua CreateNote()<CR>", { noremap = true, silent = true })
