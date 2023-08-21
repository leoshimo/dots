-- alert.lua
-- Customized alert UI

local M = {}

--- Show standard message alert
M.show = function(message)
    hs.alert.show(message, {
        strokeWidth = 0,
        strokeColor = { white = 0, alpha = 0 },
        padding = 20,
        radius = 8,
        textSize = 18,
    })
end

return M
