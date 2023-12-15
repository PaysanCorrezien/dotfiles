local M = {}

function M.get_os()
    local uname = vim.loop.os_uname()
    return (uname.sysname == "Windows_NT") and "Windows" or "Linux"
end

function M.get_setting(settings)
    local os = M.get_os()
    return settings[os]  -- This returns the setting based on the detected OS
end

return M

