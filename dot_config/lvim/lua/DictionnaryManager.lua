local DictionnaryManager = {}

local function read_file(file)
  local lines = {}
  for line in io.lines(file) do
    lines[line] = true
  end
  return lines
end

local function file_exists(file)
  local f = io.open(file, "r")
  if f then
    f:close()
    return true
  else
    return false
  end
end

-- Write the contents of a table to a file
local function write_file(file, lines)
  local f = io.open(file, "w")
  for line in pairs(lines) do
    f:write(line .. "\n")
  end
  f:close()
end

function DictionnaryManager.sync_on_close()
  local spellfile = vim.g.my_spellfile_path
  local ltexfile = vim.g.my_ltexfile_path

  if not file_exists(spellfile) or not file_exists(ltexfile) then
    return
  end

  local spell_lines = read_file(spellfile)
  local ltex_lines = read_file(ltexfile)

  -- Merge the ltex-ls dictionary into the spell.add file and vice versa
  for line in pairs(ltex_lines) do
    spell_lines[line] = true
  end

  for line in pairs(spell_lines) do
    ltex_lines[line] = true
  end

  -- Write the merged contents back to both files
  write_file(spellfile, spell_lines)
  write_file(ltexfile, ltex_lines)
end


local function sync_dictionaries(spellfile, ltexfile, word)
  -- ...

  -- Read both files and merge their contents
  local spell_lines = read_file(spellfile)
  local ltex_lines = read_file(ltexfile)

  -- Merge the ltex-ls dictionary into the spell.add file and vice versa
  for line in pairs(ltex_lines) do
    spell_lines[line] = true
  end

  for line in pairs(spell_lines) do
    ltex_lines[line] = true
  end

  -- Always add the new word to both dictionaries
  spell_lines[word] = true
  ltex_lines[word] = true

  if not file_exists(spellfile) then
    print("Error: spellfile does not exist: " .. spellfile)
    return
  end

  if not file_exists(ltexfile) then
    print("Error: ltexfile does not exist: " .. ltexfile)
    return
  end
  -- Write the merged contents back to both files
  write_file(spellfile, spell_lines)
  write_file(ltexfile, ltex_lines)
end


function DictionnaryManager.add_word_to_spell_and_sync()
  local word = vim.fn.expand('<cword>')

  -- Add the word to the spell checker
  vim.cmd('silent! normal! zg')

  -- Sync the dictionaries
  sync_dictionaries(vim.g.my_spellfile_path, vim.g.my_ltexfile_path, word)

  -- Show a Neovim notification with the added word
  vim.notify("The word \"" .. word .. "\" was added to the dictionaries", vim.log.levels.INFO)
end

return DictionnaryManager
