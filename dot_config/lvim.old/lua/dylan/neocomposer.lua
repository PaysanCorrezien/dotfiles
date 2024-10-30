
require("NeoComposer.ui").status_recording()
require("NeoComposer").setup()

lvim.builtin.lualine.sections.lualine_c = { require("NeoComposer.ui").status_recording }
