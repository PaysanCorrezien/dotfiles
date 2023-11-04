-- utils.lua
function _G.exec_luafile()
	local current_file = vim.fn.expand("%:p")
	if vim.fn.filereadable(current_file) ~= 1 then
		print("File not readable:", current_file)

		return
	end
	local ok, err = pcall(dofile, current_file)
	if not ok then
		print("Error executing Lua file:", err)
	end
end

function _G.search_and_replace()
	local word = vim.fn.expand("<cword>")
	local cmd = ":%s/\\<" .. word .. "\\>/" .. word .. "/gIc"
	vim.cmd("echo") -- Clear any messages
	vim.api.nvim_feedkeys(":", "n", false)
	vim.api.nvim_feedkeys(cmd, "m", false)
	for i = 1, 5 do
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Left>", true, false, true), "n", false)
	end
end

-- for autocommand on open  
function _G.rename_tmux_pane()
	local current_file = vim.fn.expand("%:t") -- Get the current file name
	local parent_dir = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":h:t") -- Get the parent directory name
	if current_file ~= "" and parent_dir ~= "" then
		os.execute('tmux rename-window " ' .. parent_dir .. "/" .. current_file .. '"')
	end
end

-- for autocommand on quit
function _G.reset_tmux_pane()
	-- Get the parent directory and current directory from within Neovim
	local parent_dir = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":h:h:t")
	local current_dir = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":h:t")
	-- Update the tmux window title to reflect the parent and current directory with the folder icon
	os.execute('tmux rename-window " ' .. parent_dir .. "/" .. current_dir .. '"')
end

function _G.reload_config()
    -- Step 1: Execute the command sequence
    local command_output = vim.fn.system('chezmoi apply && tmux source-file ~/.tmux.conf && source ~/.zshrc')
    if vim.v.shell_error ~= 0 then
        print("Error executing command sequence:", command_output)
        return
    end

    -- Save all open buffers
    vim.cmd("wa")

    -- Get the PID of the current nvim instance
    local nvim_pid = vim.fn.getpid()

    -- Start the restart script in the background, passing the current nvim PID as an argument, and disassociate from the current process
    local restart_command = string.format('!nohup ~/.config/scripts/reload-nvim.sh %d > /dev/null 2>&1 &', nvim_pid)
    vim.cmd(restart_command)

    -- Quit the current nvim instance
    vim.cmd('qa!')
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
	local base_path = "/mnt/c/Users/dylan/Mes documents/Obsidian Vault/Tasks/"
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
	local base_path = "/mnt/c/Users/dylan/Mes documents/Obsidian Vault/Tasks/"
	local opts = {
		prompt_title = "~ Recent Markdown Files ~",
		cwd = base_path,
		find_command = {
			"bash",
			"-c",
			"find . -type f -name '*.md' -exec stat -c '%Y %n' {} + | sort -rn | cut -d ' ' -f2-",
		},
		file_ignore_patterns = { ".git/", "node_modules/" },
		file_previewer = true,
		profile = true, -- Add this line to enable profiling
	}
	require("telescope.builtin").find_files(opts)
end

-- Opens the file based on the date format and ensures that the required directories exist.
-- Find my daily note based on format define on Obsidian that generate note every day on startup
local function openFile()
	-- Parameters
	-- TODO: make this a global configurable variable
	local base_path = "/mnt/c/Users/dylan/Mes documents/Obsidian Vault/Tasks/"

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

-- For working with windows
function _G.load_modules(modules)
	local is_windows = (package.config:sub(1, 1) == "\\")
	for module, load_on_windows in pairs(modules) do
		if is_windows then
			if load_on_windows then
				reload(module)
			end
		else
			reload(module)
		end
	end
end

-- For working with windows
function _G.remove_plugins_for_windows(plugins_not_on_windows)
	if package.config:sub(1, 1) == "\\" then -- If the OS is Windows
		for _, plugin_to_remove in ipairs(plugins_not_on_windows) do
			for i, plugin in ipairs(lvim.plugins) do
				if type(plugin) == "table" then
					if plugin[1] == plugin_to_remove then
						table.remove(lvim.plugins, i)
						break
					end
				elseif type(plugin) == "string" then
					if plugin == plugin_to_remove then
						table.remove(lvim.plugins, i)
						break
					end
				end
			end
		end
	end
end

