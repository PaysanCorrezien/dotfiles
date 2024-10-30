
-- no need to set style = "lvim"
local components = require("lvim.core.lualine.components")

lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.lualine.sections.lualine_b = {
  components.branch,
  components.diff,
  components.scrollbar,
}

lvim.builtin.lualine.sections.lualine_c = { require("NeoComposer.ui").status_recording }

lvim.builtin.lualine.sections.lualine_y = {
	components.spaces,
  components.encoding,
	components.location,
}
