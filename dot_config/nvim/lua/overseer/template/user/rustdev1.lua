return {
	name = "Rust: Run Clean and Build Task",
	builder = function()
		local winLogs = vim.fn.expand("C:\\Users\\dylan\\AppData\\roaming\\WinLogs\\app.log")
		local cleanup_command = "Remove-Item -Path " .. winLogs .. " -Force"
		local build_command = "cargo build"
		return {
			cmd = "pwsh",
			args = { "-Command", cleanup_command .. "; " .. build_cmd },
			name = "Rust: Clean and Build",
			cwd = vim.fn.expand("%:p:h"), -- Task working in the present active document location
			components = { "output_buffer", "default" },
		}
	end,
	condition = {
		filetype = { "rust" },
	},
	desc = "Build WintTools a RM Log",
	tags = { "build", "rust" },
}