-- Check if an argument was provided or use the current buffer
-- BUG: not working because path env variable are not loaded this way, use fzfwindows exemple to correct this
function _G.RunPowershellCommand(arg)
	local command_to_run
	if arg and #arg > 0 then
		command_to_run = "powershell.exe " .. arg
	else
		local bufname = vim.fn.bufname("%")
		if bufname:match("%.ps1$") then
			local content = table.concat(vim.fn.readfile(bufname), "\r\n")
			local temp_directory = "/mnt/c/temp/"
			os.execute("mkdir -p " .. temp_directory) -- Ensure the directory exists

			local tmpfile_linux = temp_directory .. "temp_script.ps1"
			vim.fn.writefile(vim.split(content, "\n"), tmpfile_linux)

			-- Convert the Linux path to a Windows path
			local tmpfile_windows = tmpfile_linux:gsub("^/mnt/c/", "C:\\\\"):gsub("/", "\\\\")

			-- Set the execution policy to "Bypass" for this process and execute the script
			command_to_run = 'powershell.exe -Command "Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass; . '
				.. tmpfile_windows
				.. '"'
		else
			print("No PS1 buffer or command provided")
			return
		end
	end

	-- Construct the full command to run via cmd.exe
	local full_command = "tmux split-window -h 'cmd.exe /k " .. command_to_run .. "'"

	-- Run the command in a new tmux pane
	os.execute(full_command)
end

function _G.SudoSave()
	-- Get the current file path
	local file_path = vim.fn.expand("%:p")

	-- If the file path is empty, then there's no file name specified
	if file_path == "" then
		vim.cmd('echoerr "No file name"')
		return
	end

	-- Escape spaces in the file path for the shell command
	local escaped_file_path = file_path:gsub(" ", "\\ ")

	-- Create the shell command to write the current buffer to the file with sudo rights
	local cmd = string.format("w !sudo tee %s > /dev/null", escaped_file_path)

	-- Execute the shell command
	vim.cmd(cmd)
end

-- Function to convert WSL path to Windows path
function wsl_to_win_path(wsl_path)
	local handle = io.popen("wslpath -w '" .. wsl_path .. "'")
	if not handle then
		vim.cmd('echoerr "Failed to open handle for path conversion"')
		return nil
	end
	local win_path = handle:read("*a")
	handle:close()
	if not win_path then
		vim.cmd('echoerr "Failed to read from handle for path conversion"')
		return nil
	end
	return win_path:gsub("\n", "")
end

function _G.SaveWindowsCreds()
	-- Get the current file path
	local file_path = vim.fn.expand("%:p")

	-- Check if the file path is not empty
	if file_path == "" then
		vim.cmd('echoerr "No file name"')
		return
	end

	-- Create a temporary file path
	-- Use the Windows path format and save to C:\temp
	-- Generate a random file name for the temporary file
	local random_file_name = "nvim_save_" .. os.tmpname():gsub("\\", ""):gsub("/", "")
	-- Combine with the desired directory path
	local tmp_file_path = "C:\\\\temp\\\\" .. random_file_name
	local wsl_tmp_file_path = "/mnt/c/temp/" .. random_file_name

	-- Write the current buffer to the temporary file
	vim.cmd("w " .. wsl_tmp_file_path)

	local home_dir = os.getenv("HOME")
	local wsl_ps_script_path = home_dir .. "/.config/windows/SaveAsAdmin.ps1"
	-- Translate WSL paths to Windows paths using wsl_to_win_path function
	local windows_tmp_file_path = wsl_to_win_path(wsl_tmp_file_path)
	local windows_file_path = wsl_to_win_path(file_path)
	local ps_script_path = wsl_to_win_path(wsl_ps_script_path)

	-- Check if the conversion was successful
	if not windows_tmp_file_path or not windows_file_path or not ps_script_path then
		vim.cmd('echoerr "Path conversion failed"')
		return
	end

	-- PowerShell script to prompt for credentials in a new window and copy the file
	-- Path to the PowerShell script
	-- Get the current user's home directory path

	-- Open a terminal buffer in Neovim and run the command
	vim.cmd("new")

	-- Construct the command to execute the PowerShell script
	local cmd = string.format(
		'powershell.exe -ExecutionPolicy Bypass -File "%s" -sourcePath "%s" -destinationPath "%s"',
		ps_script_path,
		windows_tmp_file_path,
		windows_file_path
	)
	--
	-- Debugging: print cmd to the Neovim command line
	-- vim.cmd('echo "' .. cmd .. '"')
	-- Open a terminal buffer in Neovim and run the command
	-- vim.fn.termopen(cmd)
	-- -- Open a terminal buffer in Neovim and run the command
	local job_id = vim.fn.termopen(cmd)

	-- Wait for the terminal job to finish (timeout set to 10 seconds, adjust as needed)
	local result = vim.fn.jobwait({ job_id }, 10000)[1]

	-- Close the terminal buffer
	-- Schedule the closure of the terminal buffer for the next event loop iteration
	vim.schedule(function()
		vim.cmd("bd!")
	end)

	-- Autoreload buffer correctly and bypass confirmation message
	if result == 0 then
		vim.cmd('echo "Copy with windows Creds Worked"')
		--BUG: not working, need to enforce reload automatically
		vim.cmd("silent! checktime")
	else
		vim.cmd('echoerr "Copy failed"')
	end
end
