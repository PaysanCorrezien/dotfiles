-- ltex.lua
local F = vim.fn
local Path = require('plenary.path')

---@param root_dir? Path|string
---@return Path
local function get_settings_dir(root_dir)
  -- in single file mode, use global user dir
  local res = Path:new(F.stdpath('data')) / 'ltex'
  if root_dir then
    res = Path:new(root_dir) / '.vscode'
  end

  res:mkdir({ parents = true, exists_ok = true })
  return res
end

-- Read external file in settings dir and add their content to settings
---@param settings table<string, any>
---@param settings_dir Path
---@param prop string
local function read_prop(settings, settings_dir, prop)
  local dict = settings['ltex.' .. prop] or {}

  local files = F.readdir(settings_dir.filename)
  for _, entry in pairs(files) do
    local matches, _, lang = entry:find('ltex%.' .. prop .. '%.(.+)%.txt')
    if matches then
      local path = Path:new(settings_dir, entry)
      local langWords = dict[lang] or {}

      for item in path:iter() do
        if item and item:len() > 0 then
          if vim.tbl_contains(langWords, item) == false then
            table.insert(langWords, item)
          end
        end
      end
    end
  end
end

---@param settings_dir Path
---@param prop string
---@param dict table<string, string[]>
local function write_prop(settings_dir, prop, dict)
  for lang, list in pairs(dict) do
    local filepath = settings_dir / string.format('ltex.%s.%s.txt', prop, lang)
    F.writefile(list, filepath.filename, 'a')
  end
end

---@param settings table<string, any>
---@param settings_dir Path
local function load_dicts(settings, settings_dir)
  read_prop(settings, settings_dir, 'dictionary')
  -- read_prop(settings, settings_dir, 'hiddenFalsePositives')
  -- read_prop(settings, settings_dir, 'disabledRules')
end

local function client_reload_config(client)
  local settings = client.config.settings
  load_dicts(settings, get_settings_dir())
  load_dicts(settings, get_settings_dir(client.config.root_dir))
  client.notify('workspace/didChangeConfiguration', {
    settings = settings
  })
end

local function make_cmd(prop, arg_prop)
  return function(args, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    local root = client.config.root_dir -- Updated line

    write_prop(get_settings_dir(root), prop, args.arguments[1][arg_prop])
    client_reload_config(client)
  end
end

local M = {}

function M.on_server_setup(opts)
  -- opts.root_dir = function(startpath)
  --   return vim.fn.getcwd()
  -- end

  opts.on_init = function(client)
    client.commands['_ltex.addToDictionary'] = make_cmd('dictionary', 'words')
    client.commands['_ltex.hideFalsePositives'] = make_cmd('hiddenFalsePositives', 'falsePositives')
    client.commands['_ltex.disableRules'] = make_cmd('disabledRules', 'ruleIds')
  end
end

function M.on_new_config(new_config, root_dir)
  load_dicts(new_config.settings, get_settings_dir())
  load_dicts(new_config.settings, get_settings_dir(root_dir))
end

return M

