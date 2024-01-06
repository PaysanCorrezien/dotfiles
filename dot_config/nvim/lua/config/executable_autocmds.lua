-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local function augroup(name)
	return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end
-- Autocommand to set local working directory when entering a buffer
vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup("set_cwd_buffer"),
	callback = function()
		-- Use vim.fn.expand to get the file's directory
		local dir = vim.fn.expand("%:p:h")
		-- Change the local working directory
		vim.cmd("silent! lcd " .. dir)
	end,
})
