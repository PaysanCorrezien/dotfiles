-- local fun = require "utils.fun" ---@class Fun
local wez = require "wezterm"
local dylan = require "utils.dylan" ---@class Dylan
local inspect = require "plugins.inspect"
local ssh = require "plugins.ssh_menu"
local marks = require "plugins.marks"
local workspace_manager = require "plugins.workspace_manager" ---@class WorkspaceManager
local personnal_notes = require "plugins.personnal_notes" ---@class PersonnalNotes
-- local music = require "plugins.music" ---@class Music
local vim_keymap = require "plugins.vim_keymap" ---@class VimKeymap
local toggle_session = require "plugins.toggle_session" ---@class ToggleSession
--NOTE: https://github.com/wez/wezterm/issues/4488
--fail because of git config
--HACK: remove the git replacement , restart wezterm and then it download the plugins
local resurrect = wez.plugin.require "https://github.com/MLFlexer/resurrect.wezterm"
--
local workspace_switcher =
  wez.plugin.require "https://github.com/MLFlexer/smart_workspace_switcher.wezterm"
local semantic_escape = require "plugins.semantic_escape"
---@class Config
local Config = {}

local act = wez.action

-- this is called by the mux server when it starts up.

local function select_current_command(window, pane)
  wez.log_info "Starting select_current_command"

  local cursor = pane:get_cursor_position()
  wez.log_info("Cursor position: " .. cursor.x .. ", " .. cursor.y)

  local scrollback = pane:get_lines_as_text()
  wez.log_info "Fetched scrollback"

  local lines = wez.split_by_newlines(scrollback)
  wez.log_info "Split scrollback into lines"

  local prompt_pos = nil

  -- Traverse lines backwards to find the prompt position
  for i = cursor.y, 1, -1 do
    local line = lines[i + 1] -- lines array is 1-based
    if line then
      wez.log_info("Checking line " .. i .. ": " .. line)
      if line:find "^❯ " then -- Update to match your specific prompt symbol
        prompt_pos = { x = 0, y = i }
        wez.log_info("Found prompt at line " .. i)
        break
      end
    else
      wez.log_info("Line " .. i .. " is nil")
    end
  end

  -- If prompt position is found, perform the selection
  if prompt_pos then
    wez.log_info "Selecting text from prompt to cursor"

    -- Enter copy mode
    window:perform_action(wez.action.CopyMode "ClearSelectionMode", pane)

    -- Move to the prompt position
    local moves = cursor.y - prompt_pos.y
    for _ = 1, moves do
      window:perform_action(wez.action.CopyMode "MoveUp", pane)
    end
    for _ = 1, prompt_pos.x do
      window:perform_action(wez.action.CopyMode "MoveRight", pane)
    end

    -- Set selection start at the prompt position
    window:perform_action(wez.action.CopyMode "SetSelectionStart", pane)

    -- Move to the cursor position
    for _ = 1, moves do
      window:perform_action(wez.action.CopyMode "MoveDown", pane)
    end
    for _ = 1, cursor.x do
      window:perform_action(wez.action.CopyMode "MoveRight", pane)
    end

    -- Copy the selection to clipboard
    window:perform_action(wez.action.CopyTo "ClipboardAndPrimarySelection", pane)
  else
    wez.log_info "Prompt not found"
  end
end

wez.on("select-current-command", select_current_command)

Config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 500 }

