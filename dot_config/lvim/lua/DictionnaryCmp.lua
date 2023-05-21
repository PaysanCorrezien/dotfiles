local cmp = require("cmp")

local source = {}

source.new = function()
  return setmetatable({}, { __index = source })
end

function source:get_metadata()
  return {
    priority = 20000,
    menu = '[dictionnary]',
    debounce = 0,
  }
end

function source:is_available()
  local ft = vim.bo.filetype
  local available = ft == 'markdown' or ft == 'md'
  return available
end

function source:complete(params, callback)
  local custom_dict_path = vim.g.my_ltexfile_path
  local words = {}

  if custom_dict_path then
    for line in io.lines(custom_dict_path) do
      table.insert(words, line)
    end
  end

  local items = {}

  -- Get prefix
  local prefix = string.match(params.context.cursor_before_line, "[^%s%p]*$")

  -- Add custom dictionary words to items (only matching ones)
  for _, word in ipairs(words) do
    if string.find(word, prefix) == 1 then
      table.insert(items, {
        label = word,
        kind = cmp.lsp.CompletionItemKind.Text,
      })
    end
  end

  -- Add Neovim spell suggestions
  local typed_word = string.match(params.context.cursor_before_line, "[^%s%p]*$")
  local spell_suggestions = vim.fn.spellsuggest(typed_word, 5)
  for index, suggestion in ipairs(spell_suggestions) do
    table.insert(items, {
      label = suggestion,
      kind = cmp.lsp.CompletionItemKind.Text,
    })
    if index >= 5 then
      break
    end
  end

  -- Print labels for debugging
  local labels = {}
  for _, item in ipairs(items) do
    table.insert(labels, item.label)
  end
  print("Combined suggestions:", table.concat(labels, ", "))

  callback(items)
end

cmp.register_source('dictionnary', source.new())

print("Dictionary source registered")

