-- local fun = require "utils.fun" ---@class Fun
local wez = require "wezterm"
local dylan = require "utils.dylan" ---@class Dylan
local inspect = require "plugins.inspect" ---@class Inspect
local ssh = require "plugins.ssh_menu" ---@class SSH
local marks = require "plugins.marks" ---@class Marks
local workspace_manager = require "plugins.workspace_manager" ---@class WorkspaceManager
local personnal_notes = require "plugins.personnal_notes" ---@class PersonnalNotes
-- local music = require "plugins.music" ---@class Music
local vim_keymap = require "plugins.vim_keymap" ---@class VimKeymap
local toggle_session = require "plugins.toggle_session" ---@class ToggleSession
local workspace_switcher =
  -- zoxide + workspace switcher
  wez.plugin.require "https://github.com/MLFlexer/smart_workspace_switcher.wezterm"
local semantic_escape = require "plugins.semantic_escape" ---@class SemanticEscape
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

Config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }

local keys = {
  ["<C-Tab>"] = act.ActivateTabRelative(1),
  ["<C-S-Tab>"] = act.ActivateTabRelative(-1),
  ["<C-S-c>"] = act.CopyTo "Clipboard",
  ["<C-S-v>"] = act.PasteFrom "Clipboard", --TODO: maybe adapt this a bit
  -- ["<C-c>"] = act.CopyTo "Clipboard",
  ["<C-v>"] = act.PasteFrom "Clipboard",
  -- ["<C-S-f>"] = act.Search "CurrentSelectionOrEmptyString",
  ["<C-S-k>"] = act.ClearScrollback "ScrollbackOnly",
  ["<C-S-l>"] = act.ShowDebugOverlay,
  ["<C-S-n>"] = act.SpawnWindow,
  ["<C-S-p>"] = act.ActivateCommandPalette,
  ["<C-S-r>"] = act.ReloadConfiguration,
  ["<C-S-t>"] = act.SpawnTab "CurrentPaneDomain",
  ["<C-S-u>"] = act.CharSelect {
    copy_on_select = true,
    copy_to = "ClipboardAndPrimarySelection",
  },
  ["<C-S-w>"] = act.CloseCurrentTab { confirm = true },
  ["<C-S-z>"] = act.TogglePaneZoomState,
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
  ["<leader>H"] = act { AdjustPaneSize = { "Left", 5 } },
  ["<leader>J"] = act { AdjustPaneSize = { "Down", 5 } },
  ["<leader>K"] = act { AdjustPaneSize = { "Up", 5 } },
  ["<leader>L"] = act { AdjustPaneSize = { "Right", 5 } },
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
  ["<leader>S"] = wez.action_callback(function(window)
    session_manager.save_state(window)
  end),
  ["<leader>O"] = wez.action_callback(function(window)
    session_manager.load_state(window)
  end),
  ["<leader>R"] = wez.action_callback(function(window)
    session_manager.restore_state(window)
  end),
  -- ["<leader>N"] = dylan.RenameWorkspace "SuperTest", -- NOTE: test work just fine
  ["<leader>d"] = wez.action_callback(function(window)
    session_manager.delete_saved_session(window)
  end),
  ["<leader>B"] = wez.action_callback(function(window)
    session_manager.resurrect_all_sessions(window)
  end),
  -- ["<leader>N"] = personnal_notes.SwitchToNotesWorkspace(),
  ["<leader>N"] = toggle_session.toggle_session {
    name = "Notes",
    action = {
      args = { "nvim", "-c", "FzfLua files { rg_opts = '--files --glob \"*.md\"' }" },
      cwd = "/home/dylan/Documents/Notes/",
      env = { EDITOR = "nvim" },
    },
  },
  --FIXME: this doennt filter properly on filetypes
  ["<leader>n"] = toggle_session.toggle_session {
    name = "NixOs",
    action = {
      args = { "nvim", "-c", "FzfLua files { rg_opts = '--files --glob \"*.nix\"' }" },
      cwd = "/home/dylan/.config/nix/",
      env = { EDITOR = "nvim" },
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
  ["<C-S-a>"] = wez.action_callback(semantic_escape.parse_semantic_zones),
  -- ["<C-S-a>"] = wez.action_callback(function(window, pane)
  --   local zones = pane:get_semantic_zones()
  --   for _, zone in ipairs(zones) do
  --     local text = pane:get_text_from_semantic_zone(zone)
  --     wez.log_info("Semantic Zone: " .. wez.json_encode(zone) .. " Text: " .. text)
  --   end
  -- end),
  -- -- ["<C-S-a>"] = wez.action.ScrollToPrompt(+1),
}

Config.keys = {}
for lhs, rhs in pairs(keys) do
  vim_keymap.map(lhs, rhs, Config.keys)
end

return Config
