gptnvim_action_path = "L:\\home\\dylan\\.config\\lvim\\correct_french.json"

return {
  "jackMort/ChatGPT.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("chatgpt").setup({
      openai_params = {
        model = "gpt-4-1106-preview",
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 1000,
        temperature = 0,
        top_p = 1,
        n = 1,
      },
      actions_paths = { gptnvim_action_path },
      predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/PaysanCorrezien/dotfiles/main/dot_config/lvim/prompts.csv",
    })
  end,
  keys = {
    { "x", desc = "Misc + AI" },
    { "<leader>xg", "<cmd>ChatGPT<cr>", desc = "GPT Chat" },
    { "<leader>xA", "<cmd>ChatGPTActAs<cr>", desc = "ChatGPT Act As" },
    { "<leader>xt", "<cmd>ChatGPTEditWithInstructions<cr>", desc = "Edit with Instructions" },
    { "<leader>xC", "<cmd>ChatGPTRun complete_code<cr>", desc = "Complete Code" },
    { "<leader>xP", "<cmd>ChatGPTRun powershellDocs<cr>", desc = "Powershell Docs" },
    { "<leader>xL", "<cmd>ChatGPTRun luaEmmyDocs<cr>", desc = "Lua Docs" },
    { "<leader>xS", "<cmd>ChatGPTRun summarize<cr>", desc = "Summarize" },
    { "<leader>xD", "<cmd>ChatGPTRun docstrings<cr>", desc = "Docstrings" },
  },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   build = ":Copilot auth",
  --   opts = {
  --     suggestion = { enabled = false },
  --     panel = { enabled = false },
  --     filetypes = {
  --       markdown = false,
  --       help = false,
  --       -- config files with credentials
  --       yaml = false,
  --       toml = false,
  --       json = false,
  --     },
  --   },
  -- },
}
