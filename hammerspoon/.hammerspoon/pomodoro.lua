-- pomodoro.lua
-- Pomodoro timer supporting:
--  Menu bar UI
--  URL driven events, e.g.
--    hammerspoon://pomodoro?action=start&duration=25
--    hammerspoon://pomodoro?action=pause

--[[
-- Dependencies
--]]

-- Dependency implementing `show(message)`
local alert = require "alert"

--[[
-- State
--]]

local pomodoroMenu                                      -- menu item
local tick, start, pause, resume, updateUI, getMenu     -- functions
local remaining = 0                                     -- seconds left in timer
local timer = hs.timer.new(1, function() tick() end)    -- global timer

--[[
-- Menu Bar
--]]

--- Setup menu bar item for pomodoro
setupMenu = function()
  pomodoroMenu = hs.menubar.new()
  pomodoroMenu:setTooltip("pomodoro.lua")
  pomodoroMenu:setIcon("resources/pomodoro.png")
  pomodoroMenu:setMenu(getMenu)
end

--- Get menu items for pomodoro
getMenu = function()
  if timer:running() then
    return {
      {title = "Pause", fn = pause},
      {title = "Reset", fn = reset},
    }
  elseif remaining > 0 then
    return {
      {title = "Resume", fn = resume},
      {title = "Reset", fn = reset},
    }
  else -- timer is not running at all
    return {
      {title = "Start 25", fn = function() start(25) end},
      {title = "Start 5", fn = function() start(5) end},
    }
  end
end

--[[
-- URL Handling
--]]

--- Handle an incoming URL event
-- Parameters
--  action:     Action run - start, resume, pause, reset
--  duration:   Optinal timer duration in minutes
handleUrlEvent = function(eventName, params)
  -- Map action to callbacks
  local actionMap = {}
  actionMap["start"] = start
  actionMap["resume"] = resume
  actionMap["pause"] = pause
  actionMap["reset"] = reset

  if not params.action and not actionMap[params.action] then return end

  actionMap[params.action]()
end

--- Setup URL Event handling
setupUrlEvents = function()
  hs.urlevent.bind('pomodoro', handleUrlEvent)
end


--[[
-- Events
--]]

--- Runs each cycle of timer
tick = function()
  if not timer:running() then return end
  remaining = remaining - 1
  updateUI()
  if remaining <= 0 then
    alert.show("Pomodoro Done")
    pause()
  end
end

--- Update menu bar UI to current time remaining
-- Shows icon when not running
updateUI = function()
  local min = math.floor(remaining / 60)
  local sec = remaining - (min * 60)
  local time = string.format("%02d:%02d", min, sec)
  if remaining > 0 then
    pomodoroMenu:setTitle(time)
    pomodoroMenu:setIcon(nil)
  else
    pomodoroMenu:setTitle(nil)
    pomodoroMenu:setIcon("resources/pomodoro.png")
  end
end

--- Start a pomodoro timer of given minutes
--  minutes:        Optional timer duration in minutes.
start = function(minutes)
  minutes = minutes or 25     -- default to 25
  if timer:running() then return end
  remaining = minutes * 60
  updateUI()
  timer:start()
end

--- Pause a running timer
pause = function()
  timer:stop()
  updateUI()
end

--- Reset currently running timer to 0
reset = function()
  pause()
  remaining = 0
  updateUI()
end

--- Resume a paused timer
resume = function()
  timer:start()
  updateUI()
end

--[[
-- Run
--]]

setupMenu()
setupUrlEvents()
