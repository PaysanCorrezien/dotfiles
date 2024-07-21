local function is_nixos()
	local os_name = vim.loop.os_uname().sysname

	return os_name == "Linux" and (vim.loop.os_uname().version:find("NixOS") ~= nil)
end
return {
	-- nix.lua
	-- local function is_nixos()
	--   local handle = io.popen('cat /etc/os-release 2>/dev/null | grep ^ID= 2>/dev/null')
	--   local result = handle:read("*a")
	--   handle:close()
	--   return result:match("ID=nixos") ~= nil
	-- end
	--
	-- if is_nixos() then
	-- Assuming you are using lazy.nvim for LazyVim
	-- {
	-- 	"echre
	-- 	asnovski/mini.surround",
	-- 	enable = false,
	-- },

	-- :lua print(vim.loop.os_uname().sysname)

	-- Function to check if the current OS is NixOS

	-- Plugin configuration

	{

		"williamboman/mason.nvim",

		enabled = not is_nixos(), -- Disable Mason if the OS is NixOS
	},

	-- Other plugin configurations can go here

	{
		"williamboman/mason.nvim",
		enabled = false, -- Disable Mason on NixOS
	},
	-- Add other plugins you are using
	-- else
	--   require('lazy').setup({
	--     spec = {
	--       {
	--         'williamboman/mason.nvim',
	--         enabled = true,  -- Enable Mason on other systems
	--       },
	--       -- Add other plugins you are using
	--     },
	--   })
	-- end
}