local keys = {
  ["<C-Tab>"] = act.ActivateTabRelative(1),
  ["<C-S-Tab>"] = act.ActivateTabRelative(-1),
  ["<C-S-c>"] = act.CopyTo "Clipboard",
  ["<C-S-v>"] = act.PasteFrom "Clipboard", --TODO: maybe adapt this a bit
  -- ["<C-c>"] = act.CopyTo "Clipboard",
  ["<C-v>"] = act.PasteFrom "Clipboard",
  -- ["<C-S-f>"] = act.Search "CurrentSelectionOrEmptyString",
  -- ["<C-S-k>"] = act.ClearScrollback "ScrollbackOnly",
  ["<C-S-d>"] = act.ShowDebugOverlay,
  ["<C-S-n>"] = act.SpawnWindow,
  ["<C-S-p>"] = act.ActivateCommandPalette,
  ["<C-S-r>"] = act.ReloadConfiguration,
  ["<C-S-t>"] = act.SpawnTab "CurrentPaneDomain",
  ["<C-S-u>"] = act.CharSelect {
    copy_on_select = true,
    copy_to = "ClipboardAndPrimarySelection",
  },
  ["<C-S-w>"] = act.CloseCurrentTab { confirm = true },
  -- ["<C-S-z>"] = act.TogglePaneZoomState,
  ["<PageUp>"] = act.ScrollByPage(-1),
  ["<PageDown>"] = act.ScrollByPage(1),
  ["<C-S-Insert>"] = act.PasteFrom "PrimarySelection",
  -- ["<C-Insert>"] = act.CopyTo "PrimarySelection",
  -- ["<C-S-Space>"] = act.QuickSelect,

  ---quick split and nav
  ['<C-S-">'] = act.SplitHorizontal { domain = "CurrentPaneDomain" },
  ["<C-S-%>"] = act.SplitVertical { domain = "CurrentPaneDomain" },
  -- ["<C-M-h>"] = act.ActivatePaneDirection "Left",
  -- ["<C-M-j>"] = act.ActivatePaneDirection "Down",
  -- ["<C-M-k>"] = act.ActivatePaneDirection "Up",
  -- ["<C-M-l>"] = act.ActivatePaneDirection "Right",

  ---key tables
  ["<leader>w"] = act.ActivateKeyTable { name = "window_mode", one_shot = false },
  ["<leader>P"] = act.ActivateKeyTable { name = "font_mode", one_shot = false },
  ["<C-S-x>"] = act.ActivateCopyMode,
  ["<C-S-f>"] = act.Search "CurrentSelectionOrEmptyString",
  --
  -- ["<leader>-C-a"] = act { SendString = "\x01" },

  ["<leader>-"] = act { SplitVertical = { domain = "CurrentPaneDomain" } },
  -- ["<leader>\\"] = act { SplitHorizontal = { domain = "CurrentPaneDomain" } },
  ["<leader>s"] = act { SplitVertical = { domain = "CurrentPaneDomain" } },
  ["<leader>v"] = act { SplitHorizontal = { domain = "CurrentPaneDomain" } },
  ["<leader>o"] = act.TogglePaneZoomState,
  ["<leader>z"] = act.TogglePaneZoomState,
  ["<leader>c"] = act { SpawnTab = "CurrentPaneDomain" },
  ["<leader>h"] = act { ActivatePaneDirection = "Left" },
  ["<leader>j"] = act { ActivatePaneDirection = "Down" },
  ["<leader>k"] = act { ActivatePaneDirection = "Up" },
  ["<leader>l"] = act { ActivatePaneDirection = "Right" },
  ["<leader>H"] = act { AdjustPaneSize = { "Left", 10 } },
  ["<leader>J"] = act { AdjustPaneSize = { "Down", 10 } },
  ["<leader>K"] = act { AdjustPaneSize = { "Up", 10 } },
  ["<C-S-h>"] = act { AdjustPaneSize = { "Left", 10 } },
  ["<C-S-j>"] = act { AdjustPaneSize = { "Down", 10 } },
  ["<C-S-k>"] = act { AdjustPaneSize = { "Up", 10 } },
  ["<C-S-l>"] = act { AdjustPaneSize = { "Right", 10 } },
  ["<leader>L"] = act { AdjustPaneSize = { "Right", 10 } },
  ["<leader>1"] = act { ActivateTab = 0 },
  ["<leader>2"] = act { ActivateTab = 1 },
  ["<leader>3"] = act { ActivateTab = 2 },
  ["<leader>4"] = act { ActivateTab = 3 },
  ["<leader>5"] = act { ActivateTab = 4 },
  ["<leader>6"] = act { ActivateTab = 5 },
  ["<leader>7"] = act { ActivateTab = 6 },
  ["<leader>8"] = act { ActivateTab = 7 },
  ["<leader>9"] = act { ActivateTab = 8 },
  ["<leader>x"] = act { CloseCurrentPane = { confirm = true } },
  ["<leader>F"] = workspace_switcher.switch_workspace(),
  ["<leader>f"] = workspace_manager.SwitchPanes(),
  ["<leader>r"] = workspace_manager.RenameWorkspace(),
  --   local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
  --
  -- config.keys = {
  --   -- ...
  --   {
  --     key = "w",
  --     mods = "ALT",
  --     action = wezterm.action_callback(function(win, pane)
  --         resurrect.save_state(resurrect.workspace_state.get_workspace_state())
  --       end),
  --   },
  --   {
  --     key = "W",
  --     mods = "ALT",
  --     action = resurrect.window_state.save_window_action(),
  --   },
  --   {
  --     key = "s",
  --     mods = "ALT",
  --     action = wezterm.action_callback(function(win, pane)
  --         resurrect.save_state(resurrect.workspace_state.get_workspace_state())
  --         resurrect.window_state.save_window_action()
  --       end),
  --   },
  -- }
  ["<leader>S"] = wez.action_callback(function(window, pane)
    -- session_manager.save_state(window)
    resurrect.save_state(resurrect.workspace_state.get_workspace_state())
  end),
  ["<leader>O"] = wez.action_callback(function(window, pane)
    -- session_manager.load_state(window)
    resurrect.fuzzy_load(window, pane, function(id, label)
      local type = string.match(id, "^([^/]+)") -- match before '/'
      id = string.match(id, "([^/]+)$") -- match after '/'
      id = string.match(id, "(.+)%..+$") -- remove file extension
      local state
      if type == "workspace" then
        state = resurrect.load_state(id, "workspace")
        resurrect.workspace_state.restore_workspace(state, {
          relative = true,
          restore_text = true,
          on_pane_restore = resurrect.tab_state.default_on_pane_restore,
        })
      elseif type == "window" then
        state = resurrect.load_state(id, "window")
        resurrect.window_state.restore_window(window:mux_window(), state, {
          relative = true,
          restore_text = true,
          on_pane_restore = resurrect.tab_state.default_on_pane_restore,
          -- uncomment this line to use active tab when restoring
          -- tab = win:active_tab(),
        })
      end
    end)
  end),
  -- ["<leader>O"] = wez.action_callback(function(window, pane)
  --   resurrect.fuzzy_load(window, pane, function(id, label)
  --     local type = string.match(id, "^([^/]+)") -- match before '/'
  --     if type == "workspace" then
  --       id = string.match(id, "([^/]+)$") -- match after '/'
  --       id = string.match(id, "(.+)%..+$") -- remove file extension
  --       local state = resurrect.load_state(id, "workspace")
  --       resurrect.workspace_state.restore_workspace(state, {
  --         relative = true,
  --         restore_text = true,
  --         on_pane_restore = resurrect.tab_state.default_on_pane_restore,
  --       })
  --     end
  --   end)
  -- end),

  -- ["<leader>R"] = wez.action_callback(function(window)
  --   session_manager.restore_state(window)
  -- end),
  -- ["<leader>N"] = dylan.RenameWorkspace "SuperTest", -- NOTE: test work just fine
  -- ["<leader>d"] = wez.action_callback(function(window)
  --   session_manager.delete_saved_session(window)
  -- end),
  -- ["<leader>B"] = wez.action_callback(function(window)
  --   session_manager.resurrect_all_sessions(window)
  -- end),
  -- ["<leader>N"] = personnal_notes.SwitchToNotesWorkspace(),
  ["<leader>N"] = toggle_session.toggle_session {
    name = "Notes",
    action = {
      args = {
        "zsh",
        "-c",
        'source ~/.zshrc && nvim -c "FzfLua files { rg_opts = \'--files --glob \\"*.md\\"\'}"',
      },
      cwd = "/home/dylan/Documents/Notes/",
      env = { EDITOR = "nvim" },
    },
  },

  ["<leader>n"] = toggle_session.toggle_session {
    name = "NixOs",
    action = {
      args = {
        "zsh",
        "-c",
        'source ~/.zshrc && nvim -c "FzfLua files { rg_opts = \'--files --glob \\"*.nix\\"\'}"',
      },
      cwd = "/home/dylan/.config/nix/",
      -- env = { EDITOR = "nvim" },
    },
  },
  -- ["<leader>N"] = toggle_session.toggle_session {
  --   name = "Notes",
  --   action = {
  --     on_launch = {
  --       act {
  --         SendString = 'nvim -c "FzfLua files { rg_opts = \'--files --glob \\"*.md\\"\'}"',
  --       },
  --     },
  --     cwd = "/home/dylan/Documents/Notes/",
  --     env = { EDITOR = "nvim" },
  --     on_toggle = {
  --       act { SendString = "echo 'togled the session'" },
  --     },
  --   },
  -- },

  -- ["<leader>."] = music.SwitchToMusicWorkspace(),
  ["<leader>."] = toggle_session.toggle_session {
    name = "Music",
    action = {
      args = { "termusic" },
      cwd = "/home/dylan/Musique/",
    },
  },
  -- ["<leader>."] = toggle_session.toggle_session {
  --   on_launch = {
  --     act.SendString { string = "termusic" },
  --   },
  -- },

  ["<leader>M"] = wez.action_callback(function(window)
    marks.WriteMarkToDisk(window)
  end),
  ["<leader>m"] = wez.action_callback(function(window)
    marks.AccessMarkFromDisk(window)
  end),
  -- FIXME: this is not working
  ["<leader>Z"] = wez.action_callback(function(window, pane)
    ssh.ssh_menu(window, pane)
  end),
  -- NOTE: Windows elevation is problematic it need a new window to be spawned
  -- Windows terminal cant do it either
  -- Maybe try https://github.com/wez/wezterm/issues/167
  -- ["<4eader>E"] = act.SpawnCommandIkknNewTab {
  --   args = { "-Verb Runas" },
  --
  -- },
  ["<C-1>"] = act.SendKey {
    key = "1",
    mods = "CTRL",
  },
  ["<C-2>"] = act.SendKey {
    key = "2",
    mods = "CTRL",
  },
  ["<C-3>"] = act.SendKey {
    key = "3",
    mods = "CTRL",
  },
  ["<C-4>"] = act.SendKey {
    key = "4",
    mods = "CTRL",
  },
  ["<C-5>"] = act.SendKey {
    key = "5",
    mods = "CTRL",
  },
  ["<C-6>"] = act.SendKey {
    key = "6",
    mods = "CTRL",
  },
  ["<C-7>"] = act.SendKey {
    key = "7",
    mods = "CTRL",
  },
  ["<C-m>"] = act.SendKey {
    key = "m",
    mods = "CTRL",
  },
  -- Lua and wezterm magic open pane in neovim
  -- inspired by https://www.reddit.com/r/neovim/comments/18keepr/how_to_launch_nvim_in_current_terminal_and_show/
  ["<C-S-y>"] = wez.action_callback(function(window, pane)
    -- get all text (including color)
    -- wez.log_info("trying to open nvim buff")
    local success, stdout, stderr = wez.run_child_process {
      "wezterm",
      "cli",
      "get-text",
      "--escapes",
    }

    if not success then
      wez.log_error("Failed to get text: " .. (stderr or ""))
      return
    end

    -- Write text to temp file
    local fn = os.tmpname()
    local f = io.open(fn, "w+b")
    if not f then
      wez.log_error "Failed to open temporary file"
      return
    end
    f:write(stdout)
    f:flush()
    f:close()

    -- Launch nvim in a new tab and cat the file
    window:perform_action(
      act.SpawnCommandInNewTab {
        args = { "nvim", "-c", string.format("terminal cat %s && rm %s", fn, fn) },
      },
      pane
    )
  end),
  -- ["<C-a>"] = wez.action.EmitEvent "select-current-command",
  -- ["<C-S-a>"] = wez.action_callback(function(window, pane)
  --
  -- New key binding for Ctrl+A to select the current command
  -- ["<C-a>"] = wez.action_callback(function(window, pane)
  --  using zle for this isntead
  --   window:perform_action(wez.action.SelectTextAtMouseCursor "SemanticZone", pane)
  -- end),

  --   local zones = pane:get_semantic_zones()
  --   for _, zone in ipairs(zones) do
  --     local text = pane:get_text_from_semantic_zone(zone)
  --     wez.log_info("Semantic Zone: " .. wez.json_encode(zone) .. " Text: " .. text)
  --   end
  -- end),
  -- -- ["<C-S-a>"] = wez.action.ScrollToPrompt(+1),
  ["<C-S-o>"] = wez.action_callback(function(window, pane)
    local output = semantic_escape.get_last_command_output(pane)
    if output then
      -- window:set_clipboard(output)
      window:copy_to_clipboard(output)
      window:toast_notification(
        "WezTerm",
        "Last command output copied to clipboard",
        nil,
        2000
      )
    else
      window:toast_notification("WezTerm", "No command output found", nil, 4000)
    end
  end),
  ["<C-,>"] = wez.action_callback(function(window, pane)
    return semantic_escape.select_output_zone(window, pane, "previous")
  end),
  ["<C-.>"] = wez.action_callback(function(window, pane)
    return semantic_escape.select_output_zone(window, pane, "next")
  end),
  -- ["<C-S-a>"] = wez.action_callback(function(window, pane)
}
-- NOTE: added from resurrect
-- loads the state whenever I create a new workspace
wez.on(
  "smart_workspace_switcher.workspace_switcher.created",
  function(window, path, label)
    local workspace_state = resurrect.workspace_state

    workspace_state.restore_workspace(resurrect.load_state(label, "workspace"), {
      window = window,
      relative = true,
      restore_text = true,
      on_pane_restore = resurrect.tab_state.default_on_pane_restore,
    })
  end
)

-- Saves the state whenever I select a workspace
wez.on(
  "smart_workspace_switcher.workspace_switcher.selected",
  function(window, path, label)
    local workspace_state = resurrect.workspace_state
    resurrect.save_state(workspace_state.get_workspace_state())
  end
)
--NOTE: configure auto save every 15 minutes by default
resurrect.periodic_save()

--NOTE:adding smart-split to unify nvm and wez window management
local smart_splits = wez.plugin.require "https://github.com/mrjones2014/smart-splits.nvim"
local config = wez.config_builder()
-- you can put the rest of your Wezterm config here
smart_splits.apply_to_config(config, {
  -- the default config is here, if you'd like to use the default keys,
  -- you can omit this configuration table parameter and just use
  -- smart_splits.apply_to_config(config)

  -- directional keys to use in order of: left, down, up, right
  direction_keys = { "h", "j", "k", "l" },
  -- if you want to use separate direction keys for move vs. resize, you
  -- can also do this:
  -- direction keys = { move = { 'h', 'j', 'k', 'l' }, resize = { 'Left', 'Down', 'Up', 'Right' }, },
  -- modifier keys to combine with direction_keys
  modifiers = {
    move = "CTRL", -- modifier to use for pane movement, e.g. CTRL+h to move left
    resize = "CTRL|SHIFT", -- modifier to use for pane resize, e.g. META+h to resize to the left
  },
})

Config.keys = {}
for lhs, rhs in pairs(keys) do
  vim_keymap.map(lhs, rhs, Config.keys)
end

return Config
