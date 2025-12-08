-- clean-keyboard.lua

local M = {}

M.lock_keyboard = function()
	M.tap = hs.eventtap.new(
		{
			hs.eventtap.event.types.keyDown,
			hs.eventtap.event.types.keyUp,
			hs.eventtap.event.types.flagsChanged
		},
		function(event) return true end
	)
	M.sys_tap = hs.eventtap.new(
		{ hs.eventtap.event.types.systemDefined },
		function(event) return true end
	)
	M.tap:start()
	M.sys_tap:start()
	M.keyboard_locked = true
	hs.alert.show("Keyboard Locked 🔒")
end

return M
