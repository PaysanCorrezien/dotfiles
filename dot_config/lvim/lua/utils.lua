-- utils.lua
function _G.exec_luafile()
	local current_file = vim.fn.expand("%:p")
	if vim.fn.filereadable(current_file) ~= 1 then print("File not readable:", current_file)

		return
	end
	local ok, err = pcall(dofile, current_file)
	if not ok then
		print("Error executing Lua file:", err)
	end
end

function _G.reload_config()
	vim.cmd("source ~/.config/lvim/config.lua") -- Change this path to the path of your lvim configuration file
	vim.cmd("silent! :bufdo e")
	print("Config reloaded.")
end
--TODO check if break register
function _G.insert_change()
	local current_line = vim.api.nvim_get_current_line()
	if current_line:match("^%s*$") then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("_cc", true, false, true), "n", true)
	-- vim.cmd("normal! ==")
	else
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i", true, false, true), "n", true)
	end
end

-- function _G.delete_change()
--   local current_line = vim.api.nvim_get_current_line()
--   if current_line:match("^%s*$") then
--     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('"_dd', true, false, true), "n", true)
--   else
--     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('dd', true, false, true), "n", true)
--   end
-- end

-- local actions = require("telescope.actions")

-- function _G.NewNoteFromTemplate()
-- 	local base_path = "/home/dylan/Documents/Obsidian Vault/"
-- 	local templates_dir = "Zettelkasten/Templates"
-- 	local target_dir = "Zettelkasten/Main"
-- 	local templates_path = base_path .. templates_dir

-- 	local files = vim.fn.glob(templates_path .. "/*", false, true)

-- 	if #files > 0 then
-- 		require("telescope.builtin").find_files({
-- 			prompt_title = "Select a Template",
-- 			cwd = templates_path,
-- 			attach_mappings = function(_, map)
-- 				map("i", "<CR>", function(prompt_bufnr)
-- 					local selected_file = require("telescope.actions.state").get_selected_entry().value
-- 					actions.close(prompt_bufnr)
-- 					local new_filename = vim.fn.input("Type the Filename: ")

-- 					if new_filename ~= "" then
-- 						local target_path = base_path .. target_dir
-- 						local new_file_path = target_path .. "/" .. new_filename .. ".md"

-- 						if vim.fn.filereadable(new_file_path) == 1 then
-- 							vim.api.nvim_notify("The file already exists.", 2, {})
-- 							return
-- 						end

-- 						vim.fn.systemlist(
-- 							"cp '" .. templates_path .. "/" .. selected_file .. "' '" .. new_file_path .. "'"
-- 						)
-- 						vim.cmd("edit " .. new_file_path)
-- 					else
-- 						vim.api.nvim_notify("Filename cannot be empty.", 2, {})
-- 					end
-- 				end)
-- 				return true
-- 			end,
-- 		})
-- 	else
-- 		vim.api.nvim_notify("No files found in the Templates directory.", 2, {})
-- 	end
-- end

function _G.NewNoteWithCustomTemplate()
	local base_path = "/home/dylan/Documents/Obsidian Vault/"
	local target_dir = "Zettelkasten/Main"
	local target_path = base_path .. target_dir

	local new_filename = vim.fn.input("Type the Filename: ")

	if new_filename ~= "" then
		local new_file_path = target_path .. "/" .. new_filename .. ".md"

		if vim.fn.filereadable(new_file_path) == 1 then
			vim.api.nvim_notify("The file already exists.", 2, {})
			return
		end

		local current_date = os.date("%Y-%m-%d %H:%M")
		local template = current_date
			.. "\nStatus : #idea\nTags :\n\n<h1> <center><u> "
			.. new_filename
			.. " </u></center></h1>\n\n#\n\n---\n\n # Références\n"
		vim.fn.writefile(vim.split(template, "\n"), new_file_path)
		vim.cmd("edit " .. new_file_path)

		-- Find a line starting with '#' and place the cursor in insert mode just after it
		vim.cmd("call search('^#$', 'ce')")
		vim.cmd("normal! a")
	else
		vim.api.nvim_notify("Filename cannot be empty.", 2, {})
	end
end


function _G.find_recent_note()
  local base_path = "/home/dylan/Documents/Obsidian Vault/"
  local opts = {
    prompt_title = "~ Recent Markdown Files ~",
    cwd = base_path,
    find_command = {
      "bash", "-c", "find . -type f -name '*.md' -exec stat -c '%Y %n' {} + | sort -rn | cut -d ' ' -f2-"
    },
    file_ignore_patterns = {".git/", "node_modules/"},
    file_previewer = true,
    profile = true, -- Add this line to enable profiling
  }
  require("telescope.builtin").find_files(opts)
end

-- Opens the file based on the date format and ensures that the required directories exist.
local function openFile()
  -- Parameters
  local base_path = "/home/dylan/Documents/Obsidian Vault/Tasks/"

  -- Date format
  local date = os.date("*t")
  local year = date.year
  local month = string.format("%02d-%s", date.month, os.date("%B"))
  local day = string.format("%04d-%02d-%02d-%s", year, date.month, date.day, os.date("%A"))

  -- File path
  local file_path = string.format("%s%s/%s/%s.md", base_path, year, month, day)
  local expanded_file_path = vim.fn.expand(file_path)

  -- Create directories if they do not exist
  local dir_path = vim.fn.expand(string.format("%s%s/%s", base_path, year, month))
  if vim.fn.isdirectory(dir_path) ~= 1 then
    vim.fn.mkdir(dir_path, "p")
  end

  -- Open the file
  vim.cmd(string.format("edit %s", file_path))
end

-- Creates a daily task below the "## Taches" heading.
-- If the heading is not found, a notification is sent.
function _G.CreateDailyTask()
  openFile()

  -- Parameters
  local task_heading = "## Taches"
  local task_format = "- [ ] #task"

  -- Find the task heading
  local task_heading_line = -1
  for i = 1, vim.fn.line("$") do
    if vim.fn.getline(i) == task_heading then
      task_heading_line = i
      break
    end
  end

  -- Add a new task below the heading and enter insert mode
  if task_heading_line ~= -1 then
    vim.fn.append(task_heading_line, task_format)
    vim.cmd(string.format("normal! %dG", task_heading_line + 1))
    vim.cmd("startinsert!")
  else
    vim.api.nvim_notify("Task heading not found.", 2, {})
  end
end

-- Creates a note below the "## Notes" heading.
-- If the heading is not found, a notification is sent.
function _G.CreateNote()
  openFile()

  -- Heading to find
  local heading = "## Notes"

  -- Find the heading
  local heading_line = -1
  for i = 1, vim.fn.line("$") do
    if vim.fn.getline(i) == heading then
      heading_line = i
      break
    end
  end

  -- Create a new line below the heading and enter insert mode
  if heading_line ~= -1 then
    vim.fn.append(heading_line, "")
    vim.cmd(string.format("normal! %dG", heading_line + 1))
    vim.cmd("startinsert!")
  else
    vim.api.nvim_notify("Heading not found.", 2, {})
  end
end

