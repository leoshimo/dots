--
-- jira.lua - Hammerspoon utilities for Jira
--

local alert = require "alert"

-- utils.lua
function currentSelection()
   local elem=hs.uielement.focusedElement()
   local selection=nil
   if elem then
      selection = elem:selectedText()
   end
   if (not selection) or (selection == "") then
      hs.eventtap.keyStroke({"cmd"}, "c")
      hs.timer.usleep(20000) -- wait keyStroke
      selection = hs.pasteboard.getContents()
   end
   return (selection or "")
end

-- Bind CMD-SHIFT-X to Open in Jira
hs.hotkey.bind({'cmd', 'shift'}, 'x', function()
  local sel = currentSelection();
  local _, status = hs.execute('open_jira ' .. "\"" .. sel .. "\"", true)
  if not status then
    alert.show("Failed to open Jira")
  end
end)
