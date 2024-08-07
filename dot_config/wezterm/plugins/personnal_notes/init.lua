local wezterm = require "wezterm"
local act = wezterm.action

local M = {}

-- HACK: Custom function made for my personnal use that open my notes
-- TODO: make resolve path on WSL ?
function M.SwitchToNotesWorkspace()
  -- Retrieve environment variables
  local editor = os.getenv "editor" or "nvim" -- Default to nvim if $editor is not set
  local userprofile = os.getenv "userprofile"
  -- local knowledgeBasePath = userprofile and (userprofile .. "\\Documents\\KnowledgeBase")
  --   or "C:\\Users\\dylan\\Documents\\KnowledgeBase"
  local knowledgeBasePath = "/home/dylan/Documents/Notes/"
  -- local neovim_command = "Telescope find_files"
  local neovim_command = "FzfLua files { rg_opts = '--files --glob \"*.md\"' }"

  return wezterm.action_callback(function(window, pane)
    local workspace_exists = false
    for _, name in pairs(wezterm.mux.get_workspace_names()) do
      if name == "Notes" then
        workspace_exists = true
        break
      end
    end

    if workspace_exists then
      window:perform_action(act.SwitchToWorkspace { name = "Notes" }, pane)
    else
      -- Use the cwd parameter for changing directory
      window:perform_action(
        act.SwitchToWorkspace {
          name = "Notes",
          spawn = {
            args = { editor, "-c", neovim_command },
            cwd = knowledgeBasePath,
          },
        },
        pane
      )
    end
  end)
end

return M
