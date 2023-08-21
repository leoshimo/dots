-- hotreload.lua
-- Reload hammerspoon when configuration directory is updated

-- Dependency implementing `show(message)`
local alert = require "alert"

--- Reload configuration for given set of changed files
local function reloadConfig(changedFiles)
    doReload = false
    for _, file in pairs(changedFiles) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

-- Watch hammerspoon directory
hammerspoonDirWatcher = hs.pathwatcher.new(hs.configdir, reloadConfig)
if hammerspoonDirWatcher then
    hammerspoonDirWatcher:start()
end

-- Show alert on load
alert.show("Hammerspoon Loaded")
