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
--- prevented from sleeping, while "sleepy" means that it is allowed to sleep.
---
--- Usage Example:
---   local sleepy = require "sleepy"
---   hs.hotkey.bind({ "cmd", "alt" }, "S", sleepy.toggleSystem)
---   hs.hotkey.bind({ "cmd", "alt" }, "D", sleepy.toggleDisplay)
---   sleepy.enableMenubar()

local CAFFED = true
local SLEEPY = false

local menubar = nil

local symbol = {
	system  = {
		[CAFFED] = "🫪",
		[SLEEPY] = "😴",
	},
	display = {
		[CAFFED] = "🌕",
		[SLEEPY] = "🌘",
	},
}

local message = {
	system = {
		[CAFFED] = symbol.system[CAFFED] .. " System stays awake",
		[SLEEPY] = symbol.system[SLEEPY] .. " System can sleep",
	},
	display = {
		[CAFFED] = symbol.display[CAFFED] .. " Display stays awake",
		[SLEEPY] = symbol.display[SLEEPY] .. " Display can sleep",
	},
}

local M = {
	use_sudo = true,
	verbose = true,
}

function M.getSystemState()
    local output = hs.execute("pmset -g")
    return output:match("SleepDisabled%s+1") ~= nil
end

function M.getDisplayState()
	return hs.caffeinate.get("displayIdle")
end

local updateMenubar = function()
	if not menubar then return end
	local system_state    = M.getSystemState()
	local display_state   = M.getDisplayState()
	local system_symbol   = symbol.system[system_state]
	local system_message  = message.system[system_state]
	local display_symbol  = symbol.display[display_state]
	local display_message = message.display[display_state]
	menubar:setTitle(system_symbol .. display_symbol)
	menubar:setTooltip(system_message .. "\n" .. display_message)
end

local setSystemState = function(state)
	local shell_command = "pmset -a disablesleep " .. (state and "1" or "0")
	local apple_script = 'do shell script ' .. (
		M.use_sudo and
		( '"sudo ' .. shell_command .. '"' ) or
		( '"' .. shell_command .. '" with administrator privileges' )
	)
	return hs.osascript.applescript(apple_script)
end

function M.toggleSystem()
	local state = M.getSystemState()
	local new_state = not state
	local success = setSystemState(new_state)
	if not success then return nil end
	if menubar then updateMenubar() end
	if M.verbose then
		hs.alert.closeAll(0)
		hs.alert.show(message.system[new_state])
	end
	return new_state
end

function M.toggleDisplay()
	local new_state = hs.caffeinate.toggle("displayIdle")
	if new_state == nil then return nil end
	if menubar then updateMenubar() end
	if M.verbose then
		hs.alert.closeAll(0)
		hs.alert.show(message.display[new_state])
	end
	return new_state
end

function M.enableMenubar()
	if menubar then return menubar end
	menubar = hs.menubar.new()
	menubar:autosaveName("sleepy")
	menubar:setMenu(
		function()
			return {
				{
					title = "System Sleepy",
					checked = not M.getSystemState(),
					fn = M.toggleSystem,
				},
				{
					title = "Display Sleepy",
					checked = not M.getDisplayState(),
					fn = M.toggleDisplay,
				},
			}
		end
	)
	updateMenubar()
	return menubar
end

function M.disableMenubar()
	if not menubar then return end
	menubar:delete()
	menubar = nil
end

return M
