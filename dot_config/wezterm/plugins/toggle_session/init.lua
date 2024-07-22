local wezterm = require "wezterm"
local act = wezterm.action
local M = {}

-- Initialize the cache in wezterm.GLOBAL
wezterm.GLOBAL.last_workspace_cache = wezterm.GLOBAL.last_workspace_cache or {}

function M.toggle_session(config)
  return wezterm.action_callback(function(window, pane)
    local current_workspace = window:active_workspace()

    wezterm.log_info("Current workspace:", current_workspace)

    if current_workspace == config.name then
      -- We're in the target session, switch back to the cached workspace
      local last_workspace = wezterm.GLOBAL.last_workspace_cache[config.name]
      wezterm.log_info(
        "Attempting to switch back. Last workspace:",
        last_workspace or "nil"
      )

      if last_workspace then
        wezterm.log_info "Switching back to last workspace"
        window:perform_action(act.SwitchToWorkspace { name = last_workspace }, pane)
      else
        wezterm.log_info "No last workspace, switching to default workspace"
        window:perform_action(act.SwitchToWorkspace { name = "default" }, pane)
      end
    else
      -- We're not in the target session, switch to it
      wezterm.log_info("Switching to target session:", config.name)
      -- Save current workspace before switching
      wezterm.GLOBAL.last_workspace_cache[config.name] = current_workspace

      local workspace_exists = false
      for _, name in ipairs(wezterm.mux.get_workspace_names()) do
        if name == config.name then
          workspace_exists = true
          break
        end
      end

      if workspace_exists then
        wezterm.log_info "Workspace exists, switching to it"
        window:perform_action(act.SwitchToWorkspace { name = config.name }, pane)
      else
        wezterm.log_info "Workspace doesn't exist, creating it"
        local spawn_config = {
          label = config.name,
          args = config.action.args or {},
          cwd = config.action.cwd,
        }

        if config.action.env then
          spawn_config.set_environment_variables = config.action.env
        end

        window:perform_action(
          act.SwitchToWorkspace {
            name = config.name,
            spawn = spawn_config,
          },
          pane
        )

        if config.action.post_spawn then
          for _, cmd in ipairs(config.action.post_spawn) do
            window:perform_action(act.SendString(cmd), pane)
            window:perform_action(act.SendKey { key = "Enter" }, pane)
          end
        end
      end
    end
  end)
end

return M
