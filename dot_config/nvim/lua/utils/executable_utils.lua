--BUG: not in RTP ?
-- they are not available
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
	local command_output = vim.fn.system("chezmoi apply && tmux source-file ~/.tmux.conf && source ~/.zshrc")
	if vim.v.shell_error ~= 0 then
		print("Error executing command sequence:", command_output)
		return
	end

	-- Save all open buffers
	vim.cmd("wa")

	-- Get the PID of the current nvim instance
	local nvim_pid = vim.fn.getpid()

	-- Start the restart script in the background, passing the current nvim PID as an argument, and disassociate from the current process
	local restart_command = string.format("!nohup ~/.config/scripts/reload-nvim.sh %d > /dev/null 2>&1 &", nvim_pid)
	vim.cmd(restart_command)

	-- Quit the current nvim instance
	vim.cmd("qa!")
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
	local wsl_ps_script_path = home_dir .. "/.config/windows/PowershellScripts/SaveAsAdmin.ps1"
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
