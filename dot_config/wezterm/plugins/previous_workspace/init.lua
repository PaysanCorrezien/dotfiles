local wezterm = require "wezterm"

local M = {}

-- Initialize the global variables
wezterm.GLOBAL.previous_workspace = wezterm.GLOBAL.previous_workspace
  or { current = nil, previous = nil }

-- Helper function for logging
local function log(message)
  wezterm.log_info("[previous_workspace] " .. message)
end

-- Update the previous workspace when switching
wezterm.on("update-right-status", function(window, pane)
  local current_workspace = window:active_workspace()

  if current_workspace ~= wezterm.GLOBAL.previous_workspace.current then
    log "Workspace change detected"
    log("Previous current: " .. tostring(wezterm.GLOBAL.previous_workspace.current))
    log("New current: " .. current_workspace)

    -- Update previous workspace
    wezterm.GLOBAL.previous_workspace.previous = wezterm.GLOBAL.previous_workspace.current
    wezterm.GLOBAL.previous_workspace.current = current_workspace

    log(
      "Updated previous workspace to: "
        .. tostring(wezterm.GLOBAL.previous_workspace.previous)
    )
  end
end)

-- Function to switch to the previous workspace
function M.switch_to_previous_workspace()
  log "switch_to_previous_workspace function defined"
  return wezterm.action_callback(function(window, pane)
    log "switch_to_previous_workspace callback triggered"
    local previous_workspace = wezterm.GLOBAL.previous_workspace.previous
    log("Attempting to switch to previous workspace: " .. tostring(previous_workspace))

    if previous_workspace then
      window:perform_action(
        wezterm.action.SwitchToWorkspace { name = previous_workspace },
        pane
      )
    else
      log "No previous workspace to switch to"
    end
  end)
end

log "Plugin loaded"

return M
