-- clean-keyboard.lua

local M = {}

M.keyboard_locked = false

M.lock_keyboard = function()
	if not M.keyboard_locked then
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
	else
		M.tap:stop()
		M.sys_tap:stop()
		M.tap = nil
		M.sys_tap = nil
		M.keyboard_locked = false
		hs.alert.show("Keyboard Unlocked 🔓")
	end
end

return M
