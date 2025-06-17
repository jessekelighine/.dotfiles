-- wifi-menubar.lua

local M = {}

M.wifi_interface = "en0"

M.wifi_menubar = hs.menubar.new()

-- This keeps the menuar in the same position after a restart
M.wifi_menubar:autosaveName("wifi_menubar")

M.wifi_menubar:setClickCallback(function()
	local wifi_settings = "x-apple.systempreferences:com.apple.wifi-settings-extension"
	local command = "open " .. wifi_settings
	hs.execute(command)
end)

local wifi_set_display_name = function()
	local wifi_name = hs.wifi.currentNetwork(M.wifi_interface)
	if wifi_name then
		local max_display_length = 10
		if string.len(wifi_name) > max_display_length then
			wifi_name = string.sub(wifi_name, 1, max_display_length)
			wifi_name = string.gsub(wifi_name, "...$", "...")
		end
		M.wifi_menubar:setTitle(wifi_name)
	else
		M.wifi_menubar:setTitle("¯\\_(ツ)_/¯")
	end
end

M.wifi_watcher = hs.wifi.watcher.new(wifi_set_display_name):start()

wifi_set_display_name()

return M
