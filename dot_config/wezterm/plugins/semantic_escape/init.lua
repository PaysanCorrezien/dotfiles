local wezterm = require "wezterm"
--NOTE: mandatory read :
-- https://wezfurlong.org/wezterm/shell-integration.html
--NOTE: related methods :
-- get_semantic_zone_at    https://wezfurlong.org/wezterm/config/lua/pane/get_semantic_zone_at.html
-- get_text_from_semantic_zone https://wezfurlong.org/wezterm/config/lua/pane/get_text_from_semantic_zone.html
-- get_semantic_zones    https://wezfurlong.org/wezterm/config/lua/pane/get_semantic_zones.html
-- ScrollToPrompt https://wezfurlong.org/wezterm/config/lua/keyassignment/ScrollToPrompt.html?h=semantic
--
local M = {}

--- Parse semantic zones from a pane and return JSON string
--- @param pane Pane
---  The pane to parse semantic zones from
--- @return string
---  A JSON string representing the parsed semantic zones
function M.parse_semantic_zones(window, pane)
  local zones = pane:get_semantic_zones()
  local parsed_zones = {}
  for id, zone in ipairs(zones) do
    local text = pane:get_text_from_semantic_zone(zone)
    table.insert(parsed_zones, {
      id = id,
      start_x = zone.start_x,
      start_y = zone.start_y,
      end_x = zone.end_x,
      end_y = zone.end_y,
      semantic_type = zone.semantic_type,
      text = text,
    })
  end
  local parsed_json = wezterm.json_encode(parsed_zones)
  wezterm.log_info("Parsed Semantic Zones: " .. parsed_json)
  return parsed_json
end

--- Save JSON data to a file
--- @param data string
---  The JSON string to save
--- @param filename string
---  The file path to save the JSON data to
function M.save_json_to_file(data, filename)
  local file = io.open(wezterm.home_dir .. filename, "w")
  if file then
    file:write(data)
    file:close()
    wezterm.log_info("JSON data saved to " .. filename)
  else
    wezterm.log_error("Failed to open file " .. filename .. " for writing")
  end
end

--- Load JSON data from a file
--- @param filename string
---  The file path to load the JSON data from
--- @return table
---  The decoded JSON data as a Lua table, or nil if loading failed
function M.load_json_from_file(filename)
  local file = io.open(wezterm.home_dir .. filename, "r")
  if file then
    local data = file:read "*a"
    file:close()
    local parsed_data = wezterm.json_decode(data)
    wezterm.log_info("JSON data loaded from " .. filename)
    return parsed_data
  else
    wezterm.log_error("Failed to open file " .. filename .. " for reading")
    --NOTE: Returning an empty table instead of nil to avoid nil checks
    return {}
  end
end

--- Get the last semantic zone
--- @param zones table
---  The table of semantic zones
--- @return table
---  The last semantic zone object
function M.get_last_semantic_zone(zones)
  local last_zone = zones[#zones]
  wezterm.log_info("Last Semantic Zone: " .. wezterm.json_encode(last_zone))
  return last_zone
end

--- Get the last command output
--- @param zones table
---  The table of semantic zones
--- @return string
---  The text of the last command output
function M.get_last_command_output(zones)
  for i = #zones, 1, -1 do
    local zone = zones[i]
    if zone.semantic_type == "Output" then
      wezterm.log_info("Last Command Output: " .. zone.text)
      return zone.text
    end
  end
  wezterm.log_info "No Command Output Found"
  return nil
end

return M
