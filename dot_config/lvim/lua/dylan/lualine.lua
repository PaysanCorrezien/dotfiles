
lvim.builtin.lualine.sections.lualine_c = { require("NeoComposer.ui").status_recording }
-- no need to set style = "lvim"
local components = require("lvim.core.lualine.components")

lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.lualine.sections.lualine_y = {
	components.spaces,
	components.location,
}
