-- window.lua
-- Window management

local HYPER = {"ctrl", "cmd"}
hs.loadSpoon("MiroWindowsManager")
hs.window.animationDuration = 0.0

-- HYPER-HJKL to move. HYPER-c to center
local windowManager = spoon.MiroWindowsManager
windowManager:bindHotkeys({
  up          = {HYPER, "k"},
  right       = {HYPER, "l"},
  down        = {HYPER, "j"},
  left        = {HYPER, "h"},
  fullscreen  = {HYPER, "c"},
})

windowManager.sizes = {2, 3, 4, 3/2, 4/3}

-- Given a window, move it to the next screen preserving ratio
local moveWindowToNextScreen = function(win)
  local screen = win:screen()
  local unitRect = win:frame():toUnitRect(screen:frame())
  win:move(unitRect, screen:next(), true, 0)
end

-- HYPER-O: Move focused window to other display
hs.hotkey.bind(HYPER, 'o', function()
  local win = hs.window.focusedWindow()
  moveWindowToNextScreen(win)
end)

-- HYPER-R: Rotate ALL windows across all screens
hs.hotkey.bind(HYPER, 'r', function()
  local windows = hs.window.allWindows()
  for i = 1, #windows do
    moveWindowToNextScreen(windows[i])
  end
end)

--- Window Focus
local function changeFocusForKey(key)
  local window = hs.window.focusedWindow()
  if (not window) then
    return
  end
  if (key == "h") then
    window:focusWindowWest(nil, true)
  elseif (key == 'j') then
    window:focusWindowSouth(nil, true)
  elseif (key == 'k') then
    window:focusWindowNorth(nil, true)
  elseif (key == 'l') then
    window:focusWindowEast(nil, true)
  end
end
FOCUS_HYPER={"ctrl", "cmd", "shift"}
hs.hotkey.bind(FOCUS_HYPER, "h", function()
  changeFocusForKey("h")
end)
hs.hotkey.bind(FOCUS_HYPER, "j", function()
  changeFocusForKey("j")
end)
hs.hotkey.bind(FOCUS_HYPER, "k", function()
  changeFocusForKey("k")
end)
hs.hotkey.bind(FOCUS_HYPER, "l", function()
  changeFocusForKey("l")
end)

