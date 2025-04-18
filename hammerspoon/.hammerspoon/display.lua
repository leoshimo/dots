-- display.lua
-- Menu Bar App to adjust resolution
--
-- TODO:
-- - Options for resolution should be filtered by `hs.screen:availableModes()`

--[[
-- Favorites
-- Grab resolutions off:
-- print(hs.inspect(hs.screen.mainScreen():currentMode()))
--]]

local favorites = {}

-- M1 14in MBP
favorites["1352x878@2x 47Hz 8bpp"] = true
favorites["1800x1169@2x 47Hz 8bpp"] = true
favorites["1800x1125@2x 50Hz 8bpp"] = true

-- M1 16in MBP
favorites["1728x1117@2x 60Hz 8bpp"] = true
favorites["2056x1329@2x 120Hz 8bpp"] = true
favorites["2056x1285@2x 47Hz 8bpp"] = true
favorites["3456x2160@1x 60Hz 8bpp"] = true

-- LG UltraFine 24-inch
favorites["1920x1080@2x 30Hz 8bpp"] = true
favorites["2304x1296@2x 30Hz 8bpp"] = true
favorites["3008x1692@2x 30Hz 8bpp"] = true

-- LG UltraFine 27-inch
favorites["2560x1440@2x 60Hz 8bpp"] = true
favorites["2880x1620@2x 60Hz 8bpp"] = true
favorites["3200x1800@2x 60Hz 8bpp"] = true

--[[
-- Dependencies
--]]

-- Dependency implementing `show(message)`
local alert = require "alert"

--[[
-- State
--]]

local display_menu                                       -- menu item
local change_resolution, get_menu, is_current_resolution
local showAll = false


--[[
-- Functions
--]]


-- Gets all resolutions as sorted list
local get_resolutions = function(screen, all)
  local modes = screen:availableModes()   -- Available resolution modes
  local resolutions = {}

  -- Show in sorted order
  local mode_keys = {}
  for k in pairs(modes) do table.insert(mode_keys, k) end
  table.sort(mode_keys)

  for _, k in pairs(mode_keys) do
    if all or
      favorites[k] or
      is_current_resolution(modes[k])
    then
      modes[k]["desc"] = k
      table.insert(resolutions, modes[k])
    end
  end

  return resolutions
end

--[[
-- Config
--]]

--[[
-- Menu item
--]]

setup_menu = function()
  display_menu = hs.menubar.new(true, "display.lua")
    :setTooltip("display.lua")
    :setIcon("resources/display.png")
    :setMenu(get_menu)
end

--- Create the menu options at a given time
get_menu = function()
  local menu = {}

  -- Add "show all" option
  local item = {
    title = "Show All",
    fn = function() showAll = not showAll end,
    checked = showAll
  }
  table.insert(menu, item)

  -- Add resolutions
  local resolutions = get_resolutions(hs.screen.mainScreen(), showAll)
  for key, res in pairs(resolutions) do
    local item = {
      title = res.desc,
      fn = function() change_resolution(res) end,
      checked = is_current_resolution(res)
    }
    table.insert(menu, item)
  end
  return menu
end

--- Check if given resolution table is currently us =ed
is_current_resolution = function(res)
  local current = hs.screen.mainScreen():currentMode()
  if (type(res) == "table") then
     return res.w == current.w and
        res.h == current.h and
        res.freq == current.freq and
        res.scale == current.scale and
        res.depth == current.depth
  else
     return current.desc == res
  end
end

get_resolution = function(desc)
   local resolutions = get_resolutions(hs.screen.mainScreen(), true)
   for i, res in ipairs(resolutions) do
      if res.desc == desc then
         return res
      end
   end
   return nil
end

--[[
-- Hooks
--]]

--- Change resolution from an table from `resolutions` table
change_resolution = function(res)
  local success = hs.screen.mainScreen():setMode(res.w, res.h, res.scale, res.freq, res.depth)
  if not success then
    alert.show("Failed to change resolution")
  end
end

--[[
-- Main
--]]

setup_menu()

--[[
-- Exported Interface
--]]

local exports = {}

-- List favorited resolutions as string
exports.list_resolutions = function()
   local results = nil
   local resolutions = get_resolutions(hs.screen.mainScreen(), false)
   for i, res in ipairs(resolutions) do
      if is_current_resolution(res) then
         res.desc = res.desc .. ' (current)'
      end
      if results then
         results = results .. '\n' .. res.desc
      else
         results = res.desc
      end
      ::continue::
   end
   return results
end


-- Select resolution
exports.select_resolution = function(res_desc)
   local res = get_resolution(res_desc)
   if res then
      change_resolution(res)
   end
end

return exports
