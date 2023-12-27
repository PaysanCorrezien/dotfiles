-- WSL and Windows specific settings 
-- Workaround to use same config on both WSL and Windows
-- WIP - Not working yet
-- Function to get the current OS
local M = {}
function M.get_os()
    local uname = vim.loop.os_uname()
    return (uname.sysname == "Windows_NT") and "Windows" or "Linux"
end

-- Function to get the current Windows username
function M.get_windows_username()
    -- Assuming you are using Neovim, you can use vim.fn to access environment variables
    return vim.fn.getenv("USERNAME") or "default_username"
end

-- Function to convert paths
function M.convert_path(path)
    local os = M.get_os()
    if os == "Windows" then
        return path:gsub("/", "\\")
    else
        return path:gsub("\\", "/")
    end
end

function M.to_wsl_path(windows_path)
    print("Type of windows_path: ", type(windows_path))  -- Debug statement

    if type(windows_path) ~= "string" then
        error("Invalid windows_path: Expected a string, got " .. type(windows_path))
    end

    local windows_username = M.get_windows_username()
    print("Type of windows_username: ", type(windows_username))  -- Debug statement

    if type(windows_username) ~= "string" then
        error("Invalid windows_username: Expected a string, got " .. type(windows_username))
    end

    local converted_path = windows_path:gsub("C:\\Users\\" .. windows_username, "/mnt/c/Users/" .. windows_username)
    print("Converted path: ", converted_path)  -- Debug statement
    return converted_path
end


-- Function to convert WSL path to Windows path
function M.to_windows_path(wsl_path)
    local wsl_distribution = "Debian"  -- Replace with your WSL distribution name
    local windows_path = "//wsl$/" .. wsl_distribution .. wsl_path
    return windows_path
end

-- Function to convert Windows path to WSL path

-- Updated Function to get settings
function M.get_setting(settings)
    local os = M.get_os()

    -- If settings is a string, it's a path that needs conversion
    if type(settings) == "string" then
        if os == "Windows" then
            return M.to_windows_path(settings)
        else
            return M.to_wsl_path(settings)
        end
    end

    -- If settings is a table, handle it as before
    local setting = settings[os]

    if setting == nil and settings.default ~= nil then
        setting = settings.default
    end

    if setting == nil then
        error("No setting found for the current OS and no default setting provided.")
    end

    if os == "Windows" then
        local username = M.get_windows_username()
        setting = setting:gsub("dylan", username)
    end

    return M.convert_path(setting)
end

return M
