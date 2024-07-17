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
        {
        'williamboman/mason.nvim',
        enabled = false,  -- Disable Mason on NixOS
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
