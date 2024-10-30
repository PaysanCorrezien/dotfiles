local wezterm = require "wezterm"
local act = wezterm.action
local M = {}

function M.SwitchToMusicWorkspace()
  local music_app = "termusic"
  local workspace_name = "Music"

  return wezterm.action_callback(function(window, pane)
    local workspace_exists = false
    for _, name in ipairs(wezterm.mux.get_workspace_names()) do
      if name == workspace_name then
        workspace_exists = true
        break
      end
    end

    if workspace_exists then
      window:perform_action(act.SwitchToWorkspace { name = workspace_name }, pane)
    else
      window:perform_action(
        act.SwitchToWorkspace {
          name = workspace_name,
          spawn = {
            args = { music_app },
          },
        },
        pane
      )
    end
  end)
end

return M
