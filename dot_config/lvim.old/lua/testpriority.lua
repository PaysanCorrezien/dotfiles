-- testpriority.lua
local cmp = require("cmp")

-- Get the registered sources
local sources = cmp._sources

-- Iterate through the sources and print their priorities
for name, source in pairs(sources) do
  local priority = source:get_metadata().priority
  print("Source:", name, "Priority:", priority)
end

