-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Changelog removal

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "NZzzv")
vim.keymap.set("n", "%", "%zz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "G", "Gzz")
vim.keymap.set("n", "gg", "ggzz")
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "zj", "o<Esc>k") -- insert line down without leaver n mode
vim.keymap.set("n", "zk", "O<Esc>j") -- insert line up without leaver n mode
-- vim.keymap.set("n", "<leader>Zd", '"_d')
-- vim.keymap.set("v", "<leader>Zd", '"_d')
-- Use <C-B> (or <C-S-b> in some terminals) for visual block mode
vim.keymap.set("n", "<C-b>", "<C-v>")

vim.keymap.set("i", "<C-c>", "<Esc>")
-- vim.keymap.set("n", "<leader>S", "<cmd>%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gIc<Left><Left><Left><Left><Left><cr>") -- search and replace with highlight and confirmation
vim.keymap.set("n", "<S-Up>", "ddkP") --move line up on normal mode with shift
vim.keymap.set("n", "<S-Down>", "ddp") --move line down on normal mode with shift
vim.api.nvim_set_keymap("n", "<C-a>", ':lua vim.cmd("normal! ggVG")<CR>', { noremap = true }) -- Select ALL
-- Normal mode mappings
vim.keymap.set("n", "<leader>8", "<cmd>TodoTelescope<cr>", { desc = "Todo Current Project" })
vim.keymap.set("n", "<leader>S", function()
	local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gcI<Left><Left><Left><Left>"
	local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end, { desc = "Search and replace" })
-- Open Spectre for global find/replace
-- NOTE: sr on lazyvim
-- vim.keymap.set("n", "<leader>S", function()
-- 	require("spectre").toggle()
-- end, { desc = "Spectre" })

-- vim.keymap.set("n", "<leader>/", function()
-- 	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
-- 		previewer = false,
-- 	}))
-- end, { desc = "[/] Fuzzily search in current buffer]" })

vim.keymap.set("n", "<leader>zs", function()
	require("telescope.builtin").spell_suggest(require("telescope.themes").get_dropdown({
		previewer = false,
	}))
end, { desc = "[S]earch [S]pelling suggestions" })

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

--BUG: not working
-- vim.keymap.set("n", "<leader>cP", "<cmd>put =expand('%:p:h')<CR>", { desc = "Full Path" })
-- vim.keymap.set("n", "<leader>cP", "<cmd>put =expand('%:h')<CR>", { desc = "Copy CWD" })

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

-- Comment toggle auto for multimode in a single key
local function comment_toggle()
	local mode = vim.fn.mode()

	-- print("mode before the action " .. mode)
	if mode == "n" then
		-- Normal mode
		-- No count, current line
		return "<Plug>(comment_toggle_linewise_current)"
	elseif mode == "v" then
		-- Visual mode
		-- Correcting the toggle for visual mode
		return "<Plug>(comment_toggle_linewise_visual)gv"
	elseif mode == "V" then
		-- Visual mode
		-- Correcting the toggle for visual mode
		return "<Plug>(comment_toggle_linewise_visual)gv"
	elseif mode == "CTRL-V" then
		-- Visual block mode
		return "<Plug>(comment_toggle_blockwise_visual)gv"
	elseif mode == "i" then
		-- Insert mode
		-- Comment the current line and return to normal mode
		return "<Esc><Plug>(comment_toggle_linewise_current)"
	end
end

vim.keymap.set({ "n", "x", "i" }, "<C-z>", comment_toggle, { expr = true, silent = true })

vim.api.nvim_create_user_command("OverseerRestartLast", function()
	local overseer = require("overseer")
	local tasks = overseer.list_tasks({ recent_first = true })
	if vim.tbl_isempty(tasks) then
		vim.notify("No tasks found", vim.log.levels.WARN)
	else
		overseer.run_action(tasks[1], "restart")
	end
end, {})
vim.keymap.set("n", "<leader>cR", ":OverseerRestartLast<CR>", { desc = "Restart last task" })

vim.keymap.set("n", "<leader>cT", "<cmd>TroubleToggle workspace_diagnostic<CR>", { desc = "TroubleProjet" })
vim.keymap.set("n", "<leader>ct", "<cmd>TroubleToggle document_diagnostic<CR>", { desc = "TroubleLocal" })
