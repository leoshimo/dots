-- terminal.lua
-- Automation for managing terminal

local TERMINAL_BUNDLE_ID = "com.apple.Terminal"

--- Whether or not Terminal is currently frontmost
-- app:     An `hs.application`
local function isTerminal(app)
  return app:bundleID() == TERMINAL_BUNDLE_ID
end

--- Toggle visibility of terminal
local function toggleTerminal()
  app = hs.application.frontmostApplication()
  if (isTerminal(app)) then
    app:hide()
  else
    hs.application.launchOrFocusByBundleID(TERMINAL_BUNDLE_ID)
  end
end

--- Terminal hotkey
-- HYPER-O: Move focused window to other display
local HYPER = {"ctrl", "cmd"}
hs.hotkey.bind(HYPER, 't', toggleTerminal)

