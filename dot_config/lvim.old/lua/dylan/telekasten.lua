local os_utils = require("os_utils")

local obsidiannvim_settings = {
	vault_paths = {
		Windows = "C:\\Users\\dylan\\Documents\\KnowledgeBase",
		Linux = "/mnt/c/users/dylan/Documents/KnowledgeBase/",
	},
}
local obsidian_vault_path = os_utils.get_setting(obsidiannvim_settings.vault_paths)

require('telekasten').setup({
  --HACK: wont work on work computer
  home = obsidian_vault_path
})
