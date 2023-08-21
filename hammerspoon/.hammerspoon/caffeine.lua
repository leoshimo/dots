-- caffeine.lua
-- Keep display on / off

caffeine = hs.menubar.new()                   -- menu bar item displaying state

-- Images
local ON_ICON = 'resources/caffeine-on.pdf'
local OFF_ICON = 'resources/caffeine-off.pdf'

--- Update the state of menu bar icon
local function updateIcon(isCaffeinated)
    if isCaffeinated then
        caffeine:setIcon(ON_ICON)
    else
        caffeine:setIcon(OFF_ICON)
    end
end

--- Toggle caffeine state
local function toggleCaffeine()
    isCaffeinated = hs.caffeinate.toggle("displayIdle")
    updateIcon(isCaffeinated)
end

--- Setup menu bar
if caffeine then
    updateIcon(hs.caffeinate.get("displayIdle"))
    caffeine:setClickCallback(toggleCaffeine)
end

