-- clean-keyboard.lua

local M = {}

local swallowEvent = function()
	return true
end

M.lock_keyboard = function()
	M.tap = hs.eventtap.new(
		{
			hs.eventtap.event.types.keyDown,
			hs.eventtap.event.types.keyUp,
			hs.eventtap.event.types.flagsChanged
		},
		swallowEvent
	)
	M.sys_tap = hs.eventtap.new(
		{ hs.eventtap.event.types.systemDefined },
		swallowEvent
	)
	M.tap:start()
	M.sys_tap:start()
	hs.alert.show("Keyboard Locked 🔒")
end

return M
