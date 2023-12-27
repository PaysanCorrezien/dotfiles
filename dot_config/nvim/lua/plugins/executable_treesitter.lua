return {
  -- Extend nvim-treesitter configuration
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Ensure nested tables exist before extending
      opts.textobjects = opts.textobjects or {}
      opts.textobjects.move = opts.textobjects.move or {}

      -- Merge additional text object configurations
      opts.textobjects.move = vim.tbl_deep_extend("force", opts.textobjects.move, {
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]c"] = "@class.outer",
          -- Add your custom mappings here
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
          ["]C"] = "@class.outer",
          -- Add your custom mappings here
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[c"] = "@class.outer",
          -- Add your custom mappings here
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
          ["[C"] = "@class.outer",
          -- Add your custom mappings here
        },
        -- Add any other custom text object configurations here
      })

      -- Ensure nested tables exist before extending
      opts.textobjects = opts.textobjects or {}
      opts.textobjects.select = opts.textobjects.select or {}
      opts.textobjects.select.keymaps = opts.textobjects.select.keymaps or {}

      -- Directly define and merge custom text object mappings
      opts.textobjects.select.keymaps = vim.tbl_deep_extend("force", opts.textobjects.select.keymaps, {
        ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter" },
        ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter" },
        ["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
        ["if"] = { query = "@function.inner", desc = "Select inner part of a function" },
        ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
        ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },
        ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
        ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },
        ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
        ["ak"] = { query = "@comment.outer", desc = "Select outer part of a comment" },
        ["ik"] = { query = "@comment.inner", desc = "Select inner part of a comment" },
        -- Add any other custom text object configurations here
      })
      return opts
    end,
  },
}
