return {
  {
    "ecthelionvi/NeoComposer.nvim",
    dependencies = { "kkharji/sqlite.lua" },
    opts = {},
    config = function()
      require("NeoComposer").setup()
      -- require("Neocomposer").status_recording()
      -- require("NeoComposer.ui").status_recording()
    end,
    keys = {
      { "<leader>xm", "<cmd>:Telescope macros<cr>", desc = "Neo Macros" },
    },
  },
}
