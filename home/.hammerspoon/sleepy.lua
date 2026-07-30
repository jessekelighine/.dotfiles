-------------------------------------------------------------------------------
--- File: sleepy.lua
--- Author: Jesse C. Chen
--- "License": Free to use, copy, modify, and distribute. Provided "as is",
--- without warranty of any kind whatsoever.
-------------------------------------------------------------------------------
---
--- Controls macOS system sleep and display sleep independently. System sleep
--- uses `pmset` and can prevent a Mac from sleeping with its lid closed;
--- display sleep uses Hammerspoon's own hs.caffeinate module.
---
--- A note on terminology: "caffed" means that the system or display is
--- prevented from sleeping, while "sleepy" means that it is allowed to
--- sleep.
---
--- The menubar combines both states:
---   * 🫪/😴: system caffed/sleepy
---   * 🌕/🌘: display caffed/sleepy
---
--- Usage Example:
---   local sleepy = require "sleepy"
---   hs.hotkey.bind({ "cmd", "alt" }, "S", sleepy.toggleSystem)
---   hs.hotkey.bind({ "cmd", "alt" }, "D", sleepy.toggleDisplay)
---   sleepy.enableMenubar()

local symbol_system_caffed    = "🫪"
local symbol_system_sleepy    = "😴"
local symbol_display_caffed   = "🌕"
local symbol_display_sleepy   = "🌘"
local message_system_caffed   = symbol_system_caffed  .. " System stays awake"
local message_system_sleepy   = symbol_system_sleepy  .. " System can sleep"
local message_display_caffed  = symbol_display_caffed .. " Display stays awake"
local message_display_sleepy  = symbol_display_sleepy .. " Display can sleep"

local sleepy = {}
local menubar = nil

function sleepy.isSystemCaffed()
    local output = hs.execute("/usr/bin/pmset -g")
    return output:match("SleepDisabled%s+1") ~= nil
end

function sleepy.isDisplayCaffed()
	return hs.caffeinate.get("displayIdle")
end

local function updateMenubar()
	if not menubar then return end
	local system_caffed  = sleepy.isSystemCaffed()
	local display_caffed = sleepy.isDisplayCaffed()
	local system_symbol   = system_caffed  and symbol_system_caffed   or symbol_system_sleepy
	local system_message  = system_caffed  and message_system_caffed  or message_system_sleepy
	local display_symbol  = display_caffed and symbol_display_caffed  or symbol_display_sleepy
	local display_message = display_caffed and message_display_caffed or message_display_sleepy
	menubar:setTitle(system_symbol .. display_symbol)
	menubar:setTooltip(system_message .. "\n" .. display_message)
end

function sleepy.setSystem(caffed)
	local value = caffed and "1" or "0"
	local shell_command = "sudo pmset -a disablesleep " .. value
	local apple_script = 'do shell script "' .. shell_command .. '"'
	--- Alternative: Use Applescript to envoke administrator privileges
	---   local shell_command = "pmset -a disablesleep " .. value
	---   local apple_script = 'do shell script "' .. shell_command .. '" with administrator privileges'
	local success = hs.osascript.applescript(apple_script)
	if success then updateMenubar() end
	return success
end

function sleepy.toggleSystem()
	local caffed = sleepy.isSystemCaffed()
	return sleepy.setSystem(not caffed)
end

function sleepy.toggleDisplay(show_message)
	show_message = show_message or false
	local caffed = hs.caffeinate.toggle("displayIdle")
	if caffed == nil then return nil end
	updateMenubar()
	return caffed
end

function sleepy.enableMenubar()
	if menubar then return menubar end
	menubar = hs.menubar.new()
	menubar:autosaveName("sleepy")
	menubar:setMenu(
		function()
			return {
				{
					title = "System Sleepy",
					checked = not sleepy.isSystemCaffed(),
					fn = sleepy.toggleSystem,
				},
				{
					title = "Display Sleepy",
					checked = not sleepy.isDisplayCaffed(),
					fn = sleepy.toggleDisplay,
				},
			}
		end
	)
	updateMenubar()
	return menubar
end

function sleepy.disableMenubar()
	if menubar then
		menubar:delete()
		menubar = nil
	end
end

return sleepy
