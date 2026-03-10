-- app-manager.lua

local M = {}

M.lauch_focus_or_rotate = function(app_name)
	local window = hs.window.focusedWindow()
	if window and window:application():name() == app_name then
		local app_windows = hs.application.get(app_name):allWindows()
		if #app_windows > 0 then
			app_windows[#app_windows]:focus()
			return 0
		end
	end
	hs.application.launchOrFocus(app_name)
end

return M
