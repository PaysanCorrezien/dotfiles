-- Manually set the PowerShell parser configuration
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.powershell = {
	install_info = {
		url = parser_path, -- Directory of the installed parser
		files = { "src/parser.c", "src/scanner.c" },
		branch = "main",
	},
	filetype = "ps1", -- Associate the parser with 'ps1' files
}

-- Set preferred compiler order
local install = require("nvim-treesitter.install")
install.compilers = { "zig", "gcc" }
