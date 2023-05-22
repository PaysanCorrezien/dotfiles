-- https://github.com/IfCodingWereNatural/minimal-nvim
-- 
local kind = require("dylan/kind")

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "custom"

local header = {
  type = "text",
  val = require("dylan/banners").dashboard(),
  opts = {
    position = "center",
    hl = "Comment",
  },
}

local plugins = ""
local date = ""

if vim.fn.has "unix" == 1 then
  local handle = io.popen('fd -t d -d 1 . $HOME"/.local/share/lunarvim/site/pack/lazy/opt" | wc -l | tr -d "\n"')
  plugins = handle:read "*a"
  handle:close()
  
  local thingy = io.popen 'echo "$(date +%a) $(date +%d) $(date +%b)" | tr -d "\n"'
  date = thingy:read "*a"
  thingy:close()
  plugins = plugins:gsub("^%s*(.-)%s*$", "%1")

  --:TODO: windows part need to be adapted with correct folder
elseif vim.fn.has "win32" == 1 then
  local handle = io.popen([[powershell -Command "& { (Get-ChildItem -Directory $HOME\.local\share\lunarvim\site\pack\lazy\opt).Count }"]])
  plugins = handle:read "*a"
  handle:close()
  local thingy = io.popen([[powershell -Command "& { Get-Date -Format 'ddd dd MMM' }"]])
  date = thingy:read "*a"
  thingy:close()
  plugins = plugins:gsub("^%s*(.-)%s*$", "%1")
else
  plugins = "N/A"
  date = "  whatever "
end

local plugin_count = {
  type = "text",
  val = "└─ " .. kind.cmp_kind.Module .. " " .. plugins .. " plugins in total  ─┘",
  opts = {
    position = "center",
    hl = "String",
  },
}

local heading = {
  type = "text",
  val = "┌─ " .. kind.icons.calendar .. " Today is " .. date .. " ─┐",
  opts = {
    position = "center",
    hl = "String",
  },
}

local fortune = require "alpha.fortune" ()
-- fortune = fortune:gsub("^%s+", ""):gsub("%s+$", "")
local footer = {
  type = "text",
  val = fortune,
  opts = {
    position = "center",
    hl = "Comment",
    hl_shortcut = "Comment",
  },
}

local function button(sc, txt, keybind)
  local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

  local opts = {
    position = "center",
    text = txt,
    shortcut = sc,
    cursor = 5,
    width = 24,
    align_shortcut = "right",
    hl_shortcut = "Number",
    hl = "Function",
  }
  if keybind then
    opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
  end

  return {
    type = "button",
    val = txt,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
      vim.api.nvim_feedkeys(key, "normal", false)
    end,
    opts = opts,
  }
end

local buttons = {
  type = "group",
  val = {
    button("f", " " .. kind.cmp_kind.Folder .. " Explore", ":Telescope find_files<CR>"),
    button("o", " " .. kind.cmp_kind.Obsidian .. " Obsidian recents", "<Cmd>lua find_recent_note()<CR>"),
    button("e", " " .. kind.cmp_kind.File .. " New file", ":ene <BAR> startinsert <CR>"),
    button("s", " " .. kind.icons.magic .. " Restore", ":lua require('persistence').load()<cr>"),
    button(
      "g",
      " " .. kind.icons.git .. " Git Status",
      ":lua require('lvim.core.terminal')._exec_toggle({cmd = 'lazygit', count = 1, direction = 'float'})<CR>"
    ),
    button("r", " " .. kind.icons.clock .. " Recents", ":Telescope oldfiles<CR>"),
    button("c", " " .. kind.icons.settings .. " Config", ":e Telescope file_browser cwd=~/.local/share/chezmoi/dot_config/lvim/executable_config.lua<CR>"),
    button("d", " " .. kind.icons.dart .. " Dotfiles", ":Telescope file_browser cwd=~/.local/share/chezmoi/<CR>"),
    -- button("C", " " .. kind.cmp_kind.Color .. " Colorscheme Config", ":e ~/.config/lvim/lua/dylan/colorscheme.lua<CR>"),
    button("q", " " .. kind.icons.exit .. " Quit", ":q<CR>"),
  },
  opts = {
    spacing = 1,
  },
}

local section = {
  header = header,
  buttons = buttons,
  plugin_count = plugin_count,
  heading = heading,
  footer = footer,
}

lvim.builtin.alpha.custom = {
  config = {
    layout = {
      { type = "padding", val = 1 },
      section.header,
      { type = "padding", val = 2 },
      section.heading,
      section.plugin_count,
      { type = "padding", val = 1 },
      section.buttons,
      section.footer,
    },
    opts = {
      margin = 5,
    },
  }
}

